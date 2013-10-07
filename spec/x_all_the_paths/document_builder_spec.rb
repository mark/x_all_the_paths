require 'spec_helper'

describe DocumentBuilder do

  subject { DocumentBuilder.new(root_object) }

  class Foo < Struct.new(:first)
    basic_attribute(:bar) { first }
  end
  
  class Bar < Struct.new(:first)
    path_name { first }
  end
  
  class Baz < Struct.new(:first)
    leaf_attribute(:boosh) { first }
  end
  
  describe :basic_attributes do

    let(:root_object) { Foo.new("quux") }

    it "should generate the right document" do
      compare_xml_with_document_builder(subject, <<-XML)
        <Foo bar="quux" />
      XML
    end
    
  end

  describe :path_name do
  
    let(:root_object) { Bar.new("baz") }
    
    it "should generate the right document" do
      compare_xml_with_document_builder(subject, <<-XML)
        <baz />
      XML
    end
    
  end
  
  describe :leaf_attributes do
    
    let(:root_object) { Baz.new("stuff") }

    it "should generate the right document" do
      compare_xml_with_document_builder(subject, <<-XML)
        <Baz>
          <boosh>stuff</boosh>
        </Baz>
      XML
    end
  
  end
  
end
