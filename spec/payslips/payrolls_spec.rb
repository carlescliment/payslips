require_relative '../../payslips/payrolls'


RSpec.describe Payrolls do
  before(:each) do
    @payrolls = Payrolls.new("#{File.dirname(__FILE__)}/fixtures")
  end

  context 'with file existing for year and month' do

    it 'returns as many payslips as in file' do
      payslips_read = @payrolls.by_month_and_year(12, 2018).payslips

      expect(payslips_read.length).to eq(10)
    end

    it 'builds the payslips properly' do
      payslips_read = @payrolls.by_month_and_year(12, 2018).payslips

      expect(payslips_read[0].id).to eq(1)
      expect(payslips_read[0].vat).to eq('97084172E')
      expect(payslips_read[0].date.to_s).to eq('2018-12-31')
      expect(payslips_read[0].gross).to eq(248600)
      expect(payslips_read[0].deductions).to eq(5.0)
      expect(payslips_read[0].amount_of_deductions).to eq(12430)
      expect(payslips_read[0].irpf).to eq(12.00)
      expect(payslips_read[0].amount_of_irpf).to eq(29832)
      expect(payslips_read[0].net).to eq(206337)
    end
  end

  context 'with unexisting file for year and month' do
    it 'returns an empty list' do
      payslips_read = @payrolls.by_month_and_year(1, 2018).payslips

      expect(payslips_read).to be_empty
    end
  end
end
