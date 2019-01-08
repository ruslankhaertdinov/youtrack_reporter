class WriteToFile
  include Interactor

  delegate :parsed_data, to: :context

  def call
    write_to_file || context.fail!(error: 'Cant write to file')
    context.report_path = report_path
  end

  private

  def write_to_file
    p = Axlsx::Package.new
    p.workbook.add_worksheet(name: 'Отчёт') do |sheet|
      sheet.add_row(%w[Проект Задача Выполнение Автор])
      group_by_project.each do |project_name, issues|
        issues.group_by { |data| data[:author] }.each do |author, author_issues|
          author_issues.uniq.each do |author_issue|
            sheet.add_row(author_issue.values)
          end
        end
      end
    end
    p.serialize(report_path)
  end

  def report_path
    'tmp/result.xlsx'
  end

  def group_by_project
    parsed_data.group_by { |data| data[:project] }
  end
end
