class Payroll
  attr_reader :month, :year, :payslips

  def initialize(month, year, payslips)
    @month = month
    @year = year
    @payslips = payslips
  end
end
