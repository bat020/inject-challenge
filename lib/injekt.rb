class Array

  def injekt(*args, &block)

    len = args.length
    message = "wrong number of arguments (#{len} for 0..2)"
    raise ArgumentError.new(message) if len >= 3

    if !block_given? || len == 2
      sym = args.pop
      message = "#{sym} is not a symbol nor a string"
      raise TypeError.new(message) unless sym.is_a?(Symbol) || sym.is_a?(String)
      block = proc { |memo, obj| memo.send(sym, obj)}
    end

    self.unshift(args.pop) unless args.empty?

    memo = self.shift

    until self.empty? do
      obj = self.shift
      memo = block.call(memo, obj)
    end

   memo

 end

end
