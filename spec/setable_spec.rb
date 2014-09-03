require 'spec_helper'

module Watir
  describe Setable do
    before(:all) do
      @browser = Browser.new
      @browser.goto(local_url(FORM_PAGE))
    end
    after(:all){ @browser.close }
    let(:browser) { @browser }

    before(:each) do
      @field = browser.checkbox
    end
    let(:field) { @field }

    describe 'on include' do
      it 'provides the #fill_in method' do
        expect(field).to respond_to(:fill_in)
      end
    end


    describe '#fill_in' do
      context 'for checkboxes' do
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
    end # #set
  end # Setable
end # Watir
