from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status

from .serializer import *
from .models import *

class CustomerAPI(APIView):
    def get(self, request):
        customers = Customer.objects.all()
        serializer = CustomerSerializer(customers, many=True)
        return Response(serializer.data)
    
    def post(self, request):
        serializer = CustomerSerializer(data = request.data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)

        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
    
    def put(self, request):
        obj = Customer.objects.get(id = request.data['id'])
        serializer = CustomerSerializer(obj, data = request.data, partial = False)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)

        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
    
    def delete(self, request):
        obj = Customer.objects.get(id = request.data['id'])
        obj.delete()

        return Response({'message' : 'Successfully deleted'})

class InteractionAPI(APIView):
    def get(self, request):
        data = Interaction.objects.all()
        serializer = InteractionSerializer(data, many=True)
        return Response(serializer.data)
    
    def post(self, request):
        data = request.data
        data['salesman'] = request.user.id

        serializer = InteractionSerializer(data = data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)

        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
    
    def put(self, request):
        obj = Interaction.objects.get(id = request.data['id'])
        serializer = InteractionSerializer(obj, data = request.data, partial = False)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)

        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
    
    def delete(self, request):
        obj = Interaction.objects.get(id = request.data['id'])
        obj.delete()

        return Response({'message' : 'Successfully deleted'})

