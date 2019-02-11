require 'bigdecimal'
require 'date'

require_relative '../entity/payslip'
require_relative '../entity/payroll'
require_relative '../infrastructure/storage'


class Specification
  class << self
    def fields
      [
        Id.new(12),
        Vat.new(9),
        DateOfPayslip.new(8),
        Gross.new(8),
        Deductions.new(4),
        AmountOfDeductions.new(8),
        Irpf.new(4),
        AmountOfIrpf.new(8),
        Net.new(8)
      ]
    end

    def prepare(payslip)
      fields.collect { |field| field.prepare(payslip) }.join('')
    end

    def read(line)
      data = {}
      current_position = 0
      fields.each do |field|
        data[field.name] = field.read(current_position, line)
        current_position += field.length
      end

      data
    end
  end
end

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
    File.open(path_for(payroll.month, payroll.year), File::RDWR|File::CREAT) do |file|
      file.flock(File::LOCK_EX)
      payroll.payslips.each { |payslip| file.write("#{Specification.prepare(payslip)}\n") }
    end
  end

  private

  def path_for(month, year)
    padded_month = month.to_s.rjust(2, '0')

    "#{@path}/payslips.#{year}#{padded_month}.txt"
  end

  def as_payslip(data)
    gross = "#{data[:gross][0..-3].to_i}.#{data[:gross][-2..-1]}"

    Payslip.new(
      id: data[:id].to_i,
      vat: data[:vat],
      date: Date.parse(data[:date]),
      gross: BigDecimal(gross),
      deductions: data[:deductions].to_f / 100,
      irpf: data[:irpf].to_f / 100
    )
  end
end
