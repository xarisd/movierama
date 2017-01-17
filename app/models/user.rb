class User < BaseModel
  include Ohm::Timestamps
  include Ohm::DataTypes

  attribute :name
  attribute :email
  attribute :notify_for_like, Type::Boolean


  # Unique identifier for this user, in the form "{provider}|{provider-id}"
  attribute :uid
  index     :uid
  unique    :uid

  # Session token
  attribute :token
  index     :token

  # Submitted movies
  collection :movies, :Movie
end
