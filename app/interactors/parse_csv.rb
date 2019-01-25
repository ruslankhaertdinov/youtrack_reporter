require 'csv'

class ParseCsv
  include Interactor

  DONE_STATES = ['В продуктиве', 'Готово'].freeze
  PROJECTS = {
    finsup20: 'Финансовый супермаркет',
    etpgpb_open_part: 'ЭТП ГПБ открытая часть',
    tradeins2: 'Трейдинспект',
    ucgpb: 'Удостоверяющий Центр',
    arbitr: 'Арбитражный суд',
    elk: 'Единый Личный Кабинет',
    invest: 'ИнвестВитрина',
    invest_open_part: 'ИнвестВитрина открытая часть'
  }.freeze

  delegate :source_path, to: :context

  def call
    context.parsed_data = parsed_data
  rescue
    context.fail!(error: 'Некорректный источник данных')
  end

  private

  # Название проекта
  # Название задачи
  # Процент выполнения
  # Автор
  def parsed_data
    testers = fetch_testers

    raw_data[1..-1].map do |row|
      next if row[4].in?(testers)

      {
        project: project_name(row[6]),
        title: row[7],
        percent: percent(row[8]),
        author: row[5]
      }
    end.compact
  end

  # row[4] - user_login
  # row[5] - user_fullname
  # row[6] - issue_id
  # row[7] - title
  # row[8] - state
  def raw_data
    ::CSV.read(source_path, encoding: 'bom|utf-8')
  end

  def project_name(issue_id)
    key = issue_id.sub(/-\d+$/, '').downcase.to_sym # ARBITR-1185 => arbitr
    PROJECTS[key]
  end

  def percent(state)
    state.in?(DONE_STATES) ? '100%' : '50%'
  end

  def fetch_testers
    return %w[s.sidorova] if Rails.env.test?

    (ENV['TESTERS'] || '').split(',').map(&:strip)
  end
end
