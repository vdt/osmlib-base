$: << 'lib'
require File.join(File.dirname(__FILE__), '..', 'lib', 'OSM', 'objects')
require 'test/unit'
require 'rexml/document'
require 'rubygems'
require 'builder'

class TestChangeXML < Test::Unit::TestCase
  
  def setup
    @out = ''
    @doc = Builder::XmlMarkup.new(:target => @out)
  end
  
  def test_change_with_nodes
    
    parser = OSM::StreamParser.new(:callbacks => OSM::ChangeCallbacks.new, :string => %q{<?xml version="1.0" encoding="UTF-8"?>
<osmChange version="0.6" generator="TestSuite">
  <modify>
  <node id="17905203" version="3" lat="48.9614113" lon="8.3046066" user="test" uid="5" visible="true" changeset="94099" timestamp="2007-04-09T22:16:39+01:00">
    <tag k="created_by" v="JOSM"/>
  </node>
  <node id="3493" version="4" timestamp="2011-10-09T09:42:32Z" uid="998" user="test2" changeset="95100" lat="36.7144269" lon="-4.4586823"/>
 </modify>
 <create>
    <node id="352657343" version="1" timestamp="2011-10-09T09:42:32Z" uid="99" user="test" changeset="95100" lat="36.7111112" lon="-4.4596112"/>
 </create>
</osmChange>
        })
    change = parser.parse
    assert_kind_of OSM::Change, change
    assert_equal 2, change.actions.length
    assert_kind_of OSM::Action, change.actions[0]
    assert_equal 2, change.actions[0].objects.length
    assert_equal 3, change.objects.length
  end
end

