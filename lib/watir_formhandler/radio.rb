module Watir
  require 'watir-webdriver/elements/radio'
  class Radio
    # Clicks this Radio unless #checked? returns the same value as the given one.
    # @param [Boolean] value to be set.
    # @return nil
    def set(value)
      click unless checked? || !value
    end
  end
end