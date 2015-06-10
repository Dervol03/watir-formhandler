require 'spec_helper'

module Watir
  describe Container do
    before(:all) { @browser = Watir::Browser.new }
    after(:all)  { @browser.close}
    let(:browser){ @browser }

    before(:each) { browser.goto(local_url(FORM_PAGE)) }

    def field_label(text)
      browser.label(text: text)
    end

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
          expect(browser.option_group(fieldset).tag_name).to eq('option_group')
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
      end# without start_node


      describe 'with a start node' do
        context 'specifying the label with a string' do
          it 'searches the label within given Watir::Element' do
            start_node = browser.div(id: 'main_content')
            start_node.exists?
            searched_field = start_node.element(id: 'checkbox')


            expect(start_node).to receive(:element).with(id: 'checkbox')
                                    .and_return(searched_field)
            browser.field('Checkbox', start_node: start_node)
          end

          it 'returns form field of the label within Watir::Element' do
            start_node = browser.element(id: 'main_content')
            expect(browser.field('Checkbox', start_node: start_node).id).to eq('checkbox')
          end
        end# with start_node


        context 'specifying the label with a Watir::Label' do
          it 'searches the label within given Watir::Element' do
            start_node = browser.div(id: 'main_content')
            field_label = start_node.label(text: 'Checkbox')
            searched_field = start_node.element(id: 'checkbox')

            expect(start_node).to receive(:element).with(id: 'checkbox')
                                    .and_return(searched_field)

            browser.field(field_label, start_node: start_node)
          end

          it 'returns form field of the label within Watir::Element' do
            start_node = browser.element(id: 'main_content')
            field_label = browser.label(text: 'Checkbox')
            expect(browser.field(field_label, start_node: start_node).id).to eq('checkbox')
          end
        end
      end# Watir::Label


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
          it 'returns Watir::OptionGroup for fieldset' do
            expect(browser.field('Checkboxset')).to be_a(Watir::OptionGroup)
          end
        end
      end # describe sybtype


      describe 'using placeholder: true' do
        it 'returns Watir::TextField for a text field with a placeholder' do
          expect(browser.field('Placeholder Text', placeholder: true)).to be_an Watir::TextField
        end

        it 'returns Watir::TextArea for a text area with a placeholder' do
          expect(browser.field('Placeholder Area', placeholder: true)).to be_an Watir::TextArea
        end
      end


      describe 'using id: true' do
        it 'returns field with id given as label' do
          text_id = 'text'
          expect(browser.field(text_id, id: true)).to be_an Watir::TextField
          expect(browser.field(text_id, id: true).id).to eq(text_id)
        end
      end
    end # #field
    ################################################################################################


    describe '#fill_in' do
      describe 'without a start node' do
        it 'fills a Watir::Checkbox' do
          browser.fill_in('Checkbox', true)
          expect(browser.checkboxes.first).to be_checked
        end

        it 'fills a Watir::Radio' do
          browser.fill_in('Radio', true)
          expect(browser.radios.first).to be_checked
        end

        it 'fills a Watir::FileField' do
          browser.fill_in('File', File.join(HTML_DIR, FORM_PAGE))
          expect(browser.file_fields.first.value).to eq(FORM_PAGE)
        end

        it 'fills a Watir::TextField' do
          browser.fill_in('Text Field', 'test text')
          expect(browser.text_fields.first.value).to eq('test text')
        end

        it 'fills a Watir::TextArea' do
          browser.fill_in('Text Area', 'test text')
          expect(browser.textareas.first.value).to eq('test text')
        end

        it 'fills a Watir::Select with single select' do
          browser.fill_in('Select', 'Test2')
          expect(browser.selects.first.selected_options.count).to eq(1)
          expect(browser.selects.first.selected_options.first.text).to eq('Test2')
        end

        it 'fills a Watir::Select with multiple select' do
          options = %w(Option2 Option3)
          browser.fill_in('Multi Select', options)
          multiselect = browser.select(id: 'multiselect')
          expect(multiselect.selected_options.count).to eq(2)
          expect(multiselect.selected_options.map(&:text)).to eq(options)
        end

        it 'fills a Watir::OptionGroup' do
          options = %w(Checkbox5 Radio7)
          browser.fill_in('Radios and Checkboxes', options)
          option_group = browser.option_group(id: 'radio_and_checkbox')
          expect(option_group.selected_options.count).to eq(2)
          expect(option_group.selected_options).to eq(options)
        end
      end # desribe: without a start node


      describe 'with a start node' do
        before(:all)      { @browser.refresh                    }
        let(:start_node)  { browser.element(id: 'main_content') }


        it 'fills a Watir::Checkbox from start node' do
          expect(start_node).to receive(:label)
                                  .and_return(field_label('Checkbox'))
          browser.fill_in('Checkbox', true, start_node: start_node)
          expect(browser.checkboxes.first).to be_checked
        end

        it 'fills a Watir::Radio from start node' do
          expect(start_node).to receive(:label)
                                  .and_return(field_label('Radio'))
          browser.fill_in('Radio', true, start_node: start_node)
          expect(browser.radios.first).to be_checked
        end

        it 'fills a Watir::Select  with single select from start node' do
          expect(start_node).to receive(:label)
                                  .and_return(field_label('Select'))
          browser.fill_in('Select', 'Test2', start_node: start_node)
          expect(browser.selects.first.selected_options.count).to eq(1)

          expect(browser.selects.first.selected_options.first.text)
            .to eq('Test2')
        end

        it 'fills a Watir::Select with multiple select from start node' do
          options = %w(Option2 Option3)
          expect(start_node).to receive(:label)
                                  .and_return(field_label('Multi Select'))
          browser.fill_in('Multi Select', options, start_node: start_node)

          multiselect = browser.select(id: 'multiselect')
          expect(multiselect.selected_options.count).to eq(2)
          expect(multiselect.selected_options.map(&:text)).to eq(options)
        end

        it 'fills a Watir::TextField from start node' do
          expect(start_node).to receive(:label)
                                  .and_return(field_label('Text Field'))
          browser.fill_in('Text Field', 'test text', start_node: start_node)
          expect(browser.text_fields.first.value).to eq('test text')
        end

        it 'fills a Watir::TextArea from start node' do
          expect(start_node).to receive(:label)
                                  .and_return(field_label('Text Area'))
          browser.fill_in('Text Area', 'test text', start_node: start_node)
          expect(browser.textareas.first.value).to eq('test text')
        end

        it 'fills a Watir::FileField from start node' do
          expect(start_node).to receive(:label)
                                  .and_return(field_label('File'))
          browser.fill_in('File',
                          File.join(HTML_DIR, FORM_PAGE),
                          start_node: start_node
          )
          expect(browser.file_fields.first.value).to eq(FORM_PAGE)
        end

        it 'fills a Watir::OptionGroup from start node' do
          options = %w(Checkbox5 Radio7)
          expect(start_node).to receive(:label)
                                  .and_return(
                                    field_label('Radios and Checkboxes')
                                  )
          browser.fill_in('Radios and Checkboxes',
                          options,
                          start_node: start_node
          )

          option_group = browser.option_group(id: 'radio_and_checkbox')
          expect(option_group.selected_options.count).to eq(2)
          expect(option_group.selected_options).to eq(options)
        end
      end # descibe: with a start node


      describe 'with placeholder: true' do
        it 'fills a Watir::TextField with given text' do
          target_field = browser.text_field(id: 'placeholder_text')
          browser.fill_in('Placeholder Text', 'Test Text', placeholder: true)
          expect(target_field.value).to eq('Test Text')
        end

        it 'fills a Watir::TextArea with given text' do
          target_field = browser.textarea(id: 'placeholder_area')
          browser.fill_in('Placeholder Area', 'Test Text', placeholder: true)
          expect(target_field.value).to eq('Test Text')
        end
      end# with placeholder: true


      describe 'using id: true' do
        it 'fills field with specified id' do
          text_id = 'text'
          browser.fill_in(text_id, 'test', id: true)
          expect(browser.field(text_id, id: true).value).to eq('test')
        end
      end# using id: true
    end # #fill_in
    ################################################################################################


    describe '#value_of' do
      before(:all){ @browser.refresh }
      describe 'without a start node' do
        it 'returns value of Watir::Checkbox' do
          browser.fill_in('Checkbox', true)
          expect(browser.value_of('Checkbox')).to be true
          browser.fill_in('Checkbox', false)
          expect(browser.value_of('Checkbox')).to be false
        end

        it 'returns value of Watir::Radio' do
          browser.fill_in('Radio', true)
          expect(browser.value_of('Radio')).to be true
        end

        it 'returns value of Watir::FileField' do
          browser.fill_in('File', File.join(HTML_DIR, FORM_PAGE))
          expect(browser.value_of('File')).to eq(FORM_PAGE)
        end

        it 'returns value of Watir::TextField' do
          browser.fill_in('Text Field', 'test text')
          expect(browser.value_of('Text Field')).to eq('test text')
        end

        it 'returns value of Watir::TextArea' do
          browser.fill_in('Text Area', 'test text')
          expect(browser.value_of('Text Area')).to eq('test text')
        end

        it 'returns value of Watir::Select with single select' do
          browser.fill_in('Select', 'Test2')
          expect(browser.value_of('Select')).to eq('Test2')
        end

        it 'returns value of Watir::Select with multiple select' do
          target_value = %w(Option2 Option3)
          browser.fill_in('Multi Select', target_value)
          expect(browser.value_of('Multi Select')).to eq(%w(Option2 Option3))
        end

        it 'returns value of Watir::OptionGroup' do
          options = %w(Checkbox5 Radio7)
          browser.fill_in('Radios and Checkboxes', options)
          expect(browser.value_of('Radios and Checkboxes')).to eq(options)
        end
      end # desribe: without a start node


      describe 'with a start node' do
        before(:all){ @browser.refresh }
        let(:start_node){ browser.element(id: 'main_content') }

        it 'returns value of Watir::Checkbox from start node' do
          browser.fill_in('Checkbox', true, start_node: start_node)
          expect(start_node).to receive(:label)
                                  .and_return(field_label('Checkbox'))
          expect(browser.value_of('Checkbox', start_node: start_node)).to be true
        end

        it 'returns value of Watir::Radio from start node' do
          browser.fill_in('Radio', true, start_node: start_node)
          expect(start_node).to receive(:label).and_return(field_label('Radio'))
          expect(browser.value_of('Radio', start_node: start_node)).to be true
        end

        it 'returns value of Watir::Select  with single select from start node' do
          browser.fill_in('Select', 'Test2', start_node: start_node)
          expect(start_node).to receive(:label)
                                  .and_return(field_label('Select'))
          expect(browser.value_of('Select', start_node: start_node))
            .to eq('Test2')
        end

        it 'returns value of Watir::Select with multiple select from start node' do
          options = %w(Option2 Option3)
          browser.fill_in('Multi Select', options, start_node: start_node)
          expect(start_node).to receive(:label)
                                  .and_return(field_label('Multi Select'))
          expect(browser.value_of('Multi Select', start_node: start_node))
            .to eq(options)
        end

        it 'returns value of Watir::TextField from start node' do
          browser.fill_in('Text Field', 'test text', start_node: start_node)
          expect(start_node).to receive(:label)
                                  .and_return(field_label('Text Field'))
          expect(browser.value_of('Text Field', start_node: start_node))
            .to eq('test text')
        end

        it 'returns value of Watir::TextArea from start node' do
          browser.fill_in('Text Area', 'test text', start_node: start_node)
          expect(start_node).to receive(:label)
                                  .and_return(field_label('Text Area'))
          expect(browser.value_of('Text Area', start_node: start_node))
            .to eq('test text')
        end

        it 'returns value of Watir::FileField from start node' do
          browser.fill_in('File',
                          File.join(HTML_DIR, FORM_PAGE),
                          start_node: start_node
          )
          expect(start_node).to receive(:label)
                                  .and_return(field_label('File'))
          expect(browser.value_of('File', start_node: start_node))
            .to eq(FORM_PAGE)
        end

        it 'returns value of Watir::OptionGroup from start node' do
          options = %w(Checkbox5 Radio7)
          browser.fill_in('Radios and Checkboxes',
                          options,
                          start_node: start_node
          )
          expect(start_node).to receive(:label)
                                  .and_return(
                                    field_label('Radios and Checkboxes')
                                  )
          expect(browser
                   .value_of('Radios and Checkboxes', start_node: start_node)
          ).to eq(options)
        end
      end # descibe: with a start node


      describe 'with placeholder: true' do
        it 'returns value of Watir::TextField with given text' do
          browser.fill_in('Placeholder Text', 'Test Text', placeholder: true)
          expect(browser.value_of('Placeholder Text', placeholder: true))
            .to eq('Test Text')
        end

        it 'returns value of Watir::TextArea with given text' do
          browser.fill_in('Placeholder Area', 'Test Text', placeholder: true)
          expect(browser.value_of('Placeholder Area', placeholder: true))
            .to eq('Test Text')
        end
      end# with placeholder: true


      describe 'using id: true' do
        it 'returns value of field with specified id' do
          text_id = 'text'
          browser.fill_in(text_id, 'test', id: true)
          expect(browser.value_of(text_id, id: true)).to eq('test')
        end
      end# using id: true
    end
  end# Container

end
