require 'rails_helper'

describe WriteToFile do
  let(:interactor) { described_class.call(parsed_data: parsed_data) }
  let(:parsed_data) do
    array = JSON.parse(File.read('spec/fixtures/report.json'))
    array.map(&:deep_symbolize_keys)
  end
end
