require 'spec_helper'

module Watir
  describe Setable do
    before(:all) do
      @browser = Browser.new
      @browser.goto(local_url(FORM_PAGE))
    end
    after(:all){ @browser.close }
    let(:browser) { @browser }
    let(:field) { @field }

    describe 'on include' do
      it 'provides the #fill_in method' do
        field = Class.new{ include Setable }.new
        expect(field).to respond_to(:fill_in)
      end
    end


    describe '#fill_in' do
      context 'for checkboxes' do
        before(:each){ @field = browser.checkbox }

        it 'checks it if uncheckbox' do
          field.click if field.checked?
          field.fill_in(true)
          expect(field.checked?).to eq(true)
        end

        it 'unchecks if checked' do
          field.click unless field.checked?
          field.fill_in(true)
          expect(field.checked?).to eq(true)
        end

        it 'does not check if checked' do
          field.click unless field.checked?
          field.fill_in(true)
          expect(field.checked?).to eq(true)
        end

        it 'does not uncheck if unchecked' do
          field.click if field.checked?
          field.fill_in(false)
          expect(field.checked?).to eq(false)
        end
      end #context


      context 'for radio buttons' do
        before(:each){ @field = browser.radio }
        
        it 'selects it if unselected' do
          field.fill_in(true)
          expect(field.checked?).to eq(true)
        end
      end # context radio buttons
    end # #set
  end # Setable
end # Watir
