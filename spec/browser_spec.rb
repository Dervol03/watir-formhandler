require 'spec_helper'


module Watir
  describe Browser do
    before(:all) { @browser = Watir::Browser.new }
    after(:all)  { @browser.close}
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
            browser.field('Checkbox', start_node: start_node)
          end

          it 'returns form field of the label within Watir::Element' do
            start_node = browser.element(id: 'main_content')
            expect(browser.field('Checkbox', start_node: start_node).id).to eq('checkbox')
          end
        end


        context 'specifying the label with a Watir::Label' do
          it 'searches the label within given Watir::Element' do
            field_label = double('label', for: 'checkbox')
            start_node = double('enter_element')

            expect(start_node).to receive(:element).with(id: 'checkbox')
            browser.field(field_label, start_node: start_node)
          end

          it 'returns form field of the label within Watir::Element' do
            start_node = browser.element(id: 'main_content')
            field_label = browser.label(text: 'Checkbox')
            expect(browser.field(field_label, start_node: start_node).id).to eq('checkbox')
          end
        end
      end


      describe 'depending on subtype' do
        context 'if a single field is in the area' do
          it 'returns a Watir::Checkbox for a checkbox' do
            expect(browser.field('Checkbox')).to be_a(Watir::CheckBox)
          end

          it 'returns a Watir::Select for a select' do
            expect(browser.field('Select')).to be_a(Watir::Select)
          end

          it 'returns a Watir::TextField for a text field' do
            expect(browser.field('Text Field')).to be_a(Watir::TextField)
          end

          it 'returns a Watir::TextArea for a text area' do
            expect(browser.field('Text Area')).to be_a(Watir::TextArea)
          end

          it 'returns a Watir::Radio for a radio button' do
            expect(browser.field('Radio')).to be_a(Watir::Radio)
          end

          it 'returns a Watir::FileField for a file field' do
            expect(browser.field('File')).to be_a(Watir::FileField)
          end
        end

        context 'if fields are grouped' do
          it 'returns Watir::OptionGroup for grouped checkboxes' do
            expect(browser.field('Checkbox1', include_groups: true)).to be_a(Watir::OptionGroup)
          end

          it 'returns Watir::OptionGroup for grouped radio buttons' do
            expect(browser.field('Radio1', include_groups: true)).to be_a(Watir::OptionGroup)
          end

          it 'returns Watir::OptionGroup for grouped chckboxes and radio buttons' do
            expect(browser.field('Checkbox5', include_groups: true)).to be_a(Watir::OptionGroup)
          end
        end #context
      end # describe depending on sub type
    end # describe #field


    describe '#fill_in' do
      let(:field) { @field }

      context 'for checkboxes' do
        before(:each){ @field = browser.field('Checkbox') }

        it 'checks it if uncheckbox' do
          field.click if field.checked?
          expect(field).to receive(:click)
          browser.fill_in('Checkbox', true)
          expect(field.checked?).to eq(true)
        end

        it 'unchecks if checked' do
          field.click unless field.checked?
          expect(field).to receive(:click)
          browser.fill_in('Checkbox', false)
          expect(field.checked?).to eq(false)
        end

        it 'does not check if checked' do
          field.click unless field.checked?
          expect(field).not_to receive(:click)
          browser.fill_in('Checkbox', false)
          expect(field.checked?).to eq(true)
        end

        it 'does not uncheck if unchecked' do
          field.click if field.checked?
          expect(field).not_to receive(:click)
          field.fill_in(false)
          expect(field.checked?).to eq(false)
        end
      end #context


      context 'for radio buttons' do
        before(:each){ @field = browser.field('Radio') }

        it 'selects it if unselected' do
          expect(field).to receive(:click)
          browser.fill_in('Radio', true)
          expect(field.checked?).to eq(true)
        end

        it 'does not select it if selected' do
          field.click
          expect(field).not_to receive(:click)
          browser.fill_in('Radio', true)
          expect(field.checked?).to eq(true)
        end
      end # context radio buttons


      context 'for text fields' do
        before(:each){ @field = browser.text_fields.first }

        it 'fills in text' do
          field.set('')
          field.fill_in('test string')
          expect(field.value).to eq('test string')
        end

        it 'deletes the text content if given empty sting' do
          field.set('test string')
          field.fill_in('')
          expect(field.value).to eq('')
        end
      end # context text field
    end
  end # Browser
end # Watir
