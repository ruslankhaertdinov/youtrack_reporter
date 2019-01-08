class CreateReport
  include Interactor::Organizer

  organize ParseCsv, WriteToFile
end
