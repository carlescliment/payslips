require 'date'

require_relative './payslip'
require_relative './payroll'


class Payrolls
  def initialize(path)
    @path = path
  end

  def by_month_and_year(month, year)
    return Payroll.new(month, year, []) unless File.exist?(path_for(month, year))

    lines = File.read(path_for(month, year)).split("\n")
    Payroll.new(month, year, lines.map { |line| as_payslip(line) })
  end

  private

  def path_for(month, year)
    padded_month = month.to_s.rjust(2, '0')

    "#{@path}/payslips.#{year}#{padded_month}.txt"
  end

  def as_payslip(line)
    Payslip.new(
      line[0..11].to_i,
      line[12..20],
      Date.parse("#{line[21..24]}-#{line[25..26]}-#{line[27..28]}"),
      line[29..36].to_i,
      "#{line[37..38]}.#{line[39..40]}".to_f,
      "#{line[49..50]}.#{line[51..52]}".to_f
    )
  end
end
