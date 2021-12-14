class Workflow < ApplicationRecord
  has_one_attached :file
  
  belongs_to :work
  default_scope -> { order(:number) }
  
  def self.generate_csv
    CSV.generate(headers: true,encoding: Encoding::SJIS) do |csv|
      column_names = %w(年度 業務名 手順番号 内容 備考 ファイルパス)
      csv << column_names
      all.each do |workflow|
        column_values = [
          Constant::FISCAL_YEARS[workflow.work.fiscalyear],
          workflow.work.name,
          workflow.number,
          workflow.content,
          workflow.note,
          workflow.filepath
                ]
        csv << column_values
      end
    end
  end
  
end
