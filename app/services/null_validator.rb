class NullValidator
  include Singleton

  def valid?
    true
  end

  def errors
    {}
  end

  def class_for(field)
    ""
  end
end

