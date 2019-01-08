require 'rails_helper'

describe ParseCsv do
  let(:interactor) { described_class.call(source_path: source_path) }

  describe '.parsed_data' do
    subject { interactor.parsed_data }

    context 'валидный источник' do
      let(:source_path) { 'spec/fixtures/report.csv' }

      let(:expected_result) do
        [
          { project: 'ЭТП ГПБ',
            title: 'Выгрузка процедур',
            percent: '50%',
            author: 'Петров Пётр' },
          { project: 'Финсуп',
            title: 'Task. Генерация pdf сертификата ЭП (бэк)',
            percent: '50%',
            author: 'Иванов Иван' },
          { project: 'Арбитраж',
            title: 'Исправить ошибку плавающих багов в тестах',
            percent: '100%',
            author: 'Носов Никита' },
          { project: 'УЦ',
            title: 'Task. Отправка данных из формы заявки на консультацию (фронт)',
            percent: '50%',
            author: 'Ломов Леонид' },
          { project: 'Трейдинспект',
            title: 'Верстка промо страницы Поставщики',
            percent: '100%',
            author: 'Иванов Иван' }
        ]
      end

      it 'вернёт распарсенный набор данных' do
        expect(interactor).to be_success
        expect(subject).to match_array(expected_result)
      end
    end

    context 'невалидный источник' do
      let(:source_path) { 'spec/fixtures/invalid_file.csv' }

      it 'вернёт сообщение об ошибке' do
        expect(interactor).to be_failure
        expect(interactor.error).to eq('Некорректный источник данных')
      end
    end
  end
end
