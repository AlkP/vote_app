class BaseLib
  def self.call(...)
    new(...).call
  end

  def call
    process
  end

  private

  def process
    raise 'not defined'
  end
end
