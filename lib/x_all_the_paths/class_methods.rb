class Class

  def basic_attribute(name = nil, &block)
    __path_builder.with_basic_attribute(name, &block)
  end
  
  def path_name(name = nil, &block)
    __path_builder.with_path_name(name, &block)
  end
  
  def leaf_attribute(name = nil, &block)
    __path_builder.with_leaf_attribute(name, &block)
  end
  
  def child_attribute(&block)
    __path_builder.with_child_attribute(&block)
  end
  
  def path_contents(&block)
    __path_builder.with_path_contents(&block)
  end
  
  def group_attribute(name = nil, &block)
    __path_builder.with_group_attribute(name, &block)
  end
  
  def eval_path_attributes(object)
    __path_builder.content_for(object)    
  end
  
  private
  
  def __path_builder
    @__path_builder ||= XAllThePaths::NodeContentBuilder.new(self)
  end
    
end