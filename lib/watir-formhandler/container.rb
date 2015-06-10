module Watir
  module Container

    FORM_FIELDS = [Input, Select, TextArea]

    # Searches for the specified label and returns the form field belonging to it, identified by the
    # 'for' attribute of the label. Alternatively, you may pass a Watir::Label.
    # @param [String, Watir::Label] label the label for which to find the form field.
    # @param [Watir::Element] start_node the node where to start searching for the label.
    # @param [Boolean] placeholder whether to handle label as Watir::Label or as placeholder
    #                              attribute for an input field.
    # @param [Boolean] id          assumes the given label is an HTML ID and searches for it.
    #
    # @return [Watir::Element] form field of the given label. If the field is
    #                          no form field, it will be assumed to be an
    #                          OptionGroup.
    def field(label, start_node: nil, placeholder: false, id: false)
      start_node ||= self

      if placeholder
        start_node.element(placeholder: label).to_subtype
      elsif id
        start_node.element(id: label).to_subtype
      else
        field_label = label.respond_to?(:for) ? label : start_node.label(text: label)
        determine_field(start_node, field_label)
      end
    end


    # Fills in the given value(s) to the passed attribute. It therefore accepts the same parameters
    # as the #field method.
    # @param [String, Watir::Label] label the label for which to find the form field.
    # @param [String, Boolean, Array] value to be set.
    # @param [Watir::Element] start_node the node where to start searching for the label.
    # @param [Boolean] placeholder whether to handle label as Watir::Label or as placeholder
    #                              attribute for an input field.
    # @param [Boolean] id          assumes the given label is an HTML ID and searches for it.
    def fill_in(label, value, start_node: nil, placeholder: false, id: false)
      field(label,
            start_node:     start_node,
            placeholder:    placeholder,
            id:             id
      ).set(value)
    end


    # Returns the current value of the specified form field. It therefore accepts the same
    # parameters as the #field method.
    # @param [String, Watir::Label] label the label for which to find the form field.
    # @param [Watir::Element] start_node the node where to start searching for the label.
    # @param [Boolean] placeholder whether to handle label as Watir::Label or as placeholder
    #                              attribute for an input field.
    # @param [Boolean] id          assumes the given label is an HTML ID and searches for it.
    # @return [String, Boolean, Array] current value of the field.
    def value_of(label, start_node: nil, placeholder: false, id: false)
      field(label,
            start_node:     start_node,
            placeholder:    placeholder,
            id:             id
      ).field_value
    end


    # Returns an OptionGroup
    # @return [OptionGroup] the selected OptionGroup
    def option_group(*args)
      selector = if args.first.respond_to?(:elements)
                   args.first
                 else
                   extract_selector(args)
                 end
      OptionGroup.new(self, selector)
    end
    Watir.extend_tag_to_class(:option_group, OptionGroup)


    private
    def determine_field(start_node, label)
      found_field = start_node.element(id: label.for)
      typed_field = found_field ? found_field.to_subtype : nil

      is_group?(typed_field) ? option_group(found_field) : typed_field
    end


    def is_group?(field_to_inspect)
      FORM_FIELDS.reduce(true) do |is_group, field_class|
        is_group & !field_to_inspect.is_a?(field_class)
      end
    end
  end
end