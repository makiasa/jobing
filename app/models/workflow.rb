class Workflow < ApplicationRecord
  has_one_attached :file
  
  belongs_to :work
  default_scope -> { order(:number) }
  
  def self.csv_attributes
    ["work_id", "number", "content", "note", "filepath"]
  end
  
  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |workflow|
        csv << csv_attributes.map{|attr| workflow.send(attr)}
      end
    end
  end
  
end
