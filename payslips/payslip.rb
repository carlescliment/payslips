class InvalidPayslip < Exception
end


class Payslip

  attr_reader :id, :vat, :date, :gross, :deductions, :irpf

  def initialize(id, vat, date, gross, deductions, irpf)
    @id = id
    @vat = vat
    @date = date
    @gross = gross
    @deductions = deductions
    @irpf = irpf
  end

  def apply_new_irpf!(new_irpf)
    @irpf = new_irpf
  end

  def amount_of_deductions
    (@gross * @deductions / 100).to_i
  end

  def amount_of_irpf
    (@gross * @irpf / 100).to_i
  end

  def net
    @gross - amount_of_deductions - amount_of_irpf
  end
end
