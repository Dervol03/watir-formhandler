require 'spec_helper'

module Watir
  describe OptionGroup do
    before(:all) { @browser = Watir::Browser.new }
    after(:all)  { @browser.close}
    let(:browser){ @browser }

    before(:each) { browser.goto(local_url(FORM_PAGE)) }

    describe 'behaving like a normal Watir::Element' do
      describe '#exists? should return' do
        it 'true if it is present in the DOM' do
          expect(browser.option_group(id: 'radioset').exist?).to eq(true)
        end

        it 'false otherwise' do
          expect(browser.option_group(id: 'nowhere').exist?).to eq(false)
        end
      end
    end


    describe '#option_names' do
      it 'gives the names of all available checkboxes'  do
        expected_options = %w(Checkbox1 Checkbox2 Checkbox3 Checkbox4)
        expect(browser.option_group(id: 'checkboxset').option_names).to eq(expected_options)
      end

      it 'gives the names of all available radio buttons'  do
        expected_options = %w(Radio1 Radio2 Radio3 Radio4)
        expect(browser.option_group(id: 'radioset').option_names).to eq(expected_options)
      end

      it 'gives the names of all available radio buttons and checkboxes'  do
        expected_options = %w(Checkbox5 Checkbox6 Radio5 Radio6 Radio7)
        expect(browser.option_group(id: 'radio_and_checkbox').option_names).to eq(expected_options)
      end
    end


    describe '#option_fields' do
      it 'provides all fields belonging to the OptionGroup'
    end


    describe '#options' do
      it 'gives a hash with all options and their fields'
    end



  end

end
