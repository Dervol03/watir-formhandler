require 'spec_helper'


module Watir
  describe Browser do
    before(:all) { @browser = Watir::Browser.new }
    after(:all)  { @browser.close}
    let(:browser){ @browser }
    before(:each) { browser.goto(local_url(FORM_PAGE))}




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
          browser.fill_in('Multi Select', %w(Option2 Option3))
          multiselect = browser.select(id: 'multiselect')
          expect(multiselect.selected_options.count).to eq(2)
          expect(multiselect.selected_options.map(&:text)).to eq(%w(Option2 Option3))
        end

        it 'fills a Watir::OptionGroup' do
          browser.fill_in('Checkbox5', %w(Checkbox5 Radio7), include_groups: true)
          option_group = browser.option_group(id: 'radio_and_checkbox')
          expect(option_group.selected_options.count).to eq(2)
          expect(option_group.selected_options).to eq(%w(Checkbox5 Radio7))
        end
      end # desribe: without a start node


      describe 'with a start node' do
        let(:start_node){ browser.element(id: 'main_content') }

        it 'fills a Watir::Checkbox from start node' do
          allow(start_node).to receive(:label).and_return(browser.label(text: 'Checkbox'))
          expect(start_node).to receive(:label)
          browser.fill_in('Checkbox', true, start_node: start_node)
          expect(browser.checkboxes.first).to be_checked
        end

        it 'fills a Watir::Radio from start node' do
          allow(start_node).to receive(:label).and_return(browser.label(text: 'Radio'))
          expect(start_node).to receive(:label)
          browser.fill_in('Radio', true, start_node: start_node)
          expect(browser.radios.first).to be_checked
        end

        it 'fills a Watir::Select  with single select from start node' do
          allow(start_node).to receive(:label).and_return(browser.label(text: 'Select'))
          expect(start_node).to receive(:label)
          browser.fill_in('Select', 'Test2', start_node: start_node)
          expect(browser.selects.first.selected_options.count).to eq(1)
          expect(browser.selects.first.selected_options.first.text).to eq('Test2')
        end

        it 'fills a Watir::Select with multiple select from start node' do
          allow(start_node).to receive(:label).and_return(browser.label(text: 'Multi Select'))
          expect(start_node).to receive(:label)
          browser.fill_in('Multi Select', %w(Option2 Option3), start_node: start_node)
          multiselect = browser.select(id: 'multiselect')
          expect(multiselect.selected_options.count).to eq(2)
          expect(multiselect.selected_options.map(&:text)).to eq(%w(Option2 Option3))
        end

        it 'fills a Watir::TextField from start node' do
          allow(start_node).to receive(:label).and_return(browser.label(text: 'Text Field'))
          expect(start_node).to receive(:label)
          browser.fill_in('Text Field', 'test text', start_node: start_node)
          expect(browser.text_fields.first.value).to eq('test text')
        end

        it 'fills a Watir::TextArea from start node' do
          allow(start_node).to receive(:label).and_return(browser.label(text: 'Text Area'))
          expect(start_node).to receive(:label)
          browser.fill_in('Text Area', 'test text', start_node: start_node)
          expect(browser.textareas.first.value).to eq('test text')
        end

        it 'fills a Watir::FileField from start node' do
          allow(start_node).to receive(:label).and_return(browser.label(text: 'File'))
          expect(start_node).to receive(:label)
          browser.fill_in('File', File.join(HTML_DIR, FORM_PAGE), start_node: start_node)
          expect(browser.file_fields.first.value).to eq(FORM_PAGE)
        end

        it 'fills a Watir::OptionGroup from start node' do
          allow(start_node).to receive(:label).and_return(browser.label(text: 'Checkbox5'))
          expect(start_node).to receive(:label)
          browser.fill_in(
            'Checkbox5', %w(Checkbox5 Radio7), include_groups: true, start_node: start_node
          )
          option_group = browser.option_group(id: 'radio_and_checkbox')
          expect(option_group.selected_options.count).to eq(2)
          expect(option_group.selected_options).to eq(%w(Checkbox5 Radio7))
        end
      end # descibe: with a start node
    end # #fill_in
  end
end
