require 'csv'

class ParseCsv
  include Interactor

  DONE_STATES = ['В продуктиве', 'Готово'].freeze

  delegate :source_path, to: :context

  def call
    context.parsed_data = parsed_data
  rescue
    context.fail!(error: 'Некорректный источник данных')
  end

  private

  def parsed_data
    raw_data[1..-1].map do |row|
      next if row[1].blank?

      {
        project: row[5],
        title: row[1],
        percent: percent(row[4]),
        author: row[0]
      }
    end.compact
  end

  # row[0] - Автор
  # row[1] - Название задачи
  # row[5] - Состояние
  # row[6] - Проект
  def raw_data
    ::CSV.read(source_path, encoding: 'bom|utf-8')
  end

  def percent(state)
    state.in?(DONE_STATES) ? '100%' : '50%'
  end
end
