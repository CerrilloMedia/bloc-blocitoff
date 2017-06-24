class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  after_initialize :set_defaults, unless: :persisted?
  
  validates :title, length: { minimum: 1, maximum: 60 }, presence: true
  
  def set_defaults
    self.completed = false if self.completed.nil?
  end
end
