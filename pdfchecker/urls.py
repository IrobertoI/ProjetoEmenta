from django.urls import path
from ..webapp import views
from webapp.views import index, ola 

urlpatter = [
    path('', views.index, name="index"),
    path('ola', ola, name="ola"),
]