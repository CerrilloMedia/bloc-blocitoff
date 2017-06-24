class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  after_initialize :set_defaults, unless: :persisted?
  
  validates :body, length: { minimum: 1, maximum: 100 }, presence: true
  
  def set_defaults
    self.completed = false if self.completed.nil?
  end
  
end