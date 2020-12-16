# coding:utf8
# author：GXR
from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
from flask_redis import FlaskRedis
import os
app = Flask(__name__)
app.debug = True

# 连接mysql
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:1111@127.0.0.1:3306/goodsmovie'
# 设置成True，SQLAlchemy将会追踪对象的修改并且发送信号。这需要额外的内存，如果不必要的可以禁用它
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
# 连接Redis
app.config["REDIS_URL"] = "redis://127.0.0.1:6379/0"
# 跨站伪造请求验证
app.config['SECRET_KEY'] = '67b3ff8f-4922-4b5d-a41d-2d26aaa2146e'
# 电影路径
app.config['MOVIE_DIR'] = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'static/uploads/movie/')
# 电影logo路径
app.config['LOGO_DIR'] = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'static/uploads/logo/')
# 预告路径
app.config['PREVIEW_DIR'] = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'static/uploads/preview/')
# 会员头像路径
app.config['FACE_DIR'] = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'static/uploads/face/')
# 实例化mysql对象
db = SQLAlchemy(app)
# 实例化redis对象
rd = FlaskRedis(app)

from app.home import home as home_blueprint
from app.admin import admin as admin_blueprint

app.register_blueprint(home_blueprint)
app.register_blueprint(admin_blueprint, url_prefix='/admin')


@app.errorhandler(404)
def page_not_found(error):
    return render_template('404.html'), 404
