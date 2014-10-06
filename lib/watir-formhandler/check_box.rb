require 'watir-webdriver/elements/checkbox'
module Watir

  # Extends the Watir::Checkbox class with set and field_value methods.
  class CheckBox

    # Will click the CheckBox unless the #checked? returns the same value as the given one.
    # @param [Boolean] value the value to achieve on the CheckBox.
    # @return [Boolean] the new value of this CheckBox.
    def set(value)
      click unless !!value == checked?
    end


    # Returns whether this CheckBox is set or not.
    # @return [Boolean] is checked?
    def field_value
      checked?
    end
  end
end