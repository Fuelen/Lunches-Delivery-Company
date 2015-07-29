module ApplicationHelper
  def show_admin_navbar(current_page = :dashboard)
    return unless current_user.admin?
    nav_items = { 
      dashboard:{
        url:  root_path,
        name: "Dashboard",
        icon: "dashboard"
      },
      users: {
        url:  users_path,
        name: "Users",
        icon: "user"
      },
      new_dish: {
        url:  new_dish_path,
        name: "Menu for today",
        icon: "menu-hamburger"
      },
      orders: {
        url:  orders_path,
        name: "Orders",
        icon: 'shopping-cart'
      }
    }
    content_tag :div, class: "nav nav-tabs" do
      nav_items.map do |page, attr|
        content_tag :li, class: ("active" if current_page == page) do
          link_to attr[:url] do
            "<span class='glyphicon glyphicon-#{attr[:icon]}'></span> ".html_safe + attr[:name]
          end
        end
      end.reduce(&:+)
    end
  end
end
