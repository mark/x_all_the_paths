module XAllThePaths
  class NodeContentBuilder

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :path_name, :path_name_block, :path_contents_block, :basic_attributes, :children
    
    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(klass)
      @klass            = klass
      @basic_attributes = []
      @children         = []
    end
    
    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def content_for(object)
      Hash.new.tap do |attributes|
        attributes[:name]       = path_name_for(object)
        attributes[:attributes] = Hash.new

        attributes[:attributes] = basic_attributes.inject({}) do |hash, basic|
          basic.content_for(object, hash)
        end
        
        attributes[:contents] = if path_contents_block
          evaluate(path_contents_block, object)
        else
          children.inject([]) do |collection, child|
            child_content = child.content_for(object)

            if child_content.kind_of?(Array)
              collection.concat child_content
            else
              collection << child_content
            end
          end
        end
      end
    end
    
    def with_path_name(name = nil, &block)
      @path_name       = name
      @path_name_block = block
      
      self
    end
    
    def with_path_contents(&block)
      @path_contents_block = block
      
      self
    end
    
    def with_basic_attribute(name = nil, &block)
      BasicAttributeBuilder.new(self, name, block).tap do |basic_attribute|
        basic_attributes << basic_attribute
      end
    end

    def with_leaf_attribute(name = nil, &block)
      NodeContentBuilder.new(nil).tap do |leaf_attribute|
        leaf_attribute.with_path_name(name)
        leaf_attribute.with_path_contents(&block)
        
        children << leaf_attribute
      end
    end
    
    def with_child_attribute(&block)
      DynamicContentBuilder.new(block).tap do |child_attribute|
        children << child_attribute
      end
    end
    
    def with_group_attribute(name = nil, &block)
      NodeContentBuilder.new(nil).tap do |group_attribute|
        group_attribute.with_path_name(name)
        group_attribute.with_child_attribute(block)
        
        children << group_attribute
      end
    end
    
    private

    def evaluate(block, object)
      if block
        object.instance_eval(&block)
      else
        raise ArgumentError # Need a better error here
      end
    end

    def path_name_for(object)
      if path_name
        path_name
      elsif path_name_block
        evaluate(path_name_block, object)
      else
        object.class.name
      end
    end
    
  end
end
