class WriteToFile
  include Interactor

  delegate :grouped_data, to: :context

  def call
    write_to_file || context.fail!(error: 'Ошибка создания отчёта')
    context.report_path = report_path
  end

  private

  def write_to_file
    p = Axlsx::Package.new
    p.workbook.add_worksheet(name: 'Отчёт') do |sheet|
      sheet.add_row(%w[Проект Задача Выполнение Автор])
      grouped_data.each do |issue|
        sheet.add_row(issue.values)
      end
    end
    p.serialize(report_path)
  end

  def report_path
    'tmp/report.xlsx'
  end
end
