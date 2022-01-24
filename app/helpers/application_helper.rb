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

end
