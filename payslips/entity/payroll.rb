class Payroll
  attr_reader :month, :year, :payslips

  def self.blank(month, year)
    Payroll.new(month:month, year:year, payslips: [])
  end

  def initialize(month:, year:, payslips:)
    @month = month
    @year = year
    @payslips = payslips
  end

  def apply_new_irpf!(new_irpf)
    @payslips.each { |payslip| payslip.apply_new_irpf!(new_irpf) }
  end

  def to_h
    {
      month: @month,
      year: @year,
      payslips: @payslips.collect(&:to_h)
    }
  end
end
