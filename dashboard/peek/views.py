from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from django.conf import settings
from django.conf import settings


# def peek(request):
#   template = loader.get_template('video_tiles.html')
#   return HttpResponse(template.render())

import os

def peek(request):
    videos_dir = os.path.join(settings.MEDIA_ROOT)  # Assuming videos are stored in /media/videos/
    video_files = [f for f in os.listdir(videos_dir) if f.endswith('.mp4')]
    # Generate the relative path from MEDIA_ROOT for each video
    video_urls = ['media/' + file for file in video_files]  # Prepends the 'videos/' directory
    return render(request, 'video_list.html', {'video_files': video_urls})