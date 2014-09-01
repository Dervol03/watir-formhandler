module Watir
  class Browser
    # Searches for the specified label and returns the form field belonging to it, identified by the
    # 'for' attribute of the label. Alternatively, you may pass a Watir::Label.
    # @param [String, Watir::Label] label the label for which to find the form field.
    # @return [Watir::Element] form field of the given label.
    def field(label)
      label.respond_to?(:for) ? element(id: label.for) : element(id: label(text: label).for)
    end


  end
end