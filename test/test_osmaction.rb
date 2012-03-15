$: << 'lib'
require File.join(File.dirname(__FILE__), '..', 'lib', 'OSM', 'objects')
require 'test/unit'

class TestAction < Test::Unit::TestCase
  
  def test_init
    assert_raise ArgumentError do
      OSM::Action.new()
    end
    assert_raise TypeError do
      OSM::Action.new(17)
    end
    assert_nothing_raised do
      OSM::Action.new(:create)
    end
  end
  
  def test_create
    action = OSM::Action.new(:create)
    assert_equal action.type, :create
  end
  
  def test_node
    node = OSM::Node.new(17, 'somebody', '2007-02-20T10:29:49+00:00', 8.5, 47.5, 5, 3)
    create = OSM::Action.new(:create)
    create.push node
    assert_equal create.objects, [node]
  end

  def test_list
    node =  OSM::Node.new(17, 'somebody', '2007-02-20T10:29:49+00:00', 8.5, 47.5, 5, 3)
    way = way = OSM::Way.new(123, 'somebody', '2007-02-20T10:29:49+00:00', [], 3, 5)
    relation = OSM::Relation.new(123, 'somebody', '2007-02-20T10:29:49+00:00', [], 3, 5)
    action = OSM::Action.new(:modify)
    action.objects = [node, way, relation]
    assert_equal  action.objects, [node, way, relation]
  end
end
