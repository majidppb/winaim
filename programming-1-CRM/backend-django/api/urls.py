from django.urls import path, include

urlpatterns = [
    path('userauth/', include('userauth.urls')),
    path('customer/', include('customer.urls')),
    path('sales/', include('sales.urls')),

] 