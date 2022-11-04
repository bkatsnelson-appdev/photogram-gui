class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all
    @list_of_photos = matching_photos.order({ :created_at => :desc })
    render({ :template => "photo_templates/index.html.erb" })
  end

  def show
    url_id = params.fetch("path_id")
    matching_photos = Photo.where({ :id => url_id })
    @photo = matching_photos[0]
    render({ :template => "photo_templates/show.html.erb" })
  end

  def delete
    id = params.fetch("path_id")
    photo = Photo.where({ :id => id })[0]
    photo.destroy
    #render({ :template => "photo_templates/delete.html.erb" })
    redirect_to("/photos")
  end

  def insert
    image = params.fetch("query_image")
    caption = params.fetch("query_caption")
    id = params.fetch("query_id")

    new_photo = Photo.new
    new_photo.image = image
    new_photo.caption = caption
    new_photo.owner_id = id

    new_photo.save
    redirect_to("/photos/" + new_photo.id.to_s)
  end
end
