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
    # return [Hash<label => field>] hash with all labels and fields.
    def options
      self.labels.reduce({}) do |option_hash, label|
        option_hash[label.text] = element(id: label.for)
        option_hash
      end
    end
  end # OptionGroup
end # Watir
