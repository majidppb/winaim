from django.urls import path
from . import views

urlpatterns = [
    path('customers', views.CustomerAPI.as_view()),
    path('interactions', views.InteractionAPI.as_view()),

]