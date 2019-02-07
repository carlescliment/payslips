require_relative '../../payslips/repository/payrolls'
require_relative '../../payslips/action/bring_payroll'


RSpec.describe BringPayroll do
  let (:payrolls) { double(Payrolls) }

  it 'brings a payroll by month and year' do
    payroll = Payroll.blank(2, 2018)
    expect(payrolls).to receive(:by_month_and_year).with(2, 2018).and_return(payroll)

    response = BringPayroll.do(payrolls: payrolls, year: 2018, month: 2)

    expect(response).to eq({
      month: 2,
      year: 2018,
      payslips: []
    })
  end

  it 'raises an error if month is invalid' do
    expect do
      BringPayroll.do(payrolls: payrolls, year: 2018, month: 13)
    end.to raise_error(InvalidRequest)
  end
end
