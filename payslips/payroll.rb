class Payroll
  attr_reader :month, :year, :payslips

  def initialize(month:, year:, payslips:)
    @month = month
    @year = year
    @payslips = payslips
  end

  def apply_new_irpf!(new_irpf)
    @payslips.each { |payslip| payslip.apply_new_irpf!(new_irpf) }
  end

  def self.blank(month, year)
    Payroll.new(month:month, year:year, payslips: [])
  end
end
