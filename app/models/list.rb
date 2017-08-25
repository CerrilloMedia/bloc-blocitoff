class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  after_initialize :set_defaults, unless: :persisted?
  
  validates :title, length: { minimum: 1, maximum: 75 }, presence: true
  
  before_create :limit_reached
  
  def set_defaults
    self.completed = false if self.completed.nil?
  end
  
  def limit_reached
    if user != User.find_by_email('armando@cerrillomedia.org')
      user.lists.size > 3 ? false : true
    end
  end
  
end
