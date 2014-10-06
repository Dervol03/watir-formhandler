module Watir

  # Extends the Watir::Element class to get public access on the :selector.
  class Element
    attr_reader :selector
  end
end