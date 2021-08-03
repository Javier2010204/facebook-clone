class UserDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def test_buttons
    #Si es hay amistad que retorne el estado de la amistad
    #Si es mi usuario que retorne el boton de editar
    #Si no hay amistad que retorne el boton de agregar
    return edit_button if object == h.current_user
    h.current_user.is_my_friend?(object) ? friendship_status_content : add_friend_button
  end

  def friendship_status_content
    h.content_tag :p, friendship_status, class:'amistad-enviada'
  end

  def friendship_status
    if h.current_user.is_my_friend?(object) && Friendship.friend_status(h.current_user, object).active.any?
      return "Amigo"
    elsif h.current_user.is_my_friend?(object) && Friendship.friend_status(h.current_user, object).pending.any?
      return "Solicitud de amistad pendiente"
    end
    
  end
  

  #Necesito retornar "Amigo" si la amistad esta activa
  # retornar "Solicitud pendiente" si la amistad esta pendiente

  def add_friend_button
    h.button_to h.friendships_path(friend_id: object.id), method: :post, class: 'btn-facebook-primary no-decoration' do
      h.content_tag :p, '', class: 'fas fa-user-plus white-text'
      "Agregar a mis amigo"
    end
  end

  def edit_button
    h.link_to h.edit_user_path(h.current_user), class: 'btn-facebook-primary no-decoration' do
      h.content_tag :i, '', class:'fas fa-edit white-text'
      "Editar perfil"
    end
  end
  
  
  
  
  

end
