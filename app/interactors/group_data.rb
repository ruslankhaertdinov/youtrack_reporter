class GroupData
  include Interactor

  delegate :parsed_data, to: :context

  def call
    context.grouped_data = grouped_data
  rescue
    context.fail!(error: 'Ошибка формирования данных')
  end

  private

  def grouped_data
    group_by_project.flat_map do |_project_name, issues|
      issues.group_by { |data| data[:author] }.values.flatten
    end
  end

  def group_by_project
    parsed_data.group_by { |data| data[:project] }
  end
end
