module Watir
  class Browser
    # Searches for the specified label and returns the form field belonging to it, identified by the
    # 'for' attribute of the label.
    # @param [String] label the label for which to find the form field.
    def field(label)
      element(id: label(text: label).for)
    end


  end
end