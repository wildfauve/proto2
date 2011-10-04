class Member
  include Mongoid::Document
  
  has_and_belongs_to_many :products
  
  field :name
  field :card_num
  field :registered, :type => Boolean, :default => false
  field :reg_date, :type => Time
  field :email
  
  def registered=(value)
    write_attribute(:registered, value)
    if value == false
      self.reg_date = nil
    else
      self.reg_date = Time.now
    end
  end
  
  def offered?(offer)
      self.products.includes(offer).count == 1 ? true : false
  end
  
  def modify_products(product_list)
    if product_list
      product_list.each do |k, v|
        prod = Product.find(k)
        if v == "1"
          self.products.push prod unless self.products.includes(prod).count == 1
        else
          self.products.delete(prod)
        end
      end
      save!
    end
  end
  
  
end
