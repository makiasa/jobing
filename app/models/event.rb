class Event < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_end_check

  def start_end_check
    errors.add(:end_time, "は開始時刻より遅い時間を選択してください") if self.start_time > self.end_time
  end
  
end
