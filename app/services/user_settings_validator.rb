# Mimics ActiveModel::Validator (to an extent)
class UserSettingsValidator
  def initialize(user)
    @user = user
    @errors = nil
  end

  def valid?
    errors.empty?
  end

  def errors
    return @errors if @errors
    @errors = {}

    # if @user.title.blank?
    #   @errors[:title] = true
    # end

    @errors
  end

  def class_for(field)
    errors[field] ? "has-error" : ""
  end
end
