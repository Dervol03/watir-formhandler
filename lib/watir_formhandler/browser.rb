module Watir
  class Browser
    # Searches for the specified label and returns the form field belonging to it, identified by the
    # 'for' attribute of the label. Alternatively, you may pass a Watir::Label.
    # @param [String, Watir::Label] label the label for which to find the form field.
    # @param [Watir::Element] start_node the node where to start searching for the label.
    # @return [Watir::Element] form field of the given label.
    def field(label, start_node: nil, include_groups: false)
      start_node ||= self
      field_label = label.respond_to?(:for) ? label : start_node.label(text: label)
      determine_field(start_node, field_label, include_groups)
    end


    private
    def determine_field(start_node, label, include_groups)
      if include_groups
        group_member_count = label.parent.checkboxes.count + label.parent.radios.count
        return option_group(label.parent) if group_member_count > 1
      end

      field_id = label.for
      found_field = start_node.element(id: field_id)
      found_field ? found_field.to_subtype : nil
    end
  end
end
