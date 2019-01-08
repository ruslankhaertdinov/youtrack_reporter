class CreateReport
  include Interactor::Organizer

  organize ParseCsv, GroupData, WriteToFile
end
