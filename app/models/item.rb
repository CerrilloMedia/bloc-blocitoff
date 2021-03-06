class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  after_initialize :set_defaults, unless: :persisted?

  validates :body, length: { minimum: 1, maximum: 200 }, presence: true
  
  before_create :limit_reached
  
  default_scope { order('completed, created_at DESC') }
  
  def set_defaults
    self.completed = false if self.completed.nil?
  end
  
  def limit_reached
    if user.email != ENV['ADMIN_EMAIL']
      list.items.size > 5 ? false : true
    end
  end
  
end