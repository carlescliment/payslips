require_relative '../error/invalid_request'


class UpdatePayroll
  def self.do(payrolls:, payload:)
    raise InvalidRequest unless (1..12).include?(payload[:month])

    payroll = payrolls.by_month_and_year(
      payload[:month],
      payload[:year])
    payroll.apply_new_irpf!(payload['irpf'])

    payrolls.store(payroll)
  end
end
