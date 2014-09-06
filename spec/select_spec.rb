require 'spec_helper'

module Watir
  describe Select do
    before(:all)    { @browser = Browser.new              }
    after(:all)     { @browser.close                      }
    before(:each)   { @browser.goto(local_url(FORM_PAGE)) }
    let(:select)    { @select                             }

    describe '#set' do

      context 'single select' do
        it 'selects the given option' do
          select = @browser.select(id: 'select')
          select.set('Test2')
          expect(select.selected_options.first.text).to eq('Test2')
        end
      end


      context 'multiple select' do
        before(:each) { @select = @browser.select(id: 'multiselect') }
        it 'should select a single option' do
          select.set('Option2')
          expect(select.selected_options.count).to eq(1)
          expect(select.selected_options.first.text).to eq('Option2')
        end

        it 'should select multiple options' do
          select.set('Option2', 'Option3')
          expect(select.selected_options.count).to eq(2)
          expect(select.selected_options.map(&:text)).to eq(['Option2', 'Option3'])
        end

        it 'should select multiple options from an array' do
          select.set(['Option2', 'Option3'])
          expect(select.selected_options.count).to eq(2)
          expect(select.selected_options.map(&:text)).to eq(['Option2', 'Option3'])
        end
      end
    end
  end
end
