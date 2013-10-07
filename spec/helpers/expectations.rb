def compare_xmls(actual, expected)
  expected_hash = Hash.from_xml(expected)
  actual_hash   = Hash.from_xml(actual)

  expected_hash.must_equal actual_hash
end

def compare_xml_with_document_builder(db, xml)
  compare_xmls(xml, db.doc.to_xml)
end
