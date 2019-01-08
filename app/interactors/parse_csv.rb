require 'csv'

class ParseCsv
  include Interactor

  DONE_STATES = ['В продуктиве', 'Готово'].freeze
  PROJECTS = {
    finsup20: 'Финсуп',
    etpgpb_open_part: 'ЭТП ГПБ',
    tradeins2: 'Трейдинспект',
    ucgpb: 'УЦ',
    arbitr: 'Арбитраж'
  }.freeze

  delegate :source_path, to: :context

  def call
    context.parsed_data = parsed_data
  end

  private

  # Название проекта
  # Название задачи
  # Процент выполнения
  # Автор
  def parsed_data
    raw_data[1..-1].map do |row|
      {
        project: project_name(row[6]),
        title: row[7],
        percent: percent(row[8]),
        author: row[5]
      }
    end
  end

  # row[5] - user_fullname
  # row[6] - issue_id
  # row[7] - title
  # row[8] - state
  def raw_data
    ::CSV.read(source_path, encoding: 'bom|utf-8')
  rescue ArgumentError => error
    context.fail!(error: 'Некорректный источник данных')
  end

  def project_name(issue_id)
    key = issue_id.sub(/-\d+$/, '').downcase.to_sym # ARBITR-1185 => arbitr
    PROJECTS[key]
  end

  def percent(state)
    state.in?(DONE_STATES) ? '100%' : '50%'
  end
end
