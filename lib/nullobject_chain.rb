class NullChainer < BasicObject
  def initialize(obj)
    @obj = obj
  end

  def get
    @obj
  end

  def method_missing(name, *args, &block)
    begin
      ::NullChainer.new(@obj.send(name, *args, &block)) 
    rescue ::NoMethodError
      if @obj.nil?
        ::NullChainer.new(::Null::Object.instance)
      else
        super
      end
    end
  end
end

def NullChain(obj)
  NullChainer.new(obj)
end