# coding:utf8
# author：GXR
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, FileField, TextAreaField
from wtforms.validators import DataRequired, EqualTo, Email, Regexp, ValidationError
from app.models import User
from flask import session


# 会员注册表单
class RegistForm(FlaskForm):
    name = StringField(
        label='昵称',
        validators=[
            DataRequired('请输入昵称！')
        ],
        description='昵称',
        render_kw={
            'class': 'form-control',
            'placeholder': '请输入昵称！',
        }
    )
    email = StringField(
        label='邮箱',
        validators=[
            DataRequired('请输入邮箱！'),
            Email('邮箱格式不正确！')
        ],
        description='邮箱',
        render_kw={
            'class': 'form-control',
            'placeholder': '请输入邮箱！',
        }
    )
    phone = StringField(
        label='手机',
        validators=[
            DataRequired('请输入手机！'),
            Regexp('^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$', message='手机格式不正确！')
        ],
        description='手机',
        render_kw={
            'class': 'form-control',
            'placeholder': '请输入手机！',
        }
    )
    pwd = PasswordField(
        label='密码',
        validators=[
            DataRequired('请输入密码！')
        ],
        description='密码',
        render_kw={
            'class': 'form-control',
            'placeholder': '请输入密码！',
        }
    )
    repwd = PasswordField(
        label='确认密码',
        validators=[
            DataRequired('请输入确认密码！'),
            EqualTo('pwd', message='两次密码不一致！')
        ],
        description='确认密码',
        render_kw={
            'class': 'form-control',
            'placeholder': '请输入确认密码！',
        }
    )
    submit = SubmitField(
        '注册',
        render_kw={
            'class': 'btn btn-lg btn-success btn-block'
        }
    )

    def validate_name(self, field):
        name = field.data
        user = User.query.filter_by(name=name).count()
        if user == 1:
            raise ValidationError('昵称已存在！')

    def validate_email(self, field):
        email = field.data
        user = User.query.filter_by(email=email).count()
        if user == 1:
            raise ValidationError('邮箱已存在！')

    def validate_phone(self, field):
        phone = field.data
        user = User.query.filter_by(phone=phone).count()
        if user == 1:
            raise ValidationError('手机已存在！')


# 会员登录表单
class LoginForm(FlaskForm):
    name = StringField(
        label='账号',
        validators=[
            DataRequired('请输入账号！')
        ],
        description='账号',
        render_kw={
            'class': 'form-control',
            'placeholder': '请输入账号！',
        }
    )
    pwd = PasswordField(
        label='密码',
        validators=[
            DataRequired('请输入密码！')
        ],
        description='密码',
        render_kw={
            'class': 'form-control',
            'placeholder': '请输入密码！',
        }
    )
    submit = SubmitField(
        '登陆',
        render_kw={
            'class': 'btn btn-lg btn-primary btn-block'
        }
    )


# 会员信息修改表单
class UserdetailForm(FlaskForm):
    name = StringField(
        label='昵称',
        validators=[
            DataRequired('请输入昵称！')
        ],
        description='昵称',
        render_kw={
            'class': 'form-control',
            'placeholder': '请输入昵称！',
        }
    )
    email = StringField(
        label='邮箱',
        validators=[
            DataRequired('请输入邮箱！'),
            Email('邮箱格式不正确！')
        ],
        description='邮箱',
        render_kw={
            'class': 'form-control',
            'placeholder': '请输入邮箱！',
        }
    )
    phone = StringField(
        label='手机',
        validators=[
            DataRequired('请输入手机！'),
            Regexp('^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$', message='手机格式不正确！')
        ],
        description='手机',
        render_kw={
            'class': 'form-control',
            'placeholder': '请输入手机！',
        }
    )
    face = FileField(
        label='头像',
        validators=[
            DataRequired('请输入头像！'),
        ],
        description='头像',
    )
    info = TextAreaField(
        label='简介',
        validators=[
            DataRequired('请输入简介！')
        ],
        description='简介',
        render_kw={
            'class': 'form-control',
            'rows': '10',
        }
    )
    submit = SubmitField(
        '保存修改',
        render_kw={
            'class': 'btn btn-success'
        }
    )


# 会员修改密码表单
class PwdForm(FlaskForm):
    old_pwd = PasswordField(
        label='旧密码',
        validators=[
            DataRequired('请输入旧密码！')
        ],
        description='旧密码',
        render_kw={
            'class': 'form-control',
            'placeholder': '请输入旧密码！',
        }
    )
    new_pwd = PasswordField(
        label='新密码',
        validators=[
            DataRequired('请输入新密码！')
        ],
        description='新密码',
        render_kw={
            'class': 'form-control',
            'placeholder': '请输入新密码！',
        }
    )
    submit = SubmitField(
        '修改密码',
        render_kw={
            'class': 'btn btn-success',
        }
    )

    def validate_old_pwd(self, field):
        name = session['user']
        pwd = field.data
        user = User.query.filter_by(name=name).first()
        if not user.check_pwd(pwd):
            raise ValidationError('旧密码错误！')


# 会员评论表单
class CommentForm(FlaskForm):
    content = TextAreaField(
        label='内容',
        validators=[
            DataRequired('请输入内容！')
        ],
        description='内容',
        render_kw={
            'id': 'input_content',
            'rows': '10',
        }
    )
    submit = SubmitField(
        '提交评论',
        render_kw={
            'class': 'btn btn-success',
        }
    )
