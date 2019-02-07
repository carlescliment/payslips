require 'sinatra'
require 'json'

require_relative './payslips/repository/payrolls'
require_relative './payslips/action/bring_payroll'

def storage_path
  './spec/payslips/fixtures'
end

class PayslipsApp
  class << self
  end
end

get '/' do
  content_type :json
  {}.to_json
end

get '/v1/:year/:month' do
  content_type :json
  payrolls = Payrolls.new(storage_path)

  begin
    BringPayroll.do(
      payrolls: payrolls,
      year: params['year'].to_i,
      month: params['month'].to_i
    ).to_json
  rescue InvalidRequest
    halt 400, 'Wrong parameters'
  end
end

put '/v1/irpf' do
  content_type :json

  request.body.rewind
  request_payload = JSON.parse request.body.read

  PayslipsApp.update(request_payload)

  {}.to_json
end
