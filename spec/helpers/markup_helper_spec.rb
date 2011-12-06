require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SpecHelper
include MarkupHelper

describe MarkupHelper, :type => :request do
  before { setup }

  describe "#link_to" do
    context "when called with symbol argument" do
      before { @markup = link_to("Home", :index, rel: "external") }

      subject { @markup }

      it "should set a title attribute" do
        should have_css "a[title]"
      end

      it "should set an href attribute" do
        should have_css "a[href]"
      end

      it "should set a rel attribute" do
        should have_css "a[rel]"
      end

      it "should set anchor content" do
        should have_content "Home"
      end
    end
  end
  
  describe "#button_to" do
    before { @markup = button_to("Sign out", :session, :delete, { id: "test" }) }

    subject { @markup }

    it "should generate a form element" do
      should have_css "form"
    end

    it "should generate form with method set to post" do
      should have_css "form[method='post']"
    end

    it "should generate form with action attribute" do
      should have_css "form[action]"
    end

    it "should generate form with hidden text field" do
      should have_css "form input[type='hidden']"
    end

    it "should generate form with submit button" do
      should have_css "form input[type='submit']"
    end

    it "should generate submit button with ID attribute" do
      should have_css "form input[id='test']"
    end
  end

  describe "#text_field" do
    before { @markup = text_field(:name) }
    
    subject { @markup }

    it "should set type attribute to 'text'" do
      should have_css "input[type='text']"
    end

    it "should set name attribute" do
      should have_css "input[name='name']"
    end

    it "should set id attribute" do
      should have_css "input[id='name']"
    end

    context "when used with array argument" do
      before { @markup = text_field([:product, :title]) }

      subject { @markup }

      it "should set array style name attribute" do
        should have_css "input[name='product[title]']"
      end
    end
  end

  describe "#hidden_field" do
    before { @markup = hidden_field(:name) }

    subject { @markup }

    it "should generate hidden field" do
      should have_css "input[type='hidden']"
    end

    it "should set name attribute" do
      should have_css "input[name='name']"
    end

    it "should set id attribute" do
      should have_css "input[id='name']"
    end
  end

  describe "#begin_form used with #end_form" do
    before { @markup = begin_form(:setting, :post, { id: "test" }) + end_form }

    subject { @markup }

    it "should generate form element" do
      should have_css "form"
    end

    it "should set method attribute" do
      should have_css "form[method='post']"
    end

    it "should set action attribute" do
      should have_css "form[action]"
    end

    it "should set ID attribute" do
      should have_css "form[id='test']"
    end
  end

  describe "#text_area" do
    before { @markup = text_area(:description, id: "test") }

    subject { @markup }

    it "should generate a text area element" do
      should have_css "textarea"
    end

    it "should set name attribute" do
      should have_css "textarea[name='description']"
    end

    it "should set id attribute" do
      should have_css "textarea[id='test']"
    end

    context "when used with array argument" do
      before { @markup = text_area([:product, :description]) }

      subject { @markup }

      it "should set array style name attribute" do
        should have_css "textarea[name='product[description]']"
      end
    end
  end

  describe "#label" do
    before { @markup = label("Test", :test, class: "field_label") }

    subject { @markup }

    it "should generate a label element" do
      should have_css "label"
    end

    it "should set for attribute" do
      should have_css "label[for='test']"
    end

    it "should set a class attribute" do
      should have_css "label.field_label"
    end

    it "should set label content" do
      should have_content "Test"
    end

    context "when used with array argument" do
      before { @markup = label("Test", [ :product, :title ]) }

      subject { @markup }

      it "should set array style for attribute" do
        should have_css "label[for='product[title]']"
      end
    end
  end
end
