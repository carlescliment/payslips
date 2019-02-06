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

  def store(payroll)
    File.open(path_for(payroll.month, payroll.year)) do |file|
      payroll.payslips.each do |payslip|
        file.write(
          payslip.id.to_s.rjust(12, '0') +
          payslip.vat.rjust(9) +
          payslip.date.strftime('%Y%m%d') +
          payslip.gross.to_s.rjust(8, '0') +
          (payslip.deductions * 100).to_i.to_s.rjust(4, '0') +
          payslip.amount_of_deductions.to_s.rjust(8, '0') +
          (payslip.irpf * 100).to_i.to_s.rjust(4, '0') +
          payslip.amount_of_irpf.to_s.rjust(8, '0') +
          payslip.net.to_s.rjust(8, '0') +
          "\n"
        )
      end
    end
  end

  private

  def path_for(month, year)
    padded_month = month.to_s.rjust(2, '0')

    "#{@path}/payslips.#{year}#{padded_month}.txt"
  end

  def as_payslip(line)
    Payslip.new(
      id: line[0..11].to_i,
      vat: line[12..20],
      date: Date.parse("#{line[21..24]}-#{line[25..26]}-#{line[27..28]}"),
      gross: line[29..36].to_i,
      deductions: "#{line[37..40]}".to_f / 100,
      irpf: "#{line[49..50]}.#{line[51..52]}".to_f
    )
  end
end
