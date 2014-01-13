# coding: utf-8
require "redcarpet"
module ApplicationHelper

  def notice_message
    flash_messages = []

    flash.each do |type, message|
      type = :success if type == :notice
      text = content_tag(:div, link_to("x", "#", :class => "close", 'data-dismiss' => "alert") + message, :class => "alert alert-#{type}")
      flash_messages << text if message
    end

    flash_messages.join("\n").html_safe
  end

  def controller_stylesheet_link_tag
    fname = ""
    case controller_name
    when "users", "home", "topics", "pages", "notes"
      fname = "#{controller_name}.css"
    when "replies"
      fname = "topics.css"
    end
    return "" if fname.blank?
    raw %(<link href="#{asset_path(fname)}" rel="stylesheet" data-turbolinks-track />)
  end

  def controller_javascript_include_tag
    fname = 
    case controller_name
    when "pages","topics","notes"
      fname = "#{controller_name}.js"
    when "replies"
      fname = "topics.js"
    end
    return "" if fname.blank?
    raw %(<script src="#{asset_path(fname)}" data-turbolinks-track></script>)
  end


end
