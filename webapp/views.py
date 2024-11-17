from django.shortcuts import render

from django.http import HttpResponse

from django.http import JsonResponse

from django.core.files.storage import FileSystemStorage


def index(request):
    return render(request, 'index.html')

def upload_file(request):
    if request.method == 'POST' and request.FILES['file']:
        file = request.FILES['file']
        fs = FileSystemStorage()  # Gerencia o armazenamento de arquivos
        filename = fs.save(file.name, file)  # Salva o arquivo com o nome original
        file_url = fs.url(filename)  # Gera a URL do arquivo salvo

        return JsonResponse({'message': 'Arquivo enviado com sucesso!', 'file_url': file_url})

    return JsonResponse({'error': 'Não foi possível enviar o arquivo.'}, status=400)