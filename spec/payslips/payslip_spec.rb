require_relative '../../payslips/payslip'


RSpec.describe Payslip do

  it 'calculates the amount of IRPF when applying a change on it' do
    payslip = Payslip.new(
      1,
      'THE VAT',
      Date.today(),
      248600,
      5.0,
      12430,
      12.00,
      29832,
      206337)

    payslip.apply_new_irpf!(14)

    expect(payslip.irpf).to eq(14.00)
    expect(payslip.amount_of_irpf).to eq(34804)
    expect(payslip.net).to eq(201366)
  end

  context 'with invalid payslip' do
    it 'checks it' do
      payslip = Payslip.new(
        1,
        'THE VAT',
        Date.today(),
        248600,
        5.0,
        12420,
        12.00,
        29832,
        206337)

      expect do
        payslip.check!
      end.to(raise_error(InvalidPayslip))
    end
  end

  context 'with valid payslip' do
    it 'checks it' do
      payslip = Payslip.new(
        1,
        'THE VAT',
        Date.today(),
        248600,
        5.0,
        12430,
        12.00,
        29832,
        206338)

      expect do
        payslip.check!
      end.not_to(raise_error)
    end
  end
end
