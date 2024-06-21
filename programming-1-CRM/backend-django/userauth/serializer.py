from django.contrib.auth.models import User
from rest_framework import serializers

class RegisterSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        if User.objects.filter(username = data['username']).exists():
            raise serializers.ValidationError('Username is taken')
        
        if len(data['password']) < 8:
            raise serializers.ValidationError('Password should be of minimum 8 characters length')
        
        return data
    
    def create(self, validated_data):
        newUser = User.objects.create(username = validated_data['username'])
        newUser.set_password(validated_data['password'])
        newUser.save()
        return validated_data
    
class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()