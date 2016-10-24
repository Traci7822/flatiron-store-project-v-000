class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items

  def total
    totals = self.line_items.map do |line_item|
      line_item.item.price * line_item.quantity
    end
    totals.sum
    #self.items.map{|item| item.price}.sum
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

  def checkout
    self.line_items.each do |line_item|
      item = Item.find(line_item.item_id)
      item.inventory -= line_item.quantity
      item.save
    end
    self.update(status: "submitted")
  end



end
