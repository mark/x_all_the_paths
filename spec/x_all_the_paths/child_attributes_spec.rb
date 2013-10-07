require 'spec_helper'

describe :child_attributes do

  describe :with_one_child do
  
    class Parent1 < Struct.new(:first)
      child_attribute { first }
    end
    
    class Child1; end
    
    subject { Parent1.new( Child1.new ) }
    
    it "should evaluate the child attribute correctly" do
      subject.path_attributes[:contents].must_equal [ { name: "Child1", attributes: {}, contents: [] } ]
    end
    
  end

  describe :with_multiple_children do
    
    class Parent2 < Struct.new(:first, :second)
      child_attribute { first  }
      child_attribute { second }
    end
    
    class Child2 < Struct.new(:first)
      path_contents { first }
    end
    
    subject { Parent2.new( Child2.new("foo"), Child2.new("bar") ) }
    
    it "should evaluate the child attribute correctly" do
      subject.path_attributes[:contents].must_equal [
        { name: "Child2", attributes: {}, contents: "foo" },
        { name: "Child2", attributes: {}, contents: "bar" }
      ]
    end
    
  end
  
end
