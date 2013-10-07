require 'spec_helper'

describe :group_attributes do

  describe :simple_case do
  
    class Group1 < Struct.new(:first)
      group_attribute(:foos) { first }
    end
    
    class Grouped1 < Struct.new(:first)
      path_contents { first }
    end

    subject { Group1.new(first) }
    
    describe :with_one_item do
      
      let(:first) { Grouped1.new("foo") }
      
      it "should generate the right grouped contents" do
        subject.path_attributes[:contents].must_equal [
          { name: :foos, attributes: {}, contents: [
            { name: "Grouped1", attributes: {}, contents: "foo" }
          ] }
        ]
      end
      
    end
    
    describe :with_multiple_items do
      
    end
    
  end
  
end
