require 'capybara/rspec'

module Pages
  class Settings
    include Capybara::DSL

    def open
      visit('/settings')
      self
    end

    def submit(notify_for_like:)
      if notify_for_like
        check 'notify_for_like'
      else
        uncheck 'notify_for_like'
      end

      click_on 'Save settings'
      self
    end

    def has_settings_updated_message?
      page.has_content?('Settings updated')
    end

    def has_notify_for_like_checked?
      page.find_field('notify_for_like').value == true
    end
    def has_notify_for_like_unchecked?
      not has_notify_for_like_checked?
    end

  end
end


