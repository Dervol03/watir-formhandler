require 'spec_helper'

module Watir
  describe Container do
    before(:all) { @browser = Watir::Browser.new }
    after(:all)  { @browser.close}
    let(:browser){ @browser }

    before(:each) { browser.goto(local_url(FORM_PAGE)) }

    describe '#option_group' do
      context 'using a selector' do
        it "returns a Watir::OptionGroup for id: 'checkboxset'" do
          expect(browser.option_group(id: 'checkboxset')).to be_a(Watir::OptionGroup)
        end

        it "returns a Watir::OptionGroup for class: 'radioset' selector" do
          expect(browser.option_group(class: 'radioset')).to be_a(Watir::OptionGroup)
        end
      end

      context 'using a node' do
        it 'returns a Watir::OptionGroup for a given Watir::Element' do
          fieldset = browser.fieldset(id: 'checkboxset')
          expect(browser.option_group(fieldset).tag_name).to eq('fieldset')
        end
      end
    end
  end

end
