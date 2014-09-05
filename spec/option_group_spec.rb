require 'spec_helper'

module Watir
  describe OptionGroup do
    before(:all) { @browser = Watir::Browser.new }
    after(:all)  { @browser.close}
    let(:browser){ @browser }

    before(:each) { browser.goto(local_url(FORM_PAGE)) }

    describe 'behaving like a normal Watir::Element' do
      describe '#exists? should return' do
        it 'true if it is present in the DOM' do
          expect(browser.option_group(id: 'radioset').exist?).to eq(true)
        end

        it 'false otherwise' do
          expect(browser.option_group(id: 'nowhere').exist?).to eq(false)
        end
      end
    end


    describe '#option_names' do
      it 'gives the names of all available checkboxes'  do
        expected_options = %w(Checkbox1 Checkbox2 Checkbox3 Checkbox4)
        expect(browser.option_group(id: 'checkboxset').option_names).to include(*expected_options)
      end

      it 'gives the names of all available radio buttons'  do
        expected_options = %w(Radio1 Radio2 Radio3 Radio4)
        expect(browser.option_group(id: 'radioset').option_names).to include(*expected_options)
      end

      it 'gives the names of all available radio buttons and checkboxes'  do
        expected_options = %w(Checkbox5 Checkbox6 Radio5 Radio6 Radio7)
        option_group = browser.option_group(id: 'radio_and_checkbox')
        expect(option_group.option_names).to include(*expected_options)
      end
    end


    describe '#option_fields' do
      it 'provides all fields belonging to an OptionGroup of checkboxes' do
        expected_ids = %w(checkbox1 checkbox2 checkbox3 checkbox4)
        option_group = browser.option_group(id: 'checkboxset')
        expect(option_group.option_fields.map(&:id)).to include(*expected_ids)
      end

      it 'provides all fields belonging to an OptionGroup of radio buttons' do
        expected_ids = %w(radio1 radio2 radio3 radio4)
        option_group = browser.option_group(id: 'radioset')
        expect(option_group.option_fields.map(&:id)).to include(*expected_ids)
      end

      it 'provides all fields belonging to an OptionGroup of radio buttons and checkboxes' do
        expected_ids = %w(checkbox5 checkbox6 radio5 radio6 radio7)
        option_group = browser.option_group(id: 'radio_and_checkbox')
        expect(option_group.option_fields.map(&:id)).to include(*expected_ids)
      end
    end


    describe '#options' do
      it 'gives a hash with all available checkboxes and their labels' do
        option_hash = {'Checkbox1' => 'checkbox1',
                       'Checkbox2' => 'checkbox2',
                       'Checkbox3' => 'checkbox3',
                       'Checkbox4' => 'checkbox4'
        }
        found_options = browser.option_group(id: 'checkboxset').options

        expect(found_options).to be_a(Hash)
        expect(found_options.keys).to eq(option_hash.keys)
        expect(found_options.values.map(&:id)).to eq(option_hash.values)
      end

      it 'gives a hash with all available radio buttons and their labels' do
        option_hash = {'Radio1' => 'radio1',
                       'Radio2' => 'radio2',
                       'Radio3' => 'radio3',
                       'Radio4' => 'radio4'
        }
        found_options = browser.option_group(id: 'radioset').options

        expect(found_options).to be_a(Hash)
        expect(found_options.keys).to eq(option_hash.keys)
        expect(found_options.values.map(&:id)).to eq(option_hash.values)
      end

      it 'gives a hash with all available radio buttons, checkboxes and their labels' do
        option_hash = { 'Checkbox5' => 'checkbox5',
                        'Checkbox6' => 'checkbox6',
                        'Radio5'    => 'radio5',
                        'Radio6'    => 'radio6',
                        'Radio7'    => 'radio7',
        }
        found_options = browser.option_group(id: 'radio_and_checkbox').options

        expect(found_options).to be_a(Hash)
        expect(found_options.keys).to eq(option_hash.keys)
        expect(found_options.values.map(&:id)).to eq(option_hash.values)
      end
    end


    describe '#set' do
      context 'without preselected elements' do
        context 'for OptionGroup only containing checkboxes' do
          before(:each){ @option_group = browser.option_group(id: 'checkboxset') }

          it 'clicks a single option' do
            target_option = browser.checkbox(id: 'checkbox1')
            @option_group.set('Checkbox1')
            expect(target_option).to be_checked
          end

          it 'clicks multiple options' do
            target_options = browser.element(id: 'checkboxset').checkboxes[0..1]
            @option_group.set('Checkbox1', 'Checkbox2')
            target_options.each{ |option| expect(option).to be_checked }
          end

          it 'click multiple options given as array' do
            target_options = browser.element(id: 'checkboxset').checkboxes[0..1]
            @option_group.set(%w(Checkbox1 Checkbox2))
            target_options.each{ |option| expect(option).to be_checked }
          end
        end


        context 'for OptionGroup only containing radio buttons' do
          it 'clicks a single option'
          it 'clicks multiple options'
          it 'click multiple options given as array'
        end


        context 'for OptionGroup containing checkboxes and radio buttons' do
          it 'clicks a single option'
          it 'clicks multiple options'
          it 'click multiple options given as array'
        end
      end

      context 'with preselected elements' do
        context 'for OptionGroup only containing checkboxes' do
          it 'selects a single option and deselects any other'
          it 'selects multiple options and deselect unwanted ones'
          it 'performs no clicks if preselected elements equal desired ones'
        end


        context 'for OptionGroup only containing radio buttons' do
          it 'clicks a single option'
          it 'does not click if option is already selected'
          it 'performs no clicks if preselected elements equal desired ones'
        end


        context 'for OptionGroup containing checkboxes and radio buttons' do
          it 'selects a single option and deselects any other'
          it 'selects multiple options and deselect unwanted ones'
          it 'performs no clicks if preselected elements equal desired ones'
        end
      end
    end
  end
end
