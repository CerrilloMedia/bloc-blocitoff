class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  after_initialize :set_defaults, unless: :persisted?
  
  validates :title, length: { minimum: 1, maximum: 75 }, presence: true
  
  before_create :limit_reached
  
   default_scope { order('completed, created_at DESC') }
  
  def set_defaults
    self.completed = false if self.completed.nil?
  end
  
  def limit_reached
    if user.email != ENV['ADMIN_EMAIL']
      user.lists.size > 3 ? false : true
    end
  end
  
end
