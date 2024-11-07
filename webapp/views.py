from django.shortcuts import render

from django.http import HttpResponse


def index(request):
    return render(request, 'index.html')

#define uma view baseada em função.
def ola(request):
    return HttpResponse('Olá Django')

