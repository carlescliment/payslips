require File.expand_path '../spec_helper.rb', __FILE__

describe "Payslips API" do
  it "welcomes visitors" do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to eq({}.to_json)
  end

  it "brings payrolls" do
    get '/v1/2018/12'

    expect(last_response).to be_ok
    response = JSON.parse(last_response.body)
    expect(response["year"]).to eq("2018")
    expect(response["month"]).to eq("12")
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
    expected_call_args = {
      "year" => '2018',
      "month" => "12",
      "irpf" => 14.0
    }
    expect(PayslipsApp).to receive(:update).with(expected_call_args)

    put "/v1/irpf", { irpf: 14.0, month: "12", year: "2018" }.to_json

    expect(last_response).to be_ok
  end

end
