class User < ActiveRecord::Base
  has_many :lists, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def completed_lists
    List.where('user_id = ? AND completed = ?', self.id, true).order('completed_at DESC')
  end
  
  def completed_items
    Item.where('user_id = ? AND completed = ?', self.id, true).order('completed_at DESC')
  end

end