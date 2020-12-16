# coding:utf8
# author：GXR
from flask import Blueprint

admin = Blueprint('admin', __name__)

import app.admin.views
