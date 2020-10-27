class ApplicationController < ActionController::Base
    helper_method %i[current_user current_user_id logged_in? logged_out?]
    def current_user
        return @current_user if defined?(@current_user)
        @current_user = !cookies.signed[:user_id].blank? ? User.find(cookies.signed[:user_id]) : nil
    end

    def current_user_id
        current_user&.id
    end

    def logged_in?
        !!current_user
    end

    def logged_out?
        !logged_in?
    end

    def require_logged_in
        return if logged_in?
        redirect_to new_session_path, alert: 'Login required to view this page'
    end

    def require_logged_out
        return if logged_out?
        redirect_to root_path, alert: 'You cannot view this page while logged in'
    end

end
