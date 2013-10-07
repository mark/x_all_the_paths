require 'spec_helper'

describe :basic_attributes do

  describe :with_static_name do
  
    class Basic1 < Struct.new(:first)
      basic_attribute(:foo) { first }
    end

    subject { Basic1.new("bar") }

    it "should evaluate basic attributes correctly" do
      subject.path_attributes[:attributes].must_equal( { foo: "bar" } )
    end

  end
  
  describe :with_dynamic_name do
  
    class Basic2 < Struct.new(:first, :second)
      basic_attribute { first }
        .with_path_name { second }
    end
  
    subject { Basic2.new("foo", "bar") }
  
    it "should evaluate basic attributes correctly" do
      subject.path_attributes[:attributes].must_equal( { "bar" => "foo" } )
    end
    
  end
  
end
