class Movie < BaseModel

  attribute :title
  attribute :date
  attribute :description

  reference :user, :User

  attribute :liker_count
  attribute :hater_count

  set :likers, :User
  set :haters, :User
end

