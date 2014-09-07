module Watir
  class Browser



    # Fills in the given value(s) to the passed attribute. It therefore accepts the same parameters
    # as the #field method.
    # @param [String, Watir::Label] label the label for which to find the form field.
    # @param [Watir::Element] start_node the node where to start searching for the label.
    # @param [String, Boolean, Array] value to be set.
    # @param [Boolean] include_groups whether to detect the group of a given label.
    def fill_in(label, value, start_node: nil, include_groups: nil)
      field(label, start_node: start_node, include_groups: include_groups).set(value)
    end



  end
end
