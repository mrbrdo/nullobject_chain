class NullChainer < BasicObject
  class << self
    attr_accessor :use_nullobject
  end
  @use_nullobject = false

  def initialize(obj)
    @obj = obj
  end

  def get
    if @obj.is_a?(::NilClass) && ::NullChainer.use_nullobject
      ::Null::Object.instance
    else
      @obj
    end
  end

  def method_missing(name, *args, &block)
    begin
      ::NullChainer.new(@obj.send(name, *args, &block))
    rescue ::NoMethodError
      if @obj.nil?
        ::NullChainer.new(nil)
      else
        raise $!
      end
    end
  end
end

def NullChain(obj)
  NullChainer.new(obj)
end
