module DishesHelper
  def kinds_as_options_for_select(dish)
    options_for_select(Dish.kinds.map {|k, v| [k.humanize.capitalize, k]},
                      dish.kind)
  end
end
