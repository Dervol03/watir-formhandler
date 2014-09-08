require 'spec_helper'

describe Watir do
  describe 'extend_tag_to_class' do
    TestClass = Class.new
    it 'should add a new tag-class combination to the original hash' do
      Watir.extend_tag_to_class(:test, TestClass)
      expect(Watir.tag_to_class.keys).to include(:test)
      expect(Watir.tag_to_class[:test]).to be_a(Class)
    end

    it 'should freeze the tag_to_class hash again after the addition' do
      Watir.extend_tag_to_class(:test, TestClass)
      expect(Watir.tag_to_class).to be_frozen
    end
  end
end
