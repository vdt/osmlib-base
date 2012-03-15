$: << 'lib'
require File.join(File.dirname(__FILE__), '..', 'lib', 'OSM', 'objects')
require 'test/unit'

class TestChange < Test::Unit::TestCase
  def test_init
    assert_nothing_raised do
      change = OSM::Change.new
    end
  end
  def test_actions
    node =  OSM::Node.new(17, 'somebody', '2007-02-20T10:29:49+00:00', 8.5, 47.5, 5, 3)
    way = way = OSM::Way.new(123, 'somebody', '2007-02-20T10:29:49+00:00', [], 3, 5)
    action1 = OSM::Action.new(:modify)
    action1.objects = [node]
    action2 = OSM::Action.new(:create)
    action2.objects = [way]                         
    change = OSM::Change.new
    change.push action1
    change.push action2
    assert_equal change.actions, [action1, action2]
  end
  def test_objects
    node =  OSM::Node.new(17, 'somebody', '2007-02-20T10:29:49+00:00', 8.5, 47.5, 5, 3)
    way = way = OSM::Way.new(123, 'somebody', '2007-02-20T10:29:49+00:00', [], 3, 5)
    action1 = OSM::Action.new(:modify)
    action1.objects = [node]
    action2 = OSM::Action.new(:create)
    action2.objects = [way]                         
    change = OSM::Change.new
    change.push action1
    change.push action2
    assert_equal change.objects, [node, way]
  end
end
    
