from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import gettext as _
from django.utils import timezone

from customer.models import Customer

sale_stage = [
    ('co', 'Contact'),
    ('de', 'Demo'),
    ('pr', 'Proposal'),
    ('ne', 'Negotiation'),
    ('wo', 'Sale won'),
    ('po', 'Post sale')
]

class Sale(models.Model):
    salesman = models.ForeignKey(User, on_delete=models.CASCADE, default=None)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, default=None)
    start_date = models.DateField(default=timezone.now)
    stage = models.CharField(max_length=2, verbose_name=_("Stage of sale"), default='co', choices=sale_stage)
    note = models.CharField(max_length=200)

interaction_mode = [
    ('ca', 'Call'),
    ('ma', 'E-Mail'),
    ('me', 'Meeting')
]

class Interaction(models.Model):
    sale = models.ForeignKey(Sale, on_delete=models.CASCADE, default=None)
    date = models.DateField(default=timezone.now)
    mode = models.CharField(max_length=2, verbose_name=_("Mode of interaction"), default='ca', choices=interaction_mode)
    note = models.CharField(max_length=200)