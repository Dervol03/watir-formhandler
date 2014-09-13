require 'spec_helper'

module Watir
  describe TextField do
    describe '#set_value' do
      subject { Watir::TextField.new('', id: '') }

      context 'has text' do
        it 'returns the set text' do
          allow(subject).to receive(:value).and_return('test text')
          expect(subject.set_value).to eq('test text')
        end
      end

      context 'empty' do
        it 'returns empty string'do
          allow(subject).to receive(:value).and_return('')
          expect(subject.set_value).to eq('')
        end
      end

      context 'unset' do
        it 'returns empty string'do
          allow(subject).to receive(:value).and_return(nil)
          expect(subject.set_value).to eq('')
        end
      end
    end
  end
end
