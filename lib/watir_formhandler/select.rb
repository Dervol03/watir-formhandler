module Watir
  require 'watir-webdriver/elements/select'
  class Select
    # Selects the given option(s) of this Select. If this Select has the 'multiple' attribute, it
    # accept an array, otherwise it will call the internal '#select' method.
    # @param [String, Array<String>] values the values to be selected.
    # @return [String, Array<String>] the selected values.
    def set(*values)
      if multiple?
        select_multiple(*values)
      else
        select(values.first)
      end
    end


    # Selects the given options of this Select.
    # @param [Array<String>] values to be selected.
    # @return [Array<String>] the selected values.
    def select_multiple(*values)
      clear
      values.flatten.each{ |value| select(value) }
    end


    # Selected option(s) of this Select.
    # @return [String, Array<String>] if only one option is selected, return it as string,
    # otherwise, return it as an array of strings.
    def field_value
      opts = selected_options
      opts.count == 1 ? opts.first.text : opts.map(&:text)
    end
  end
end