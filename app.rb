require 'sinatra'
require 'json'

require_relative './payslips/payrolls'

def storage_path
  './spec/payslips/fixtures'
end

class PayslipsApp
  class << self
    def update(year, month, payload)
    end
  end
end

get '/' do
  content_type :json
  {}.to_json
end

get '/v1/:year/:month' do
  content_type :json

  payroll = Payrolls.new(storage_path).by_month_and_year(params['month'], params['year'])
  payroll.to_h.to_json
end

put '/v1/irpf' do
  content_type :json

  request.body.rewind
  request_payload = JSON.parse request.body.read

  PayslipsApp.update(request_payload)

  {}.to_json
end
