module SessionsHelper
    def log_in(friend)
        session[:friend_id] = friend.id
    end

    def current_friend
        if session[:friend_id]
            @current_friend = @current_friend || Friend.find_by(id: session[:friend_id]) 
        end
    end

    def current_friend?(friend)
        friend == current_friend
    end

    def logged_in?
        !current_friend.nil?
    end

    def log_out
        session.delete(:friend_id)
        @current_friend = nil
    end
end
