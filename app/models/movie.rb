class Movie < BaseModel

  attribute :title
  attribute :date
  attribute :description

  reference :user, :User

  set :likers, :User
  set :haters, :User
end

