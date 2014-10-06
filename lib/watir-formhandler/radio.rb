require 'watir-webdriver/elements/radio'
module Watir

  # Extends the Watir::Radio class to add #set and #field_value methods.
  class Radio
    # Clicks this Radio unless #checked? returns the same value as the given one.
    # @param [Boolean] value to be set.
    # @return nil
    def set(value)
      click unless checked? || !value
    end


    # Returns whether this CheckBox is set or not.
    # @return [Boolean] is checked?
    def field_value
      checked?
    end
  end
end