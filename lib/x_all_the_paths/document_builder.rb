class DocumentBuilder

  ################
  #              #
  # Declarations #
  #              #
  ################
  
  attr_reader :doc, :root_object, :mapping
  
  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize(root_object)
    @root    = root_object
    @doc     = Nokogiri::XML::Document.new
    @mapping = {}
    
    generate_node_for(root_object, @doc)
  end
  
  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################
  
  def to_xml
    @doc.to_xml
  end

  private
  
  def generate_node_for(object, parent, attrs = nil)
    attrs ||= object.path_attributes

    node = Nokogiri::XML::Node.new attrs[:name].to_s, @doc
    node.parent = parent
    
    attrs[:attributes].each do |key, value|
      node[key] = value
    end
    
    if attrs[:contents].kind_of?(String)
      node.content = attrs[:contents]
    else
      attrs[:contents].each do |content|
        generate_node_for(object, node, content)
      end
    end
    
    mapping[node] = object
  end
  
end
