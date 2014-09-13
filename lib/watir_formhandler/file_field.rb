module Watir
  class FileField
    # Returns the file name of this FileField as a string.
    # @return [String] file name.
    def set_value
      value || ''
    end
  end
end