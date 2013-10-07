class Object

  def path_attributes
    self.class.eval_path_attributes(self)
  end
  
  def path_name
    self.class.name.split('::').last
  end
  
end
