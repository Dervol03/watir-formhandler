module Watir

  # The OptionGroup represents the parent node of any grouped checkboxes or radio buttons. Its
  # purpose is to provide a way to select different options in a more natural way, like the user
  # would do it: instead of going through all checkboxes one by one and setting them to 'true',
  # OptionGroup allows to specify the option names that are desired to be opted in.
  # @example
  #   group = browser.option
  class OptionGroup < HTMLElement
    # Allows selector to be an HTMLElement, in which case the internal element will be set to this
    # HTMLElement node.
    def initialize(parent, selector)
      stripped_selector = selector.respond_to?(:selector) ? selector.selector : selector
      super parent, stripped_selector

      @element = selector if selector.respond_to?(:selector)
    end


    # Returns the names of all available options.
    # @return [Array<String>] names of all options.
    def option_names
      self.labels.map{ |label| label.text.strip }
    end


    # Returns the fields of all available options.
    # @return [Array<Element>] fields of all options.
    def option_fields
      self.checkboxes.to_a + self.radios.to_a
    end


    # Returns all available options fields and their respective label as a Hash.
    # @return [Hash<label => field>] hash with all labels and fields.
    def options
      option_hash = {}
      my_labels = option_names
      my_inputs = option_fields

      my_labels.count.times do |index|
        option_hash[my_labels[index]] = my_inputs[index]
      end
      option_hash
    end


    # Selects the given option(s) and deselects all other ones. This can not be done with
    # radio buttons, however, as they cannot be deselected.
    # @param [String, Array<String>] wanted_options to be selected.
    # @example Passing a single String
    #   group.set('Checkbox1')  #=> selects 'Checkbox1'
    # @example Passing several options
    #   group.set('Checkbox1', 'Checkbox2') #=> selects 'Checkbox1' and 'Checkbox2'
    # @example Passing several options as Array
    #   group.set(['Checkbox1', 'Radio1'])  #=> selects 'Checkbox1' and 'Radio1'
    def set(*wanted_options)
      options_to_select = [*wanted_options].flatten
      options_to_deselect = option_names - options_to_select

      @options = options
      select(options_to_select, true)
      select(options_to_deselect, false)
      @options = nil
    end


    # Returns the selected options of this OptionGroup.
    # @return [Array<String>] the selected options.
    def selected_options
      selected = []
      my_labels = option_names
      inputs.each_with_index do |field, index|
        selected << my_labels[index] if field.checked?
      end
      selected
    end


    # @see #selected_options
    def set_value
      selected_options
    end


    private
    def select(options_to_select, value_to_set)
      options_to_select.each{ |option| @options[option].set(value_to_set) }
    end
  end # OptionGroup
end # Watir
