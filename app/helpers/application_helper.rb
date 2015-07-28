module ApplicationHelper

  def notice_message
    alert_types = {'notice' => :success, 'alert' => :danger}
    close_button = content_tag :button, 'x',
      class: 'close', 'data-dismiss' => 'alert', 'aria-hidden' => true
    flash.map do |type, message|
      content_tag :div, close_button + message,
        class: "alert alert-#{alert_types[type] || type} alert-dismissable"
    end.join.html_safe
  end

  def devise_links(opt = {})
    links = []
    if controller_name != 'sessions'
      links << link_to('返回', new_session_path(resource_name), opt)
    end
    if devise_mapping.registerable? && controller_name != 'registrations'
      links << link_to('註冊', new_registration_path(resource_name), opt)
    end
    if devise_mapping.recoverable? && controller_name != 'passwords' && controller_name != 'registrations'
      links << link_to('忘記密碼?', new_password_path(resource_name), opt)
    end
    if devise_mapping.confirmable? && controller_name != 'confirmations'
      links << link_to('沒收到認証信?', new_confirmation_path(resource_name), opt)
    end
    if devise_mapping.lockable? && resource_class.unlock_strategy_enabled?(:email) && controller_name != 'unlocks'
      links << link_to("Didn't receive unlock instructions?", new_unlock_path(resource_name), opt)
    end
    if devise_mapping.omniauthable?
      links += resource_class.omniauth_providers.map do |provider|
        link_to "Sign in with #{provider.to_s.titleize}", omniauth_authorize_path(resource_name, provider), opt
      end
    end
    links
  end

  def devise_text_links
    devise_links.join(' | ').html_safe
  end

  def devise_button_links
    devise_links(:class => 'btn btn-default fade in').join.html_safe
  end

  def nav_link(text, path)
    content_tag :li, class: (current_page?(path) ? 'active' : '') do
      link_to text, path
    end
  end
end

module Liberalism::DaterangeExtensions
  module FormBuilder

    def daterange(label, begin_date, addon, end_date)
      input(begin_date, as: :string, wrapper: horizontal_wrapper('daterange'),
            addon: addon, begin_date: begin_date, end_date: end_date,
            label: label)
    end

    def radio_buttons(attribute_name, collection, options={})
      args = [attribute_name, options.merge(
        as: :radio_buttons, wrapper: horizontal_wrapper('radiobuttons'),
        collection: collection, item_wrapper_tag: nil,
        item_label_class: 'btn btn-default')]
      object.class.reflect_on_association(attribute_name) ?
        association(*args) : input(*args)
    end

    def horizontal_wrapper(type)
      :"horizontal_#{type}_#{@options[:wrapper].to_s.split('_')[-1].to_i}"
    end
  end

  module StringInput

    def begin_date(opts)
      hidden_text_fields @options[:begin_date], opts
    end

    def addon(opts)
      @options[:addon]
    end

    def end_date(opts)
      hidden_text_fields @options[:end_date], opts
    end

    def hidden_text_fields(attribute, opts)
      ignore_name = "#{lookup_model_names.join('_')}[#{attribute}_ignore]"
      "#{template.text_field_tag(ignore_name, '', opts)
      }#{template.hidden_field(object_name, attribute)}"
    end
  end

  SimpleForm::FormBuilder.send :include, FormBuilder
  SimpleForm::Inputs::StringInput.send :include, StringInput
end
