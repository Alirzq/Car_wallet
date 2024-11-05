from django.urls import path
from . import views

urlpatterns = [
    # ...
    path('add-bookmark/', views.add_bookmark, name='add_bookmark'),
    path('delete-bookmark/<int:bookmark_id>/', views.delete_bookmark, name='delete_bookmark'),
    path('account/', views.account, name='account'),
]