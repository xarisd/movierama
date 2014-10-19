require 'ohm'

class BaseModel < Ohm::Model
  def to_param
    id
  end
end
