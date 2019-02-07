require 'sinatra/base'
require 'sinatra/config_file'
require 'json'

require_relative './payslips/repository/payrolls'
require_relative './payslips/action/bring_payroll'
require_relative './payslips/action/update_payroll'

class PayslipsApp < Sinatra::Base
  register Sinatra::ConfigFile

  config_file 'config/config.yml'

  get '/' do
    content_type :json
    {}.to_json
  end

  get '/v1/:year/:month' do
    content_type :json

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

    begin
      UpdatePayroll.do(
        payrolls: payrolls,
        payload: {
          month: request_payload['month'],
          year: request_payload['year'],
          irpf: request_payload['irpf']
        }
      )
    rescue InvalidRequest
      halt 400, 'Wrong parameters'
    end

    {}.to_json
  end

  def payrolls
    Payrolls.new(settings.storage_path)
  end
end
