class Payslip

  attr_reader :id, :vat, :date, :gross, :deductions, :amount_of_deductions,
              :irpf, :amount_of_irpf, :net

  def initialize(id, vat, date, gross, deductions, amount_of_deductions, irpf, amount_of_irpf, net)
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
end
