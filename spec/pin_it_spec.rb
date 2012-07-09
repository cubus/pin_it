require 'spec_helper'

describe PinIt::Helper do
  before(:each) do
    @view = ActionView::Base.new
  end

  describe "#pin_it_button" do
    it "should be mixed into ActionView::Base" do
      ActionView::Base.included_modules.include?(PinIt::Helper).should be_true
    end

    it "should respond to 'pin_it_button' helper" do
      @view.should respond_to(:pin_it_button)
    end
    
    it "should return a pin it button with horizontal count layout(default)" do
      expected = %{<a href="http://pinterest.com/pin/create/button/?url=page_url&media=img_url&description=description" class="pin-it-button" count-layout="horizontal">Pin It</a>}
      @view.pin_it_button(url:"page_url", media: "img_url", description: "description").should_not be_nil
      @view.pin_it_button(url:"page_url", media: "img_url", description: "description").should match('count-layout="horizontal"')
    end

    it "should return a pin it button with vertical count layout" do
      expected = %{<a href="http://pinterest.com/pin/create/button/?url=page_url&media=img_url&description=description" class="pin-it-button" count-layout="vertical">Pin It</a>}
      @view.pin_it_button(url:"page_url", media: "img_url", description: "description", count_layout: 'vertical').should_not be_nil
      @view.pin_it_button(url:"page_url", media: "img_url", description: "description", count_layout: 'vertical').should match('count-layout="vertical"')
    end

    it "should return a pin it button with no count layout" do
      expected = %{<a href="http://pinterest.com/pin/create/button/?url=page_url&media=img_url&description=description" class="pin-it-button" count-layout="none">Pin It</a>}
      @view.pin_it_button(url:"page_url", media: "img_url", description: "description", count_layout: 'none').should_not be_nil
      @view.pin_it_button(url:"page_url", media: "img_url", description: "description", count_layout: 'none').should match('count-layout="none"')
    end

  end
end
