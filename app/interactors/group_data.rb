class GroupData
  include Interactor

  delegate :parsed_data, to: :context

  def call
    context.grouped_data = grouped_data.uniq
  rescue
    context.fail!(error: 'Ошибка формирования данных')
  end

  private

  def grouped_data
    group_by_author.flat_map do |_author, issues|
      issues.group_by { |data| data[:project] }.values.flatten
    end
  end

  def group_by_author
    parsed_data.group_by { |data| data[:author] }
  end
end
