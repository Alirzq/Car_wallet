from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from .models import Bookmark

@login_required
def add_bookmark(request):
    if request.method == 'POST':
        content = request.POST.get('content')
        Bookmark.objects.create(user=request.user, content=content)
        return redirect('account')
    return redirect('home')

@login_required
def delete_bookmark(request, bookmark_id):
    bookmark = Bookmark.objects.get(id=bookmark_id, user=request.user)
    bookmark.delete()
    return redirect('account')

@login_required
def account(request):
    bookmarks = Bookmark.objects.filter(user=request.user).order_by('-created_at')
    return render(request, 'account.html', {'bookmarks': bookmarks})