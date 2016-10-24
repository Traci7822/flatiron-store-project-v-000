class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items

  def total
    self.items.map{|item| item.price}.sum
  end

  def add_item(item)
    line_item = self.line_items.find_by(item_id: item)
    if line_item
      line_item.quantity += 1
    else
      line_item = self.line_items.build(cart_id: self.id, item_id: item)
    end
    line_item
  end


end
