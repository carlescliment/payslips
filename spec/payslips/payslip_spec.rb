require_relative '../../payslips/payslip'


RSpec.describe Payslip do

  it 'applies new IRP for payslip' do
    payslip = Payslip.new(
      1,
      'THE VAT',
      Date.today(),
      248600,
      5.0,
      12.00)

    payslip.apply_new_irpf!(14)

    expect(payslip.irpf).to eq(14.00)
  end

  it 'calculates the amounts' do
    payslip = Payslip.new(
      1,
      'THE VAT',
      Date.today(),
      248600,
      5.0,
      12.00)

    expect(payslip.amount_of_deductions).to eq(12430)
    expect(payslip.amount_of_irpf).to eq(29832)
    expect(payslip.net).to eq(206338)
  end
end
