class Product
  include Mongoid::Document
  
  has_and_belongs_to_many :members
    
  mount_uploader :image, ImageUploader
    
  
  field :name
  field :desc
  field :image_file_name
  field :image
  field :long_desc
  
end
