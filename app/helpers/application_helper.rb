module ApplicationHelper
    
    def expiration(item)
        date = item.created_at
        expiration = "expires in"
        css_level = 'text-muted'
        ago = ''
        
        case 
            when date <= 7.days.ago
                expiration = "expired"
                css_level = 'text-danger'
                ago = " ago"
            when date <= 6.days.ago
                css_level = 'text-danger'
            when date <= 4.days.ago
                css_level = 'text-warning'
            when date < 3.day.ago
                css_level = 'text-info'
            end
            
        "<span class=\"col-xs-6 #{css_level} text-xs-left text-right\">
            #{expiration}: <strong >#{distance_of_time_in_words(date + 7.day, Time.zone.now)}#{ago}</strong>
        </span>".html_safe
    end
    
    def format_datetime(type)
        (type.completed_at || type.updated_at).strftime("%m/%d/%Y at%l:%M:%p " )
    end
    
end
