require 'spec_helper'

module Watir
  describe CheckBox do
    before(:each)   { @checkbox = Watir::CheckBox.new('', id: '') }
    let(:checkbox)  { @checkbox                                   }

    describe '#set' do

      context 'when given true' do
        it 'checks it if unchecked' do
          allow(checkbox).to receive(:checked?).and_return(false)
          expect(checkbox).to receive(:click)
          checkbox.set(true)
        end

        it 'does not check it if checked' do
          allow(checkbox).to receive(:checked?).and_return(true)
          expect(checkbox).to_not receive(:click)
          checkbox.set(true)
        end
      end


      context 'when given false' do
        it 'unchecks it if checked' do
          allow(checkbox).to receive(:checked?).and_return(true)
          expect(checkbox).to receive(:click)
          checkbox.set(false)
        end

        it 'does not uncheck it if unchecked' do
          allow(checkbox).to receive(:checked?).and_return(false)
          expect(checkbox).to_not receive(:click)
          checkbox.set(false)
        end
      end #context when given false
    end # #set


    describe '#field_value' do
      context 'if checked' do
        it 'returns true' do
          allow(checkbox).to receive(:checked?).and_return(true)
          expect(checkbox.field_value).to eq(true)
        end
      end
      context 'if unchecked' do
        it 'returns false' do
          allow(checkbox).to receive(:checked?).and_return(false)
          expect(checkbox.field_value).to eq(false)
        end
      end
    end # #read
  end
end
