require 'spec_helper'

module Watir
  describe FileField do
    describe '#field_value' do
      subject { FileField.new('', id: '') }

      context 'no path is set' do
        it 'returns empty string' do
          allow(subject).to receive(:value).and_return(nil)
          expect(subject.field_value).to eq('')
        end
      end

      context 'a path is set' do
        it 'returns string with file name' do
          allow(subject).to receive(:value).and_return('form.html')
          expect(subject.field_value).to eq('form.html')
        end
      end
    end
  end
end
