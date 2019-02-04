class InvalidPayslip < Exception
end


class Payslip

  attr_reader :id, :vat, :date, :gross, :deductions, :amount_of_deductions,
              :irpf, :amount_of_irpf, :net

  def initialize(id, vat, date, gross, deductions, amount_of_deductions,
                 irpf, amount_of_irpf, net)
    @id = id
    @vat = vat
    @date = date
    @gross = gross
    @deductions = deductions
    @amount_of_deductions = amount_of_deductions
    @irpf = irpf
    @amount_of_irpf = amount_of_irpf
    @net = net
  end

  def apply_new_irpf!(new_irpf)
    @irpf = new_irpf
    recalculate!
  end

  def check!
    raise InvalidPayslip.new unless (
      @amount_of_deductions == calculate_amount_of_deductions and
      @amount_of_irpf == calculate_amount_of_irpf and
      @net == calculate_net
    )
  end


  private

  def recalculate!
    @amount_of_irpf = calculate_amount_of_irpf
    @net = calculate_net
  end

  def calculate_amount_of_irpf
    @gross * @irpf / 100
  end

  def calculate_amount_of_deductions
    @gross * @deductions / 100
  end

  def calculate_net
    @gross - @amount_of_deductions - @amount_of_irpf
  end
end
