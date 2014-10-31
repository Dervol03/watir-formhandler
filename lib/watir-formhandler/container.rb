module Watir
  module Container
    # Searches for the specified label and returns the form field belonging to it, identified by the
    # 'for' attribute of the label. Alternatively, you may pass a Watir::Label.
    # @param [String, Watir::Label] label the label for which to find the form field.
    # @param [Watir::Element] start_node the node where to start searching for the label.
    # @param [Boolean] include_groups whether to detect the group of a given label.
    # @param [Boolean] placeholder whether to handle label as Watir::Label or as placeholder
    #                              attribute for an input field.
    # @param [Boolean] id          assumes the given label is an HTML ID and searches for it.
    #
    # @return [Watir::Element] form field of the given label.
    def field(label, start_node: nil, include_groups: false, placeholder: false, id: false)
      start_node ||= self

      if placeholder
        start_node.element(placeholder: label).to_subtype
      elsif id
        start_node.element(id: label).to_subtype
      else
        field_label = label.respond_to?(:for) ? label : start_node.label(text: label)
        determine_field(start_node, field_label, include_groups)
      end
    end


    # Fills in the given value(s) to the passed attribute. It therefore accepts the same parameters
    # as the #field method.
    # @param [String, Watir::Label] label the label for which to find the form field.
    # @param [String, Boolean, Array] value to be set.
    # @param [Watir::Element] start_node the node where to start searching for the label.
    # @param [Boolean] include_groups whether to detect the group of a given label.
    # @param [Boolean] placeholder whether to handle label as Watir::Label or as placeholder
    #                              attribute for an input field.
    # @param [Boolean] id          assumes the given label is an HTML ID and searches for it.
    def fill_in(label, value, start_node: nil, include_groups: false, placeholder: false, id: false)
      field(label,
            start_node:     start_node,
            include_groups: include_groups,
            placeholder:    placeholder,
            id:             id
      ).set(value)
    end


    # Returns the current value of the specified form field. It therefore accepts the same
    # parameters as the #field method.
    # @param [String, Watir::Label] label the label for which to find the form field.
    # @param [Watir::Element] start_node the node where to start searching for the label.
    # @param [Boolean] include_groups whether to detect the group of a given label.
    # @param [Boolean] placeholder whether to handle label as Watir::Label or as placeholder
    #                              attribute for an input field.
    # @param [Boolean] id          assumes the given label is an HTML ID and searches for it.
    # @return [String, Boolean, Array] current value of the field.
    def value_of(label, start_node: nil, include_groups: false, placeholder: false, id: false)
      field(label,
            start_node:     start_node,
            include_groups: include_groups,
            placeholder:    placeholder,
            id:             id
      ).field_value
    end


    # Returns an OptionGroup
    # @return [OptionGroup] the selected OptionGroup
    def option_group(*args)
      selector = args.first.respond_to?(:elements) ? args.first : extract_selector(args)
      OptionGroup.new(self, selector)
    end
    Watir.extend_tag_to_class(:option_group, OptionGroup)



    private
    def determine_field(start_node, label, include_groups)
      if include_groups
        group_member_count = label.parent.checkboxes.count + label.parent.radios.count
        return option_group(label.parent) if group_member_count > 1
      end

      found_field = start_node.element(id: label.for)
      found_field ? found_field.to_subtype : nil
    end
  end
end