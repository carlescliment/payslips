require 'bigdecimal'
require 'date'
require_relative '../../payslips/entity/payslip'


RSpec.describe Payslip do

  let(:payslip) do
    Payslip.new(
      id: 1,
      vat: 'THE VAT',
      date: Date.today(),
      gross: BigDecimal('2486.00'),
      deductions: 5.0,
      irpf: 12.00)
  end

  it 'applies new IRP for payslip' do
    payslip.apply_new_irpf!(14)

    expect(payslip.irpf).to eq(14.00)
  end

  it 'calculates the amounts' do
    expect(payslip.amount_of_deductions).to eq(BigDecimal('124.30'))
    expect(payslip.amount_of_irpf).to eq(BigDecimal('298.32'))
    expect(payslip.net).to eq(BigDecimal('2063.38'))
  end
end
