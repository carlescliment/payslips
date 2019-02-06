require 'date'

require_relative './payslip'
require_relative './payroll'
require_relative './storage'


class Payrolls
  def initialize(path)
    @path = path
  end

  def by_month_and_year(month, year)
    return Payroll.blank(month, year) unless File.exist?(path_for(month, year))

    lines = File.read(path_for(month, year)).split("\n")
    Payroll.new(
      month: month,
      year: year,
      payslips: lines.map { |line| as_payslip(Specification.read(line)) })
  end

  def store(payroll)
    File.open(path_for(payroll.month, payroll.year)) do |file|
      payroll.payslips.each { |payslip| file.write("#{Specification.prepare(payslip)}\n") }
    end
  end

  private

  def path_for(month, year)
    padded_month = month.to_s.rjust(2, '0')

    "#{@path}/payslips.#{year}#{padded_month}.txt"
  end

  def as_payslip(data)
    Payslip.new(
      id: data[:id].to_i,
      vat: data[:vat],
      date: Date.parse(data[:date]),
      gross: data[:gross].to_i,
      deductions: data[:deductions].to_f / 100,
      irpf: data[:irpf].to_f / 100
    )
  end
end
