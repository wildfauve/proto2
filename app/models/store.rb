class Store
  include Mongoid::Document
  
  has_many :members
    
  field :name
  
  
  
end
