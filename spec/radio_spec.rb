require 'spec_helper'

module Watir
  describe Radio do
    before(:each) { @radio = Watir::Radio.new('', id: '') }
    let(:radio)   { @radio }

    describe '#set' do
      context 'when given true' do
        it 'clicks it if unchecked' do
          allow(radio).to receive(:checked?).and_return(false)
          expect(radio).to receive(:click)
          radio.set(true)
        end

        it 'does not click it if checked' do
          allow(radio).to receive(:checked?).and_return(true)
          expect(radio).to_not receive(:click)
          radio.set(true)
        end
      end


      context 'when given false' do
        it 'does not click it if unchecked' do
          allow(radio).to receive(:checked?).and_return(false)
          expect(radio).to_not receive(:click)
          radio.set(false)
        end
      end
    end
  end
end
