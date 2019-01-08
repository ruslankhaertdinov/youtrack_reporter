class GroupData
  include Interactor

  delegate :parsed_data, to: :context

  def call
    write_to_file || context.fail!(error: 'Ошибка создания отчёта')
    context.grouped_data = grouped_data
  end

  private

  def grouped_data
    []
  end

  def write_to_file
    group_by_project.flat_map do |project_name, issues|
      issues.group_by { |data| data[:author] }.flat_map do |_author, author_issues|
        author_issues
      end
    end
  end

  def group_by_project
    parsed_data.group_by { |data| data[:project] }
  end
end
