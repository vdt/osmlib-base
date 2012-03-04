$: << 'lib'
require File.join(File.dirname(__FILE__), '..', 'lib', 'OSM', 'objects')
require 'test/unit'
require 'rexml/document'
require 'rubygems'
require 'builder'

# In this file we test all the
# functionality related to the
# visable flag on OSM objects.

class TestVisible < Test::Unit::TestCase

  def setup
    @out = ''
    @doc = Builder::XmlMarkup.new(:target => @out)
  end
  
  def test_node_nil
    node = OSM::Node.new(17, 'somebody', '2007-02-20T10:29:49+00:00', 8.5, 47.5, 5, 3)
    assert_equal nil, node.visible
    assert_equal '#<OSM::Node id="17" user="somebody" timestamp="2007-02-20T10:29:49+00:00" lon="8.5" lat="47.5">', node.to_s
  end

  def test_node_visible
    node = OSM::Node.new(17, 'somebody', '2007-02-20T10:29:49+00:00', 8.5, 47.5, 5, 3, true)
    assert_equal true, node.visible
    assert_equal '#<OSM::Node id="17" user="somebody" timestamp="2007-02-20T10:29:49+00:00" lon="8.5" lat="47.5" visible="true">', node.to_s
  end

  def test_node_invisible
    node = OSM::Node.new(17, 'somebody', '2007-02-20T10:29:49+00:00', 8.5, 47.5, 5, 3, false)
    assert_equal false, node.visible
    assert_equal '#<OSM::Node id="17" user="somebody" timestamp="2007-02-20T10:29:49+00:00" lon="8.5" lat="47.5" visible="false">', node.to_s
  end

  def test_way_nil
    way = OSM::Way.new(123, 'somebody', '2007-02-20T10:29:49+00:00', [], 3, 5)
    assert_equal nil, way.visible
    assert_equal '#<OSM::Way id="123" user="somebody" timestamp="2007-02-20T10:29:49+00:00">', way.to_s
  end

  def test_way_true
    way = OSM::Way.new(123, 'somebody', '2007-02-20T10:29:49+00:00', [], 3, 5, true)
    assert_equal true, way.visible
    assert_equal '#<OSM::Way id="123" user="somebody" timestamp="2007-02-20T10:29:49+00:00" visible="true">', way.to_s
  end

  def test_way_false
    way = OSM::Way.new(123, 'somebody', '2007-02-20T10:29:49+00:00', [], 3, 5, false)
    assert_equal false, way.visible
    assert_equal '#<OSM::Way id="123" user="somebody" timestamp="2007-02-20T10:29:49+00:00" visible="false">', way.to_s
  end

  def test_relation_nil
    relation = OSM::Relation.new(123, 'somebody', '2007-02-20T10:29:49+00:00', [], 3, 5)
    assert_equal nil, relation.visible
    assert_equal '#<OSM::Relation id="123" user="somebody" timestamp="2007-02-20T10:29:49+00:00">', relation.to_s
  end

  def test_relation_true
    relation = OSM::Relation.new(123, 'somebody', '2007-02-20T10:29:49+00:00', [], 3, 5, true)
    assert_equal true, relation.visible
    assert_equal '#<OSM::Relation id="123" user="somebody" timestamp="2007-02-20T10:29:49+00:00" visible="true">', relation.to_s
  end

  def test_relation_false
    relation = OSM::Relation.new(123, 'somebody', '2007-02-20T10:29:49+00:00', [], 3, 5, false)
    assert_equal false, relation.visible
    assert_equal '#<OSM::Relation id="123" user="somebody" timestamp="2007-02-20T10:29:49+00:00" visible="false">', relation.to_s
  end

  def test_node_xml_true
    node = OSM::Node.new(45, 'user', '2007-12-12T01:01:01Z', 10.0, 20.0)
    node.visible = true
    node.to_xml(@doc)    
    rexml = REXML::Document.new(@out)
    element = REXML::XPath.first(rexml, '/node')
    assert_equal 'true', REXML::XPath.first(rexml, '/node/@visible').value
  end
  
  def test_node_xml_false
    node = OSM::Node.new(45, 'user', '2007-12-12T01:01:01Z', 10.0, 20.0)
    node.visible = false
    node.to_xml(@doc)    
    rexml = REXML::Document.new(@out)
    element = REXML::XPath.first(rexml, '/node')
    assert_equal 'false', REXML::XPath.first(rexml, '/node/@visible').value
  end

  def test_node_xml_nil
    node = OSM::Node.new(45, 'user', '2007-12-12T01:01:01Z', 10.0, 20.0)
    node.to_xml(@doc)    
    rexml = REXML::Document.new(@out)
    element = REXML::XPath.first(rexml, '/node')
    assert_equal nil, REXML::XPath.first(rexml, '/node/@visible')
  end
end
