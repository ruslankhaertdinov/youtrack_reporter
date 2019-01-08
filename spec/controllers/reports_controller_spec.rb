require 'rails_helper'

describe ReportsController do
  describe 'GET #new' do
    it 'отобразит страницу' do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    let(:file) { Rack::Test::UploadedFile.new(File.open('spec/fixtures/report.csv')) }
    let(:params) { { report: { file: file } } }

    it 'вернёт отчёт' do
      post :create, params: params

      expect(response).to have_http_status(:ok)
      expect(response.header['Content-Type']).to eq('application/octet-stream')
    end
  end
end
