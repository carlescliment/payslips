require_relative '../../payslips/repository/payrolls'
require_relative '../../payslips/action/update_payroll'


RSpec.describe UpdatePayroll do
  let (:payrolls) { double(Payrolls) }

  it 'updates payroll irpf' do
    payroll = Payroll.blank(2, 2018)
    allow(payrolls).to receive(:by_month_and_year).with(2, 2018).and_return(payroll)

    expect(payroll).to receive(:apply_new_irpf!)
    expect(payrolls).to receive(:store).with(payroll)

    UpdatePayroll.do(payrolls: payrolls, payload: {
      year: 2018,
      month: 2,
      irpf: 14
    })
  end

  it 'raises an error if month is invalid' do
    expect do
      UpdatePayroll.do(payrolls: payrolls, payload: {
        year: 2018,
        month: 13,
        irpf: 14
      })
    end.to raise_error(InvalidRequest)
  end
end
