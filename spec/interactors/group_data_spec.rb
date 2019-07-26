require 'rails_helper'

xdescribe GroupData do
  let(:interactor) { described_class.call(parsed_data: parsed_data) }
  let(:parsed_data) do
    array = JSON.parse(File.read('spec/fixtures/report.json'))
    array.map(&:deep_symbolize_keys)
  end
  let(:expected_result) do
    array = JSON.parse(File.read('spec/fixtures/grouped_report.json'))
    array.map(&:deep_symbolize_keys)
  end

  describe '.grouped_data' do
    subject { interactor.grouped_data }

    it 'вернёт сгруппированный список' do
      expect(subject).to match_array(expected_result)
    end
  end
end
