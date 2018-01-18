class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  after_initialize :set_defaults, unless: :persisted?

  validates :body, length: { minimum: 1, maximum: 200 }, presence: true
  
  before_create :limit_reached
  
  def set_defaults
    self.completed = false if self.completed.nil?
  end
  
  def limit_reached
    if user != User.find_by_email('armando@cerrillomedia.org')
      list.items.size > 5 ? false : true
    end
  end
  
  
  
end