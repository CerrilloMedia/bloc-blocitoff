module UsersHelper
    
    def can_access?(user)
        
        if user != current_user
            redirect_to current_user, alert: "You are not authorized to view another profile."
        end
        
    end
    
end