require_relative '../error/invalid_request'


class UpdatePayroll
  class << self
    def do(payrolls:, payload:)
      raise InvalidRequest unless is_valid(payload)

      payroll = payrolls.by_month_and_year(
        payload[:month],
        payload[:year])
      payroll.apply_new_irpf!(payload[:irpf])

      payrolls.store(payroll)
    end

    private

    def is_valid(payload)
      (1..12).include?(payload[:month]) and payload[:irpf]
    end
  end
end
