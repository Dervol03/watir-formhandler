module Watir
  class Browser
    # Searches for the specified label and returns the form field belonging to it, identified by the
    # 'for' attribute of the label. Alternatively, you may pass a Watir::Label.
    # @param [String, Watir::Label] label the label for which to find the form field.
    # @param [Watir::Element] start_node the node where to start searching for the label.
    # @return [Watir::Element] form field of the given label.
    def field(label, start_node = nil)
      start_node ||= self
      field_id = label.respond_to?(:for) ? label.for : start_node.label(text: label).for

      found_field = start_node.element(id: field_id)
      found_field ? found_field.to_subtype : nil
    end
  end
end