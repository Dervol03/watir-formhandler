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
    end # #option_group


    describe '#field' do
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
        end
      end # describe sybtype
    end # #field
  end

end
