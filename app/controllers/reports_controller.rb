class ReportsController < ApplicationController
  http_basic_authenticate_with name: ENV["BASIC_USER"], password: ENV["BASIC_PASSWORD"] if Rails.env.production?

  def new
  end

  def create
    result = CreateReport.call(source_path: report_params[:file].path)
    if result.success?
      send_file result.report_path, filename: "Отчёт #{ Date.current }.xlsx"
    else
      flash.now[:alert] = result.error
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:file)
  end
end
