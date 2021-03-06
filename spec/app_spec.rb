require File.expand_path '../spec_helper.rb', __FILE__

describe "Payslips API" do
  it "welcomes visitors" do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to eq({}.to_json)
  end

  context 'with correct parameters' do
    it "brings payrolls" do
      get '/v1/2018/12'

      expect(last_response).to be_ok
      response = JSON.parse(last_response.body)
      expect(response["year"]).to eq(2018)
      expect(response["month"]).to eq(12)
      expect(response["payslips"].length).to eq(10)
      expect(response["payslips"][0]).to eq({
        "id" => 1,
        "vat" => "97084172E",
        "date" => "2018-12-31",
        "gross" => "2486.00",
        "amount_of_deductions" => "124.30",
        "amount_of_irpf" => "298.32",
        "deductions" => 5.0,
        "irpf" => 12.0,
        "net" => "2063.38"
      })

    end

    it "updates payroll ipfs" do
      expect(UpdatePayroll).to receive(:do) do |args|
        expect(args[:payload][:month]).to eq(12)
        expect(args[:payload][:year]).to eq(2018)
      end

      put "/v1/irpf-change", { irpf: 14.0, month: 12, year: 2018 }.to_json

      expect(last_response).to be_ok
    end
  end

  context 'with wrong parameters' do
    it 'returns bad request' do
      get '/v1/2018/13'

      expect(last_response.status).to eq(400)
    end
  end
end
