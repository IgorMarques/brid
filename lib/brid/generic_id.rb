class GenericID
  def number_length; 0; end;
  def check_digits_length; 1; end;

  def initialize number
    @number = clear_number(number)

    if number_length > 0 
      raise ArgumentError.new "invalid number" if @number.length != number_length
    end
  end

  def check_digits
    @check_digits ||= begin
      @number[-check_digits_length, check_digits_length]
    end
  end

  def sequential
    @sequential ||= begin
      @number[0, @number.length - check_digits_length]
    end
  end

  def valid?
    @valid ||= begin
      valid_number == @number and not invalid_sequential?
    rescue TypeError
      false
    end
  end

  def invalid_sequential?
    @invalid_sequential ||=begin
      sequential.chars.to_a.uniq.count.eql? 1
    end
  end

  def to_s
    "#{sequential}-#{check_digits}"
  end

  protected
  def mod11 number
    Mod11.new(number)
  end

  def valid_number
    mod11(sequential) * check_digits_length
  end

  def clear_number number
    number.to_s.scan(/\d/).join
  end
end


