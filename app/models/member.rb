class Member
  include Mongoid::Document
  
  has_and_belongs_to_many :products
  
  field :name, :type => String
  field :card, :type => String
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
      self.products.include?(offer)
  end
  
  def modify_products(product_list)
    if product_list
      product_list.each do |k, v|
        prod = Product.find(k)
        Rails.logger.info(">>>Member Model>>: #{k}, #{v} #{prod}")
        if v == "1"
          self.products.push prod unless self.products.include?(prod)
        else
          self.products.delete(prod) if self.products.include?(prod)  
        end
        self.save
      end
    end
  end
  
  
end
