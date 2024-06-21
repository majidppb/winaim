from django.contrib import admin

from .models import *

class InteractionAdmin(admin.ModelAdmin):
    list_display = ['salesman', 'customer', 'mode','date']
    readonly_fields = ['salesman', 'customer', 'date']


admin.site.register(Customer)
admin.site.register(Interaction, InteractionAdmin)