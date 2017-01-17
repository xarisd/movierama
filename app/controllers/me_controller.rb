class MeController < ApplicationController

    # Action for `GET /settings`
    # Displays the logged in user's settings for editing
    def settings
        authorize! :update, current_user

        user = current_user
        @user_settings = {
            notify_for_like: user.notify_for_like
        }
        @validator = NullValidator.instance
    end

    # Action for `POST /settings`
    # Updates the user's settings and redirects to the same page
    def update_settings
        authorize! :update, current_user

        user = current_user
        @validator = UserSettingsValidator.new(user)

        # Manually update the user for added security
        # TODO : Simplify or abstract away this code (Issue:
        notify_for_like_value = params['notify_for_like']
        case notify_for_like_value
        when '1'
            user.notify_for_like = true
        when '0'
            user.notify_for_like = false
        end

        if @validator.valid?
          user.save
          flash[:notice] = "Settings updated"
          redirect_to settings_url
        else
          flash[:error] = "Errors were detected"
          render 'settings'
        end
    end
end
