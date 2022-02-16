module ApplicationHelper

  def urls_to_images(str)
    str.gsub!( %r{https://[^\s<]+}) do |url|
      "<img src='#{url}' width='100'; />"
    end
    str.html_safe
  end

  def urls_to_links(str)
    str.gsub!( %r{https://[^\s<]+}) do |url|
      "<a href='#{url}'>#{url}</a>"
    end
    str.html_safe
  end

  def urls_to_content(str)
    str.gsub!( %r{https://[^\s<]+}) do |url|
      if url[/(?:png|jpe?g|gif|svg)$/]
        "<img src='#{url}' width='100'; />"
      else
        "<a href='#{url}'>#{url}</a>"
      end
    end
    str.html_safe
  end

  include Pagy::Frontend

  def pagination(obj)
    raw(pagy_bootstrap_nav(obj)) if obj.pages > 1
  end

  def nav_tab(title, url, options = {})
    current_page = options.delete :current_page

    css_class = current_page == title ? 'text-secondary' : 'text-white'

    options[:class] = if options[:class]
                        options[:class] + ' ' + css_class
                      else
                        css_class
                      end

    link_to title, url, options
  end

  def currently_at(current_page = '')
    render partial: 'shared/menu', locals: {current_page: current_page}
  end

  def full_title(page_title = "")
    base_title = "AskIt"
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end

end
