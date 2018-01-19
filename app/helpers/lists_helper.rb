module ListsHelper
  
  def completed(list)
    # find the users lists
    puts "list"
    list.items.where('completed = ?', true).count.to_f / list.items.count.to_f * 100.00
  end  
  
end
