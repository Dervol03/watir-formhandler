require 'spec_helper'

module Watir
  describe CheckBox do
    before(:all)    { @browser = Browser.new              }
    after(:all)     { @browser.close                      }
    before(:each)   { @browser.goto(local_url(FORM_PAGE)) }
    let(:checkbox)  { @checkbox                           }

    describe '#set' do
      before(:each) { @checkbox = @browser.checkboxes.first }

      context 'when given true' do
        it 'checks it if unchecked' do
          checkbox.click if checkbox.checked?
          checkbox.set(true)
          expect(checkbox).to be_checked
        end

        it 'does not check it if checked' do
          checkbox.click unless checkbox.checked?
          checkbox.set(true)
          expect(checkbox).to be_checked
        end
      end


      context 'when given false' do
        it 'unchecks it if checked' do
          checkbox.click unless checkbox.checked?
          checkbox.set(false)
          expect(checkbox).to_not be_checked
        end

        it 'does not uncheck it if unchecked' do
          checkbox.click if checkbox.checked?
          checkbox.set(false)
          expect(checkbox).to_not be_checked
        end
      end
    end
  end
end
