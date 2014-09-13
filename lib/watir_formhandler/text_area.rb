module Watir
  class TextArea
    # Returns the text currently set in this TextField
    # @return [String] the current text in the field. If the field is not set at all, it will return
    # and empty string.
    def field_value
      value || ''
    end
  end
end