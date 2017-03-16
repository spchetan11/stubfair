module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div style="border-color: #f9ce75;" class="alert notice">
      <i class="fa fa-lg fa-exclamation-triangle"></i>
        #{sentence} : #{messages}
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end