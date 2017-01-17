class MeController < ApplicationController

    # Action for `GET /settings`
    # Displays the logged in user's settings for editing
    def settings
        authorize! :update, current_user

        user = current_user
        @user_settings = {
            notify_for_like: user.notify_for_like
        }
    end
end
