require 'rails_helper'

describe ParseCsv do
  let(:interactor) { described_class.call(source_path: source_path) }

  describe '.parsed_data' do
    subject { interactor.parsed_data }

    context 'валидный источник' do
      let(:source_path) { 'spec/fixtures/report.csv' }
      let(:expected_result) do
        array = JSON.parse(File.read('spec/fixtures/report.json'))
        array.map(&:deep_symbolize_keys)
      end

      it 'вернёт распарсенный набор данных' do
        expect(interactor).to be_success
        expect(subject).to match_array(expected_result)
      end
    end

    context 'невалидный источник' do
      let(:source_path) { 'spec/fixtures/invalid_file.csv' }

      it 'вернёт сообщение об ошибке' do
        expect(interactor).to be_failure
        expect(interactor.error).to eq('Некорректный источник данных')
      end
    end
  end
end
