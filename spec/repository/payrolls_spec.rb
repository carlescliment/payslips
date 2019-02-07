require_relative '../../payslips/repository/payrolls'


RSpec.describe Payrolls do

  let (:fixtures_path) { "#{File.dirname(__FILE__)}/../fixtures" }

  before(:each) do
    @payrolls = Payrolls.new(fixtures_path)
  end

  context 'when loading payrolls' do
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
        expect(payslips_read[0].irpf).to eq(12.00)
      end
    end

    context 'with unexisting file for year and month' do
      it 'returns an empty list' do
        payslips_read = @payrolls.by_month_and_year(1, 2018).payslips

        expect(payslips_read).to be_empty
      end
    end
  end

  context 'when storing payrolls' do
    it 'writes the contents' do
      file = StringIO.new
      payroll = Payroll.new(month: 12, year: 2018, payslips: [
        Payslip.new(id: 1, vat: '97084172E', date: Date.parse('2018-12-31'),
                    gross: 248600, deductions: 5.0, irpf: 12.0)
      ])
      expect(File).to receive(:open).with("#{fixtures_path}/payslips.201812.txt", 'w').and_yield(file)

      expected_output = "00000000000197084172E201812310024860005000001243012000002983200206338\n"
      expect(file).to receive(:write).with(expected_output)

      @payrolls.store(payroll)
    end
  end
end
