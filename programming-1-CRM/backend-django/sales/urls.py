from django.urls import path
from . import views

urlpatterns = [
    path('sales', views.SalesAPI.as_view()),
    path('interactions', views.InteractionAPI.as_view()),
]