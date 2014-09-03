require 'spec_helper'

module Watir
  describe Setable do
    before(:each) { @field = Class.new{ include Setable }.new  }
    let(:field) { @field }

    describe 'on include' do
      it 'provides the #set method' do
        expect(field).to respond_to(:set)
      end
    end


    describe '#set' do
      context 'text and textarea' do
        it 'fills in a TextField with a string' do
          field.stub(:tag_name).and_return('text')
          expect(field).to receive(:set).with('fill text').twice
          field.set('fill text')
        end

        it 'fill in a TextArea with a string' do
          field.stub(:tag_name).and_return('textarea')
          expect(field).to receive(:set).with('fill text').twice
          field.set('fill text')
        end
      end

      context 'for checkboxes' do
        before(:each){ field.stub(:tag_name).and_return('checkbox') }

        it 'checks it if uncheckbox' do
          field.stub(:checked).and_return(false)
          expect(field).to receive(:set).with(true).ordered
          expect(field).to receive(:check).with(true).ordered
          field.set(true)
        end

        it 'unchecks if checked' do
          field.stub(:checked).and_return(true)
          expect(field).to receive(:set).with(false).ordered
          expect(field).to receive(:check).with(false).ordered
          field.set(true)
        end

        it 'does not check if checked' do
          field.stub(:checked).and_return(true)
          expect(field).to receive(:set).with(true).ordered
          expect(field).not_to receive(:check).with(true).ordered
          field.set(true)
        end

        it 'does not uncheck if unchecked' do
          field.stub(:checked).and_return(true)
          expect(field).to receive(:set).with(true).ordered
          expect(field).not_to receive(:check).with(true).ordered
          field.set(true)
        end
      end #context
    end # #set
  end # Setable
end # Watir
