class PhotosController < ApplicationController
  PAGE_LIMIT = 100
  before_filter :authorize, :except => [:get, :get_thumb]
  layout 'store'

  def index
  end

  def upload
    folder = Dir.new Photo::UPLOAD_FOLDER
    @files = []
    folder.each do |name| 
      full_name = folder.path + name
      if File::file? full_name
        photo = Photo.new
        photo.upload(full_name)
        photo.name = name
        photo.save
        File::delete(full_name)
        @files << photo
      end
    end
    @tags = Photo.tag_counts
  end
  
  def browse
    offset = params[:offset]
    offset ||= 0
    @files = Photo.find(:all, :offset => offset, :limit => PAGE_LIMIT)
    @tags = Photo.tag_counts.sort_by {|e| e.name}
    render :template => 'photos/upload'
  end

  def get
    @img = Photo.find(params[:id])
    send_data(@img.image,
              :filename => @img.name,
              :type => @img.content_type,
              :disposition => "inline")
  end
  
  def get_thumb
    @img = Photo.find(params[:id])
    send_data(@img.thumbnail,
              :filename => @img.name,
              :type => @img.content_type,
              :disposition => "inline")
  end
  
  def add_tag
    tag = params[:tag]
    id = params[:id]
    photo = Photo.find(id)
    photo.tag_list.add(tag)
    photo.save
    render :text => 'ok'
  end
  
  def remove_tag
    tag = params[:tag]
    id = params[:id]
    photo = Photo.find(id)
    photo.tag_list.remove(tag)
    photo.save
    render :text => 'ok'
  end
  
  def filter
    offset = params[:offset]
    offset ||= 0
    tag_list = params[:tag_list]
    if tag_list 
      @files = Photo.find_tagged_with(tag_list, :match_all => true)
    else
      @files = Photo.find(:all, :offset => offset, :limit => PAGE_LIMIT)
    end
    render :partial => 'photo_item', :collection => @files
  end
  
  def delete
    Photo.delete(params[:id])
  end
  
  def select
    @product = Product.find(params[:id])
    offset = params[:offset]
    offset ||= 0
    @files = Photo.find(:all, :offset => offset, :limit => PAGE_LIMIT)
    @tags = Photo.tag_counts
  end
  
  def add_to_product
    photo_id = params[:id]
    product_id = params[:product_id]
    product = Product.find(product_id)
    product.photos << Photo.find(photo_id)
    product.save
  end

  def remove_from_product
    photo_id = params[:id]
    product_id = params[:product_id]
    product = Product.find(product_id)
    product.photos.delete Photo.find(photo_id)
    product.save
    redirect_to :controller => :store, :action => 'index'
  end
  
end
