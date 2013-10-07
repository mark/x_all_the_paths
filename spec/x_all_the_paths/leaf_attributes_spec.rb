require 'spec_helper'

describe :leaf_attributes do

  describe :with_static_name do
  
    class Leaf1 < Struct.new(:first)
      leaf_attribute(:foo) { first }
    end
    
    subject { Leaf1.new("bar") }
    
    it "should evaluate the leaf attribute correctly" do
      subject.path_attributes[:contents].must_equal [ { name: :foo, attributes: {}, contents: 'bar' } ]
    end
    
  end

  describe :with_dynamic_name do
  
    class Leaf2 < Struct.new(:first, :second)
      leaf_attribute { first }
        .with_path_name { second }
    end
    
    subject { Leaf2.new("foo", "bar") }
    
    it "should evaluate the leaf attribute correctly" do
      subject.path_attributes[:contents].must_equal [ { name: "bar", attributes: {}, contents: 'foo' } ]
    end
    
  end
  
  describe :with_multiple_differently_named do

    class Leaf3 < Struct.new(:first, :second)
      leaf_attribute(:foo) { first }
      leaf_attribute(:bar) { second }
    end
    
    subject { Leaf3.new("baz", "quux") }
    
    it "should evaluate the leaf attribute correctly" do
      subject.path_attributes[:contents].must_equal [ { name: :foo, attributes: {}, contents: 'baz' }, { name: :bar, attributes: {}, contents: 'quux'} ]
    end
        
  end
  
  describe :with_multiple_same_named do
    
    class Leaf4 < Struct.new(:first, :second)
      leaf_attribute(:foo) { first }
      leaf_attribute(:foo) { second }
    end
    
    subject { Leaf4.new("baz", "quux") }
    
    it "should evaluate the leaf attribute correctly" do
      subject.path_attributes[:contents].must_equal [ { name: :foo, attributes: {}, contents: 'baz' }, { name: :foo, attributes: {}, contents: 'quux'} ]
    end
    
  end
  
  describe :with_basic_attribute do
    
    class Leaf5 < Struct.new(:first, :second)
      leaf_attribute(:foo) { first }
        .with_basic_attribute(:bar) { second }
    end

    subject { Leaf5.new("baz", "quux") }
    
    it "should evaluate the leaf attribute correctly" do
      subject.path_attributes[:contents].must_equal [ { name: :foo, attributes: { bar: "quux" }, contents: 'baz' } ]
    end
    
  end
  
  describe :with_basic_attribute_and_dynamic_name do

    class Leaf6 < Struct.new(:first, :second, :third)
      leaf_attribute { first }
        .with_path_name { second }
        .with_basic_attribute(:foo) { third }
    end

    subject { Leaf6.new("bar", "baz", "quux") }
    
    it "should evaluate the leaf attribute correctly" do
      subject.path_attributes[:contents].must_equal [ { name: 'baz', attributes: { foo: "quux" }, contents: 'bar' } ]
    end
    
  end
  
  describe :with_basic_attribute_and_dynamic_attribute_name do

    class Leaf7 < Struct.new(:first, :second, :third)
      leaf_attribute(:foo) { first }
        .with_basic_attribute { second }
          .with_path_name { third }
    end

    subject { Leaf7.new("bar", "baz", "quux") }
    
    it "should evaluate the leaf attribute correctly" do
      subject.path_attributes[:contents].must_equal [ { name: :foo, attributes: { "quux" => "baz" }, contents: 'bar' } ]
    end
    
  end
  
  describe :with_dynamic_name_and_basic_attribute_and_dynamic_attribute_name do

    class Leaf8 < Struct.new(:first, :second, :third, :fourth)
      leaf_attribute { first }
        .with_path_name { second }
        .with_basic_attribute { third }
          .with_path_name { fourth }
    end

    subject { Leaf8.new("foo", "bar", "baz", "quux") }
    
    it "should evaluate the leaf attribute correctly" do
      subject.path_attributes[:contents].must_equal [ { name: 'bar', attributes: { "quux" => "baz" }, contents: 'foo' } ]
    end
    
  end
  
  
end
