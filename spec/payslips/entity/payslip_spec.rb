require_relative '../../../payslips/entity/payslip'


RSpec.describe Payslip do

  let(:payslip) do
    Payslip.new(
      id: 1,
      vat: 'THE VAT',
      date: Date.today(),
      gross: 248600,
      deductions: 5.0,
      irpf: 12.00)
  end

  it 'applies new IRP for payslip' do
    payslip.apply_new_irpf!(14)

    expect(payslip.irpf).to eq(14.00)
  end

  it 'calculates the amounts' do
    expect(payslip.amount_of_deductions).to eq(12430)
    expect(payslip.amount_of_irpf).to eq(29832)
    expect(payslip.net).to eq(206338)
  end
end
