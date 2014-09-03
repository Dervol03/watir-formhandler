module Watir
  module Container

    # Returns an OptionGroup
    # @return [OptionGroup] the selected OptionGroup
    def option_group(*args)
      selector = args.first.respond_to?(:elements) ? args.first : extract_selector(args)
      OptionGroup.new(self, selector)
    end

    Watir.extend_tag_to_class(:option_group, OptionGroup)
  end
end