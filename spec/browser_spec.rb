require 'spec_helper'


module Watir
  describe Browser do
    let(:browser){ @browser }
    describe '#field' do
      before(:each) { browser.goto(local_url(FORM_PAGE))}

      describe 'without a start node' do
        it 'returns the form field of the specified label string' do
          expect(browser.field('Checkbox').id).to eq('checkbox')
        end

        it 'returns the form field of the given label node' do
          field_label = browser.label(text: 'Checkbox')
          expect(browser.field(field_label).id).to eq('checkbox')
        end
      end
    end
  end
end
