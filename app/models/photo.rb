require 'RMagick'
class Photo < ActiveRecord::Base 
  acts_as_taggable
  
  has_many :product_photos#, :dependent => :nullify
  has_many :products, :through => :product_photos
  
  UPLOAD_FOLDER = "public/data/photos/"
  THUMB_MAX_SIZE = [125, 125]

  validates_format_of :content_type,
                      :with => /^image/,
                      :message => "Вы можете загружать только фотографии."
 
  # Load image by file path
  def upload(file_name)
    image_file = File.new file_name
    self.content_type = 'image/jpeg'
    self.data = Base64.encode64 image_file.read
    image_file.close
  end
  
  # Get image
  def image 
    Base64.decode64(self.data)
  end
  
  # Get image thumbnail
  def thumbnail
    image = Magick::Image.read_inline(self.data).first
    scale = THUMB_MAX_SIZE.max / [image.rows,image.columns].max.to_f
    image.thumbnail(scale).to_blob
  end
  
  # Get image size
  def size
    self.data.size
  end
  
end