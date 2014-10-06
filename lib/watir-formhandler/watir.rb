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


  # Adds the placeholder attribute to input fields to allow them to be searched by it. I tried to
  # call the attribute method on Input and even TextField at first, but HTMLElement was the only one
  # with which it was successfully added. This should surely be fixed some day.
  class HTMLElement
    # TODO: find a way to move this call into TextField and TextArea where it belongs.
    attribute('String', :placeholder, :placeholder)
  end
end