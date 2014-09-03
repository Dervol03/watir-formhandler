module Watir
  # As the tag_to_class hash is frozen once Watir is done loading its base classes, it cannot be
  # extended with custom classes. Therefore, extend_tag_to_class unfreezes it, by replacing it with
  # a duplicate and freezing it again after the addition.
  #
  # @param [Symbol] tag the tag to add to the list.
  # @param [Element] tag_class the element class to return for the given tag.
  # @return [Hash] the new tag-class hash.
  def self.extend_tag_to_class(tag, tag_class)
    @tag_to_class = @tag_to_class.dup.merge(tag => tag_class)
    @tag_to_class.freeze
  end
end