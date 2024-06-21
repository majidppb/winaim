from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import gettext as _
from django.utils import timezone


class Customer(models.Model):
    name = models.CharField(max_length=50)

interaction_mode = [
    ('ca', 'Call'),
    ('ma', 'E-Mail'),
    ('me', 'Meeting')
]

class Interaction(models.Model):
    salesman = models.ForeignKey(User, on_delete=models.CASCADE, default=None)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, default=None)
    date = models.DateField(default=timezone.now)
    mode = models.CharField(max_length=2, verbose_name=_("Mode of interaction"), default='ca', choices=interaction_mode)
    note = models.CharField(max_length=200)