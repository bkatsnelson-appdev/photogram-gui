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

  def update
    id = params.fetch("modify_id")
    image = params.fetch("input_image")
    caption = params.fetch("input_caption")

    photo = Photo.where({ :id => id })[0]
    photo.image = image
    photo.caption = caption

    photo.save

    redirect_to("/photos/" + photo.id.to_s)
  end

  def insert_comment
    photo_id = params.fetch("input_photo_id")
    author_id = params.fetch("input_author_id")
    comment = params.fetch("input_body")

    #photo = Photo.where({ :id => photo_id })[0]

    new_comment = Comment.new
    new_comment.author_id = author_id
    new_comment.photo_id = photo_id
    new_comment.body = comment
    new_comment.save

    redirect_to("/photos/" + photo_id.to_s)
  end
end
