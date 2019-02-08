class Payslip

  attr_reader :id, :vat, :date, :gross, :deductions, :irpf

  def initialize(id:, vat:, date:, gross:, deductions:, irpf:)
    @id = id.to_i
    @vat = vat
    @date = date
    @gross = gross
    @deductions = deductions.to_f
    @irpf = irpf.to_f
  end

  def apply_new_irpf!(new_irpf)
    @irpf = new_irpf.to_f
  end

  def amount_of_deductions
    @gross * @deductions / 100
  end

  def amount_of_irpf
    @gross * @irpf / 100
  end

  def net
    @gross - amount_of_deductions - amount_of_irpf
  end

  def to_h
    {
      id: @id,
      vat: @vat,
      date: @date.strftime('%Y-%m-%d'),
      deductions: @deductions,
      irpf: @irpf,
      gross: format_number(@gross),
      amount_of_deductions: format_number(amount_of_deductions),
      amount_of_irpf: format_number(amount_of_irpf),
      net: format_number(net)
    }
  end

  private

  def format_number(number)
    "%.2f" % number.truncate(2)
  end
end
