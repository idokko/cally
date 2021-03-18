module ApplicationHelper
    def checked_confirmation
        Notification.where(visited_id: current_user.id, checked: false).count
    end
end
