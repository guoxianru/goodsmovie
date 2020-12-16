# coding:utf8
# author：GXR
from . import home
from flask import render_template, redirect, url_for, flash, session, request, Response
from .forms import RegistForm, LoginForm, UserdetailForm, PwdForm, CommentForm
from app.models import User, Userlog, Comment, Moviecol, Preview, Tag, Movie
from functools import wraps
from werkzeug.security import generate_password_hash
from werkzeug.utils import secure_filename
from pypinyin import lazy_pinyin
from app import db, rd, app
import datetime
import uuid
import json
import os


# 登陆验证装饰器
def user_login_req(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user' not in session:
            return redirect(url_for('home.login', next=request.url))
        return f(*args, **kwargs)

    return decorated_function


# 修改文件名称
# def change_filename(filename):
#     fileinfo = os.path.splitext(filename)
#     filename = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + '_' + uuid.uuid4().hex + fileinfo[-1]
#     return filename


# 会员注册
@home.route('/register/', methods=['GET', 'POST'])
def register():
    form = RegistForm()
    if form.validate_on_submit():
        data = form.data
        user = User(
            name=data['name'],
            email=data['email'],
            phone=data['phone'],
            pwd=generate_password_hash(data['pwd']),
            uuid=uuid.uuid4().hex
        )
        db.session.add(user)
        db.session.commit()
        flash('注册成功！', 'ok')
        return redirect(url_for('home.login'))
    return render_template('home/register.html', form=form)


# 会员登录
@home.route('/login/', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        data = form.data
        user = User.query.filter_by(name=data['name']).first()
        if not user.check_pwd(data['pwd']):
            flash('密码错误！', 'err')
            return redirect(url_for('home.login'))
        session['user'] = user.name
        session['user_id'] = user.id
        userlog = Userlog(
            user_id=user.id,
            ip=request.remote_addr
        )
        db.session.add(userlog)
        db.session.commit()
        flash('登陆成功！', 'ok')
        return redirect(url_for('home.index', page=1))
    return render_template('home/login.html', form=form)


# 会员退出
@home.route('/logout/')
@user_login_req
def logout():
    session.pop('user', None)
    session.pop('user_id', None)
    return redirect(url_for('home.login'))


# 会员中心
@home.route('/user/', methods=['GET', 'POST'])
@user_login_req
def user():
    # 当前登录用户
    if 'user_id' in session:
        user_now = User.query.get(session['user_id'])
    else:
        user_now = ''

    form = UserdetailForm()
    user = User.query.get(session['user_id'])
    form.face.validators = []
    if request.method == 'GET':
        form.name.data = user.name
        form.email.data = user.email
        form.phone.data = user.phone
        form.face.data = user.face
        form.info.data = user.info
    if form.validate_on_submit():
        data = form.data
        # file_face = secure_filename(''.join(lazy_pinyin(form.face.data.filename)))

        if not os.path.exists(app.config['FACE_DIR']):
            os.makedirs(app.config['FACE_DIR'])
            os.chmod(app.config['FACE_DIR'], 'rw')
        # user.face = change_filename(file_face)
        user.face = form.face.data.filename
        form.face.data.save(app.config['FACE_DIR'] + user.face)

        name_count = User.query.filter_by(name=data['name']).count()
        if data['name'] != user.name and name_count == 1:
            flash('昵称已经存在！', 'err')
            return redirect(url_for('home.user'))

        email_count = User.query.filter_by(email=data['email']).count()
        if data['email'] != user.email and email_count == 1:
            flash('邮箱已经存在！', 'err')
            return redirect(url_for('home.user'))

        phone_count = User.query.filter_by(phone=data['phone']).count()
        if data['phone'] != user.phone and phone_count == 1:
            flash('手机已经存在！', 'err')
            return redirect(url_for('home.user'))

        user.name = data['name']
        user.email = data['email']
        user.phone = data['phone']
        user.info = data['info']
        db.session.add(user)
        db.session.commit()
        flash('修改成功！', 'ok')
        return redirect(url_for('home.user'))
    return render_template('home/user.html', form=form, user=user, user_now=user_now)


# 会员修改密码
@home.route('/pwd/', methods=['GET', 'POST'])
@user_login_req
def pwd():
    # 当前登录用户
    if 'user_id' in session:
        user_now = User.query.get(session['user_id'])
    else:
        user_now = ''

    form = PwdForm()
    if form.validate_on_submit():
        data = form.data
        user = User.query.filter_by(name=session['user']).first()
        user.pwd = generate_password_hash(data['new_pwd'])
        db.session.add(user)
        db.session.commit()
        flash('修改密码成功，请重新登录！', 'ok')
        return redirect(url_for('home.logout'))
    return render_template('home/pwd.html', form=form, user_now=user_now)


# 会员评论记录
@home.route('/comments/<int:page>/', methods=["GET"])
@user_login_req
def comments(page=None):
    # 当前登录用户
    if 'user_id' in session:
        user_now = User.query.get(session['user_id'])
    else:
        user_now = ''

    if page is None:
        page = 1
    page_data = Comment.query.filter_by(
        user_id=session['user_id']
    ).order_by(
        Comment.addtime.desc()
    ).paginate(page=page, per_page=20)
    return render_template('home/comments.html', page_data=page_data, user_now=user_now)


# 会员登录日志
@home.route('/loginlog/<int:page>/', methods=["GET"])
@user_login_req
def loginlog(page=None):
    # 当前登录用户
    if 'user_id' in session:
        user_now = User.query.get(session['user_id'])
    else:
        user_now = ''

    if page is None:
        page = 1
    page_data = Userlog.query.filter_by(
        user_id=session['user_id']
    ).order_by(
        Userlog.addtime.desc()
    ).paginate(page=page, per_page=20)
    return render_template('home/loginlog.html', page_data=page_data, user_now=user_now)


# 会员添加收藏电影
@home.route('/moviecol/add/', methods=['GET'])
@user_login_req
def moviecol_add():
    mid = request.args.get('mid', '')
    uid = request.args.get('uid', '')
    moviecol_count = Moviecol.query.filter_by(
        movie_id=int(mid),
        user_id=int(uid)
    ).count()
    if moviecol_count == 1:
        data = dict(ok=0)
    if moviecol_count == 0:
        moviecol = Moviecol(
            movie_id=mid,
            user_id=uid
        )
        db.session.add(moviecol)
        db.session.commit()
        data = dict(ok=1)
    return json.dumps(data)


# 会员收藏电影列表
@home.route('/moviecol/<int:page>/', methods=["GET"])
@user_login_req
def moviecol(page=None):
    # 当前登录用户
    if 'user_id' in session:
        user_now = User.query.get(session['user_id'])
    else:
        user_now = ''

    if page is None:
        page = 1
    page_data = Moviecol.query.filter_by(
        user_id=session['user_id']
    ).order_by(
        Moviecol.addtime.desc()
    ).paginate(page=page, per_page=20)
    return render_template('home/moviecol.html', page_data=page_data, user_now=user_now)


# 首页传参
@home.route('/')
def index_page():
    return redirect(url_for('home.index', page=1))


# 电影首页
@home.route('/<int:page>/', methods=["GET"])
def index(page=None):
    # 当前登录用户
    if 'user_id' in session:
        user_now = User.query.get(session['user_id'])
    else:
        user_now = ''

    # 所有标签
    tag_list = Tag.query.all()
    # 分页数据
    page_data = Movie.query
    # 标签筛选
    tag = request.args.get('tag', 0)
    if int(tag) != 0:
        page_data = page_data.filter_by(tag_id=int(tag))
    # 星级筛选
    star = request.args.get('star', 0)
    if int(star) != 0:
        page_data = page_data.filter_by(star=int(star))
    # 时间筛选
    time = request.args.get('time', 0)
    if int(time) != 0:
        if int(time) == 1:
            page_data = page_data.order_by(
                Movie.addtime.desc()
            )
        else:
            page_data = page_data.order_by(
                Movie.addtime.asc()
            )
    # 播放量筛选
    pnum = request.args.get('pnum', 0)
    if int(pnum) != 0:
        if int(pnum) == 1:
            page_data = page_data.order_by(
                Movie.playnum.desc()
            )
        else:
            page_data = page_data.order_by(
                Movie.playnum.asc()
            )
    # 评论量筛选
    cnum = request.args.get('cnum', 0)
    if int(cnum) != 0:
        if int(cnum) == 1:
            page_data = page_data.order_by(
                Movie.commentnum.desc()
            )
        else:
            page_data = page_data.order_by(
                Movie.commentnum.asc()
            )
    # 分页
    if page is None:
        page = 1
    page_data = page_data.paginate(page=page, per_page=20)
    # URL参数
    p = dict(
        tag=tag,
        star=star,
        time=time,
        pnum=pnum,
        cnum=cnum,
    )
    return render_template('home/index.html', tag_list=tag_list, p=p, page_data=page_data, user_now=user_now)


# 电影预告
@home.route('/animation/')
def animation():
    preview_list = Preview.query.all()
    return render_template('home/animation.html', preview_list=preview_list)


# 电影搜索
@home.route('/search/<int:page>/', methods=["GET"])
def search(page=None):
    # 当前登录用户
    if 'user_id' in session:
        user_now = User.query.get(session['user_id'])
    else:
        user_now = ''
    if page is None:
        page = 1
    key = request.args.get('key', '')
    search_count = Movie.query.filter(
        Movie.title.ilike('%' + key + '%')
    ).count()
    page_data = Movie.query.filter(
        Movie.title.ilike('%' + key + '%')
    ).order_by(
        Movie.addtime.desc()
    ).paginate(page=page, per_page=20)
    page_data.key = key
    return render_template('home/search.html', key=key, page_data=page_data, search_count=search_count,
                           user_now=user_now)


# 电影播放
@home.route('/play/<int:id>/<int:page>/', methods=['GET', 'POST'])
def play(id=None, page=None):
    # 当前登录用户
    if 'user_id' in session:
        user_now = User.query.get(session['user_id'])
    else:
        user_now = ''

    # 按ID获取电影
    movie = Movie.query.get_or_404(id)
    # 分页显示评论
    if page is None:
        page = 1
    page_data = Comment.query.join(
        Movie
    ).join(
        User
    ).filter(
        Movie.id == movie.id,
        User.id == Comment.user_id
    ).order_by(
        Comment.addtime.desc()
    ).paginate(page=page, per_page=20)
    # 进入电影详情页，电影播放量+1
    movie.playnum += 1
    # 添加评论
    form = CommentForm()
    if 'user' in session and form.validate_on_submit():
        data = form.data
        comment = Comment(
            content=data['content'],
            movie_id=movie.id,
            user_id=session['user_id']
        )
        # 保存评论
        db.session.add(comment)
        db.session.commit()
        flash('评论成功！', 'ok')
        # 评论添加成功后，电影评论量+1
        movie.commentnum += 1
        # 保存电影评论量
        db.session.add(movie)
        db.session.commit()
        return redirect(url_for('home.play', id=id, page=1))
    # 保存电影播放量
    db.session.add(movie)
    db.session.commit()
    return render_template('home/play.html', movie=movie, form=form, page_data=page_data, user_now=user_now)


# 弹幕播放
@home.route('/video/<int:id>/<int:page>/', methods=['GET', 'POST'])
def video(id=None, page=None):
    # 当前登录用户
    if 'user_id' in session:
        user_now = User.query.get(session['user_id'])
    else:
        user_now = ''

    # 按ID获取电影
    movie = Movie.query.get_or_404(id)
    # 分页显示评论
    if page is None:
        page = 1
    page_data = Comment.query.join(
        Movie
    ).join(
        User
    ).filter(
        Movie.id == movie.id,
        User.id == Comment.user_id
    ).order_by(
        Comment.addtime.desc()
    ).paginate(page=page, per_page=20)
    # 进入电影详情页，电影播放量+1
    movie.playnum += 1
    # 添加评论
    form = CommentForm()
    if 'user' in session and form.validate_on_submit():
        data = form.data
        comment = Comment(
            content=data['content'],
            movie_id=movie.id,
            user_id=session['user_id']
        )
        # 保存评论
        db.session.add(comment)
        db.session.commit()
        flash('评论成功！', 'ok')
        # 评论添加成功后，电影评论量+1
        movie.commentnum += 1
        # 保存电影评论量
        db.session.add(movie)
        db.session.commit()
        return redirect(url_for('home.video', id=id, page=1))
    # 保存电影播放量
    db.session.add(movie)
    db.session.commit()
    return render_template('home/video.html', movie=movie, form=form, page_data=page_data, user_now=user_now)


# 处理弹幕消息
@home.route("/danmu/", methods=["GET", "POST"])
def danmu():
    # 获取弹幕消息队列
    if request.method == "GET":
        # 用id来获取弹幕消息队列
        id = request.args.get('id')
        # 拼接形成键值用于存放在redis队列中
        key = "movie" + str(id)
        if rd.llen(key):
            msgs = rd.lrange(key, 0, 2999)
            res = {
                "code": 1,
                "danmaku": [json.loads(v) for v in msgs]
            }
        else:
            res = {
                "code": 1,
                "danmaku": []
            }
        resp = json.dumps(res)
    # 添加弹幕
    if request.method == "POST":
        data = json.loads(request.get_data())
        msg = {
            "__v": 0,
            "author": data["author"],
            "time": data["time"],
            "text": data["text"],
            "color": data["color"],
            "type": data['type'],
            "ip": request.remote_addr,
            "_id": datetime.datetime.now().strftime("%Y%m%d%H%M%S") + uuid.uuid4().hex,
            "player": [
                data["player"]
            ]
        }
        res = {
            "code": 1,
            "data": msg
        }
        resp = json.dumps(res)
        # 将添加的弹幕推入redis的队列中
        rd.lpush("movie" + str(data["player"]), json.dumps(msg))
    return Response(resp, mimetype='application/json')
