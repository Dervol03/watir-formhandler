require 'spec_helper'


module Watir
  describe Browser do
    describe '#field' do
      before(:each) { @browser.goto(local_url(FORM_PAGE))}

      describe 'without a start node' do
        it 'returns the form field of the specified label string' do
          expect(@browser.field('Checkbox').id).to eq('checkbox')
        end
      end
    end
  end
end
