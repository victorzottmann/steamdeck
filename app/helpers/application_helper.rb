module ApplicationHelper
  # This helper method can be called across the whole application. It checks whether the current user has admin rights. The admin is set to user1 (refer to seeds.rb)
  def has_role?(role)
    current_user && current_user.has_role?(role)
  end

  def cart_count
    if @cart.line_items.count > 0
      return @cart.line_items.count
    end
  end

  def cart_has_items
    return @cart.line_items.count > 0
  end
end
