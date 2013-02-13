module ApplicationHelper
  def flash_messages
    return if !flash.any?
    flash.each do |type, msg|
      type = 'error'    if type == :alert
      type = 'success'  if type == :notice
      return content_tag :p, msg, class: "alert alert-#{type}"
    end
  end

  def current_user_is?(user)
    return false if current_user.nil?
    user = user.username if user.respond_to? :username
    (current_user.username == user) ? true : false
  end
end
