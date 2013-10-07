module XAllThePaths
  class BasicAttributeBuilder

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :node_content_builder, :path_name, :path_name_block, :path_contents_block
    
    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(node_content_builder, path_name, block)
      @node_content_builder = node_content_builder
      @path_name            = path_name
      @path_contents_block  = block
    end
    
    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def content_for(object, basic_attributes)
      key   = path_name || evaluate(path_name_block, object)
      value = evaluate(path_contents_block, object)
      
      basic_attributes[key] = value
      basic_attributes
    end
    
    def with_path_name(&block)
      @path_name_block = block
    end
    
    # def with_basic_attribute(name = nil, &block)
    # end

    private
    
    def evaluate(block, object)
      if block
        object.instance_eval(&block)
      else
        raise ArgumentError # Need a better error here
      end
    end
    
  end
end
