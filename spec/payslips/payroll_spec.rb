require_relative '../../payslips/payslip'
require_relative '../../payslips/payroll'


RSpec.describe Payroll do

  it 'updates irpf for all payslips' do
    a_payslip = Payslip.new(id: 1, vat: '97084172E', date: Date.parse('2018-12-31'),
                            gross: 248600, deductions: 5.0, irpf: 12.0)
    another_payslip = Payslip.new(id: 2, vat: '97084172E', date: Date.parse('2018-12-31'),
                                  gross: 248600, deductions: 5.0, irpf: 12.0)
    payroll = Payroll.new(month: 12, year: 2018, payslips: [a_payslip, another_payslip])

    payroll.apply_new_irpf!(14.0)

    expect(a_payslip.irpf).to(equal(14.0))
    expect(another_payslip.irpf).to(equal(14.0))
  end
end
