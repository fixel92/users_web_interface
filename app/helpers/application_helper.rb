module ApplicationHelper
  include Pagy::Frontend

  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-danger'
    when 'alert' then 'alert alert-warning'
    end
  end

  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_path('avatar.jpg')
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.file.present?
      user.avatar.thumb.url
    else
      asset_path('avatar.jpg')
    end
  end

  def user_avatar_min(user)
    if user.avatar.file.present?
      user.avatar.min.url
    else
      asset_path('avatar.jpg')
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def page_is_create_user?
    params[:action] == 'create' || current_page?(action: 'new')
  end
end
