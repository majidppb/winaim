from django.urls import path, include

urlpatterns = [
    path('userauth/', include('userauth.urls')),
] 