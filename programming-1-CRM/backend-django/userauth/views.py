from django.contrib.auth import authenticate
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.authtoken.models import Token

from .serializer import *

class RegisterAPI(APIView):
    def post(self, request):
        serializer = RegisterSerializer(data = request.data)

        if not serializer.is_valid():
            return Response({'message' : serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
        
        serializer.save()

        return Response({'message' : 'User created'}, status=status.HTTP_201_CREATED)

class LoginAPI(APIView):
    def post(self, request):
        data = request.data
        serializer = LoginSerializer(data = data)

        if not serializer.is_valid():
            return Response({'message' : serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
        
        user = authenticate(username = data['username'], password = data['password'])

        if not user:
            return Response({'message' : 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)

        token, _  = Token.objects.get_or_create(user = user)

        return Response({'message' : 'Login success', 'token' : str(token)}, status=status.HTTP_200_OK)



