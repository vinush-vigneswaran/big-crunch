from django.urls import path
from . import views

urlpatterns = [
    path('peek/', views.peek, name='peek'),
]