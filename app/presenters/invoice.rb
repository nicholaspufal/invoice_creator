require "forwardable"

module Presenters
  class Invoice
    extend Forwardable

    def initialize(invoice:, config:)
      @invoice = invoice
      @config = config
    end

    def due_date
      @invoice.due_date.strftime(@config.date_format)
    end

    def date
      @invoice.invoice_date.strftime(@config.date_format)
    end

    def billable_amount
      amount(@invoice.billable_amount)
    end

    def rate
      amount(@invoice.rate)
    end

    def invoice_identifier
      sprintf(@config.invoice_identifier, @invoice.number)
    end

    def expenses_amount
      amount(@invoice.expenses_amount)
    end

    def has_expenses?
      @invoice.expenses_amount > 0
    end

    def total
      amount(@invoice.total)
    end

    def_delegators :@invoice, :billable_hours
    def_delegators :@config, :to
    def_delegators :@config, :from
    def_delegators :@config, :extra_info
    def_delegators :@config, :currency_abbreviation

    private

    def amount(amount)
      sprintf(@config.currency_format, amount)
    end
  end
end
