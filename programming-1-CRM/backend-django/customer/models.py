from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import gettext as _
from django.utils import timezone


class Customer(models.Model):
    name = models.CharField(max_length=50)

