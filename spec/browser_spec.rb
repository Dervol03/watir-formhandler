require 'spec_helper'


module Watir
  describe Browser do
    let(:browser){ @browser }
    describe '#field' do
      before(:each) { browser.goto(local_url(FORM_PAGE))}

      describe 'without a start node' do
        it 'returns form field of the specified label string' do
          expect(browser.field('Checkbox').id).to eq('checkbox')
        end

        it 'returns form field of the given label node' do
          field_label = browser.label(text: 'Checkbox')
          expect(browser.field(field_label).id).to eq('checkbox')
        end
      end


      describe 'with a start node' do
        context 'specifying the label with a string' do
          it 'searches the label within given Watir::Element' do
            field_label = double('label', for: 'checkbox')
            start_node = double('enter_element', label: field_label)

            expect(start_node).to receive(:label).with(text: 'Checkbox')
            expect(start_node).to receive(:element).with(id: 'checkbox')
            browser.field('Checkbox', start_node)
          end

          it 'returns form field of the label within Watir::Element' do
            start_node = browser.element(id: 'main_content')
            expect(browser.field('Checkbox', start_node).id).to eq('checkbox')
          end
        end


        context 'specifying the label with a Watir::Label' do
          it 'searches the label within given Watir::Element' do
            field_label = double('label', for: 'checkbox')
            start_node = double('enter_element')

            expect(start_node).to receive(:element).with(id: 'checkbox')
            browser.field(field_label, start_node)
          end

          it 'returns form field of the label within Watir::Element' do
            start_node = browser.element(id: 'main_content')
            field_label = browser.label(text: 'Checkbox')
            expect(browser.field(field_label, start_node).id).to eq('checkbox')
          end
        end
      end


      describe 'depending on subtype' do
        it 'returns a Watir::Checkbox' do
          expect(browser.field('Checkbox')).to be_a(Watir::CheckBox)
        end

        it 'returns a Watir::Select' do
          expect(browser.field('Select')).to be_a(Watir::Select)
        end

        it 'returns a Watir::TextField' do
          expect(browser.field('Text Field')).to be_a(Watir::TextField)
        end

        it 'returns a Watir::TextArea' do
          expect(browser.field('Text Area')).to be_a(Watir::TextArea)
        end

        it 'returns a Watir::Radio' do
          expect(browser.field('Radio')).to be_a(Watir::Radio)
        end

      end
    end
  end
end
