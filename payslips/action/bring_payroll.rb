require_relative '../error/invalid_request'


class BringPayroll
  def self.do(payrolls:, year:, month:)
    raise InvalidRequest unless (1..12).include?(month)

    payrolls.by_month_and_year(month, year).to_h
  end
end
