module Watir
  module Setable

    def fill_in(value)
      case self.tag_name
      when 'input'       then fill_input(value)
      else
        false
      end
    end


    private
    def fill_input(value)
      if self.respond_to?(:checked?)
        self.click unless value == self.checked?
        self.checked?
      end
    end
  end

  class CheckBox
    include Setable
  end
end
