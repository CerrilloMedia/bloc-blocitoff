module ListsHelper
  
  def completed(list)
    (list.items.where('completed = ?', true).count.to_f / list.items.count.to_f * 100.00).to_s + '%'
  end  
  
end
