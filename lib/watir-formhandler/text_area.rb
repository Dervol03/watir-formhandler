module Watir

  # Extends the Watir::TextArea class to add #field_value.
  class TextArea
    # Returns the text currently set in this TextField
    # @return [String] the current text in the field. If the field is not set at all, it will return
    #                  and empty string.
    def field_value
      value || ''
    end
  end
end