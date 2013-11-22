require "pin_it/version"
begin
  require "active_support/core_ext/object/to_query"
rescue LoadError
  require "active_support/core_ext/object/conversions"
end

module PinIt
  module Helper

    PIN_ICON_URL_TEMPLATE = "//assets.pinterest.com/images/pidgets/pinit_fg_en_rect_%s_20.png"

    def pin_it_button(options = {})
      %{<a href="http://pinterest.com/pin/create/button/?url=page_url&media=img_url&description=description" class="pin-it-button" count-layout="horizontal">Pin It</a>}
      query_params = options.slice(:url, :media, :description)
      pin_color = options[:pin_color] || :gray
      pin_config = options[:pin_config] || :horizontal
      img = tag :img, :src => PIN_ICON_URL_TEMPLATE % pin_color, :title => "Pin It", :border => "0"
      content_tag :a, img, "href" => "http://pinterest.com/pin/create/button/?#{query_params.to_query}",
                                "class" => "pin-it-button",
                                data: { "pin-color" => pin_color, "pin-config" => pin_config }
    end


    def pin_it_js
      @pin_it_js ||= IO.read(File.expand_path("../../vendor/assets/javascripts/pin_it.js", __FILE__))
    end
  end

  if defined? ::Rails::Railtie
    class Railtie < ::Rails::Railtie
      initializer "pin_it.view_helpers" do |app|
        ::ActionView::Base.send :include, PinIt::Helper
      end
    end
  end

  if defined? ::Rails::Engine
    module Rails
      class Engine < ::Rails::Engine
      end
    end
  end
end
