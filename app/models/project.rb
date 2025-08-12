class Project < ApplicationRecord
  belongs_to :client

  STATUS_PENDING = 0
  STATUS_DONE = 1
  STATUS_CANCELLED = 2
  
  validates :title, presence: true
  validates :status, inclusion: { in: [0, 1, 2] }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :due_date, presence: true

   def status_label
    case status
    when STATUS_PENDING
      "Pending"
    when STATUS_DONE
      "Done"
    when STATUS_CANCELLED
      "Cancelled"
    else
      "Unknown"
    end
  end
  def pending?; status == STATUS_PENDING; end
  def done?; status == STATUS_DONE; end
  def cancelled?; status == STATUS_CANCELLED; end
end
