module XAllThePaths
  class DynamicContentBuilder

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :multiple
    
    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(block, multiple = false)
      @block    = block
      @multiple = multiple
    end
    
    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def content_for(object)
      child = evaluate(@block, object)

      if child.kind_of?(Array)
        child.map(&:path_attributes)
      else
        child.path_attributes
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
    
  end
  
end
