require 'rails_helper'

describe WriteToFile do
  let(:interactor) { described_class.call(grouped_data: grouped_data) }
  let(:grouped_data) do
    array = JSON.parse(File.read('spec/fixtures/grouped_report.json'))
    array.map(&:deep_symbolize_keys)
  end
  let(:file_path) { 'tmp/report.xlsx' }

  before do
    File.delete(file_path) if File.exist?(file_path)
  end

  it 'создаст файл' do
    expect(File.exist?(file_path)).to eq(false)

    interactor

    expect(File.exist?(file_path)).to eq(true)
  end
end
