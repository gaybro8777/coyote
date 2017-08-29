# rubocop:disable ModuleLength
 
# Contains general, simple view helper code. Designed to keep code out of our views 
# as much as possible
# @see http://guides.rubyonrails.org/action_view_overview.html#overview-of-helpers-provided-by-action-view
module ApplicationHelper
  # @return [Hash] a collection of User roles with human friendly labels
  # @see User
  def user_role_collection
    User.roles.inject({}) do |result,(role_name,role_value)| 
      result.merge!(role_name.titleize => role_value) 
    end
  end

  # @return [String] welcome message, including the user's name if someone is logged-in
  def welcome_message
    msg =  "Welcome to Coyote"
    msg << ", #{current_user}!" if current_user
    msg
  end
  
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def body_class_default
    [controller_name, action_name].join('-') + ' '  + controller_name + ' ' + action_name
  end

  def body_class(class_name="")
    class_name =  body_class_default + ' ' + class_name
    content_for :body_class, class_name
  end

  def current_tag?(*tag)
    #logger.info(tag)
    #logger.info(params[:tag])
    tag.include?(params[:tag])
  end

  def flash_class(level)
    case level.to_sym
    when :notice then "alert alert-info alert-dismissable"
    when :success then "alert alert-success alert-dismissable"
    when :error then "alert alert-warning alert-dismissable"
    when :alert then "alert alert-danger alert-dismissable"
    end
  end

  def image_status_css_class(status_code)
    klass = ""
    case status_code
    when 0
      klass += "undescribed" 
    when 1
      klass += "partial" 
    when 2
      klass += "warning" 
    when 3
      klass += "success" 
    end
    return klass
  end

  def description_css_class(description)
    klass = "item "
    case description.status_id
    when 2
      klass += "success" 
    when 1
      klass += "warning" 
    when 3
      klass += "danger" 
    end
    klass
  end

  def admin?
    current_user.try(:admin?)
  end

  def set_markdown
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  end

  def to_html(content)
    set_markdown
    if content.blank?
      ""
    else
      raw @markdown.render(content)
    end
  end

  def to_text(content)
    if content.blank?
      ""
    else
      strip_tags to_html(content)
    end
  end

  def to_html_attr(content)
    h to_text(content)
  end

  # Used to render top-level navigation, so the current page gets an "active" CSS class applied
  # @param text [String] the link text to display
  # @param path [String] the target of the link
  def nav_menu_link(text,path)
    link_class = current_page?(path) ? "active" : ""

    content_tag(:li,class: link_class) do
      link_to(text,path)
    end
  end

  def audited_value(value)
    if value.kind_of? Array
      value.last
    else
      value
    end
  end

  def license_link(license)
    "https://choosealicense.com/licenses/" + license
  end

  def license_title(license)
    case license
    when "cc0-1.0"
      "Creative Commons Zero v1.0 Universal"
    when "cc-by-sa-4.0"
      "Creative Commons Attribution Share Alike 4.0"
    when "cc-by-4.0"
      "Creative Commons Attribution 4.0"
    end
  end
end

# rubocop:enable ModuleLength
