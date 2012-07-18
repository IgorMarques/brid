class TituloEleitor < BrazilianID
  def number_length; 10; end;

  def initialize number
    @number = clear_number(number)
  end

  def sequential 
    @sequential ||= begin
      @number[/^(.*)....$/, 1]
    end
  end

  def uf_digit
    @uf_digit ||= begin
      @number[/(..)..$/, 1]
    end
  end

  def origin
    @origin ||= begin
      [ nil, :sp, :mg, :rj, :rs, :ba, :pr, :ce,
        :pe, :sc, :go, :ma, :pb, :pa, :es,
        :pi, :rn, :al, :mt, :ms, :df, :se,
        :am, :ro, :ac, :ap, :rr, :to, :exterior
      ][uf_digit.to_i]
    end
  end

  private
  def valid_number
    first_check_digit   = mod11(sequential).to_s
    second_check_digit  = mod11(uf_digit+first_check_digit).to_s

    sequential + uf_digit + first_check_digit + second_check_digit
  end
end

TituloEleitoral = TituloEleitor