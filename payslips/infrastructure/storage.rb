class Field

  attr_reader :length

  def initialize(length)
    @length = length
  end

  def prepare(payslip)
    value(payslip).rjust(@length, '0')
  end

  def read(current_position, line)
    line[current_position..current_position+@length-1]
  end

  def value(payslip)
    raise 'not implemented'
  end

  def name()
    raise 'not implemented'
  end

  protected

  def format_decimal(decimal)
    (decimal * 100).to_i.to_s
  end
end

class Id < Field
  def value(payslip)
    payslip.id.to_s
  end

  def name
    :id
  end
end

class Vat < Field
  def value(payslip)
    payslip.vat
  end

  def name
    :vat
  end
end

class DateOfPayslip < Field
  def value(payslip)
    payslip.date.strftime('%Y%m%d')
  end

  def name
    :date
  end
end

class Gross < Field
  def value(payslip)
    format_decimal(payslip.gross)
  end

  def name
    :gross
  end
end

class Deductions < Field
  def value(payslip)
    format_decimal(payslip.deductions)
  end

  def name
    :deductions
  end
end

class AmountOfDeductions < Field
  def value(payslip)
    format_decimal(payslip.amount_of_deductions)
  end

  def name
    :amount_of_deductions
  end
end

class Irpf < Field
  def value(payslip)
    format_decimal(payslip.irpf)
  end

  def name
    :irpf
  end
end

class AmountOfIrpf < Field
  def value(payslip)
    format_decimal(payslip.amount_of_irpf)
  end

  def name
    :amount_of_irpf
  end
end

class Net < Field
  def value(payslip)
    format_decimal(payslip.net)
  end

  def name
    :net
  end
end
