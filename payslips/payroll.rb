class Payroll
  attr_reader :month, :year, :payslips

  def initialize(month:, year:, payslips:)
    @month = month
    @year = year
    @payslips = payslips
  end

  def self.blank(month, year)
    Payroll.new(month:month, year:year, payslips: [])
  end
end
