# coding:utf8
# author：GXR
from werkzeug.security import check_password_hash
from datetime import datetime
from app import db


# # 手动运行models.py建表
# from flask import Flask
# from flask_sqlalchemy import SQLAlchemy
# from werkzeug.security import generate_password_hash
# app = Flask(__name__)
# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:1111@127.0.0.1:3306/goodsmovie'
# app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
# db = SQLAlchemy(app)


# 会员模型
class User(db.Model):
    __tablename__ = 'user'
    # 编号
    id = db.Column(db.Integer, primary_key=True)
    # 昵称
    name = db.Column(db.String(100), unique=True)
    # 密码
    pwd = db.Column(db.String(100))
    # 邮箱
    email = db.Column(db.String(100), unique=True)
    # 手机
    phone = db.Column(db.String(11), unique=True)
    # 简介
    info = db.Column(db.Text)
    # 头像
    face = db.Column(db.String(255), unique=True)
    # 注册时间(index是索引)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)
    # 会员唯一标识符
    uuid = db.Column(db.String(255), unique=True)
    # 会员登录日志外键关系关联
    userlogs = db.relationship('Userlog', backref='user')
    # 评论外键关系关联
    comments = db.relationship('Comment', backref='user')
    # 电影收藏外键关系关联
    moviecols = db.relationship('Moviecol', backref='user')

    # 需要显示一个对象在屏幕上时，将这个对象的属性或者是方法整理成一个可以打印输出的格式
    def __repr__(self):
        return '<User %r>' % self.name

    # 用于验证经过generate_password_hash哈希的密码
    def check_pwd(self, pwd):
        return check_password_hash(self.pwd, pwd)


# 会员登陆日志模型
class Userlog(db.Model):
    __tablename__ = 'userlog'
    # 编号
    id = db.Column(db.Integer, primary_key=True)
    # 所属会员
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    # 登陆IP
    ip = db.Column(db.String(100))
    # 登陆时间(index是索引)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    # 需要显示一个对象在屏幕上时，将这个对象的属性或者是方法整理成一个可以打印输出的格式
    def __repr__(self):
        return '<Userlog %r>' % self.id


# 电影标签模型
class Tag(db.Model):
    __tablename__ = 'tag'
    # 编号
    id = db.Column(db.Integer, primary_key=True)
    # 标题
    name = db.Column(db.String(100), unique=True)
    # 添加时间(index是索引)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)
    # 电影外键关系关联
    movies = db.relationship('Movie', backref='tag')

    # 需要显示一个对象在屏幕上时，将这个对象的属性或者是方法整理成一个可以打印输出的格式
    def __repr__(self):
        return '<Tag %r>' % self.name


# 电影模型
class Movie(db.Model):
    __tablename__ = 'movie'
    # 编号
    id = db.Column(db.Integer, primary_key=True)
    # 标题
    title = db.Column(db.String(255), unique=True)
    # 地址
    url = db.Column(db.String(255), unique=True)
    # 简介
    info = db.Column(db.Text)
    # 封面
    logo = db.Column(db.String(255), unique=True)
    # 星级
    star = db.Column(db.SmallInteger)
    # 播放量
    playnum = db.Column(db.BigInteger)
    # 评论量
    commentnum = db.Column(db.BigInteger)
    # 所属标签
    tag_id = db.Column(db.Integer, db.ForeignKey('tag.id'))
    # 上映地区
    area = db.Column(db.String(255))
    # 片长
    length = db.Column(db.String(100))
    # 上映时间
    release_time = db.Column(db.Date)
    # 添加时间(index是索引)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)
    # 评论外键关系关联
    comments = db.relationship('Comment', backref='movie')
    # 电影收藏外键关系关联
    moviecols = db.relationship('Moviecol', backref='movie')

    # 需要显示一个对象在屏幕上时，将这个对象的属性或者是方法整理成一个可以打印输出的格式
    def __repr__(self):
        return '<Movie %r>' % self.title


# 电影预告模型
class Preview(db.Model):
    __tablename__ = 'preview'
    # 编号
    id = db.Column(db.Integer, primary_key=True)
    # 标题
    title = db.Column(db.String(255), unique=True)
    # 封面
    logo = db.Column(db.String(255), unique=True)
    # 添加时间(index是索引)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    # 需要显示一个对象在屏幕上时，将这个对象的属性或者是方法整理成一个可以打印输出的格式
    def __repr__(self):
        return '<Preview %r>' % self.title


# 电影评论模型
class Comment(db.Model):
    __tablename__ = 'comment'
    # 编号
    id = db.Column(db.Integer, primary_key=True)
    # 内容
    content = db.Column(db.Text)
    # 所属电影
    movie_id = db.Column(db.Integer, db.ForeignKey('movie.id'))
    # 所属会员
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    # 添加时间(index是索引)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    # 需要显示一个对象在屏幕上时，将这个对象的属性或者是方法整理成一个可以打印输出的格式
    def __repr__(self):
        return '<Comment %r>' % self.id


# 电影收藏模型
class Moviecol(db.Model):
    __tablename__ = 'moviecol'
    # 编号
    id = db.Column(db.Integer, primary_key=True)
    # 所属电影
    movie_id = db.Column(db.Integer, db.ForeignKey('movie.id'))
    # 所属会员
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    # 添加时间(index是索引)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    # 需要显示一个对象在屏幕上时，将这个对象的属性或者是方法整理成一个可以打印输出的格式
    def __repr__(self):
        return '<Moviecol %r>' % self.id


# 管理权限模型
class Auth(db.Model):
    __tablename__ = 'auth'
    # 编号
    id = db.Column(db.Integer, primary_key=True)
    # 名称
    name = db.Column(db.String(100), unique=True)
    # 地址
    url = db.Column(db.String(255), unique=True)
    # 添加时间(index是索引)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    # 需要显示一个对象在屏幕上时，将这个对象的属性或者是方法整理成一个可以打印输出的格式
    def __repr__(self):
        return '<Auth %r>' % self.name


# 管理角色模型
class Role(db.Model):
    __tablename__ = 'role'
    # 编号
    id = db.Column(db.Integer, primary_key=True)
    # 名称
    name = db.Column(db.String(100), unique=True)
    # 权限列表
    auths = db.Column(db.String(600))
    # 添加时间(index是索引)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)
    # 管理员外键关系关联
    admins = db.relationship('Admin', backref='role')

    # 需要显示一个对象在屏幕上时，将这个对象的属性或者是方法整理成一个可以打印输出的格式
    def __repr__(self):
        return '<Role %r>' % self.name


# 管理员模型
class Admin(db.Model):
    __tablename__ = 'admin'
    # 编号
    id = db.Column(db.Integer, primary_key=True)
    # 管理员账号
    name = db.Column(db.String(100), unique=True)
    # 管理员密码
    pwd = db.Column(db.String(100))
    # 是否为超级管理员，0为超级管理员
    is_super = db.Column(db.SmallInteger)
    # 所属角色
    role_id = db.Column(db.Integer, db.ForeignKey('role.id'))
    # 添加时间(index是索引)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)
    # 管理员登录日志外键关系关联
    adminlogs = db.relationship('Adminlog', backref='admin')
    # 管理员操作日志外键关系关联
    oplogs = db.relationship('Oplog', backref='admin')

    # 需要显示一个对象在屏幕上时，将这个对象的属性或者是方法整理成一个可以打印输出的格式
    def __repr__(self):
        return '<Admin %r>' % self.name

    # 用于验证经过generate_password_hash哈希的密码
    def check_pwd(self, pwd):
        return check_password_hash(self.pwd, pwd)


# 管理员操作日志模型
class Oplog(db.Model):
    __tablename__ = 'oplog'
    # 编号
    id = db.Column(db.Integer, primary_key=True)
    # 所属管理员
    admin_id = db.Column(db.Integer, db.ForeignKey('admin.id'))
    # 操作IP
    ip = db.Column(db.String(100))
    # 操作原因
    reason = db.Column(db.String(600))
    # 操作时间(index是索引)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    # 需要显示一个对象在屏幕上时，将这个对象的属性或者是方法整理成一个可以打印输出的格式
    def __repr__(self):
        return '<Oplog %r>' % self.id


# 管理员登录日志模型
class Adminlog(db.Model):
    __tablename__ = 'adminlog'
    # 编号
    id = db.Column(db.Integer, primary_key=True)
    # 所属管理员
    admin_id = db.Column(db.Integer, db.ForeignKey('admin.id'))
    # 登陆IP
    ip = db.Column(db.String(100))
    # 登陆时间(index是索引)
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)

    # 需要显示一个对象在屏幕上时，将这个对象的属性或者是方法整理成一个可以打印输出的格式
    def __repr__(self):
        return '<Adminlog %r>' % self.id

# if __name__ == '__main__':
#     db.drop_all()
#     db.create_all()
#     role = Role(
#         name='超级管理员',
#         auths=''
#     )
#     db.session.add(role)
#     db.session.commit()
#     admin = Admin(
#         name='admin',
#         pwd=generate_password_hash('111111'),
#         is_super=0,
#         role_id=1
#     )
#     db.session.add(admin)
#     db.session.commit()
