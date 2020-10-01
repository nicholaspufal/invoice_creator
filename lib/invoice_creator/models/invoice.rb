require "date"

class InvoiceCreator::Models
  class Invoice
    attr_reader :expenses_amount,
                :billable_hours,
                :invoice_date,
                :rate,
                :number

    def initialize(rate:, due_day:, billable_hours:, expenses_amount: 0.0, invoice_date: Date.today, number: 1)
      @rate = rate
      @billable_hours = billable_hours
      @expenses_amount = expenses_amount
      @invoice_date = invoice_date
      @due_day = due_day
      @number = number
    end

    def due_date
      Date.new(@invoice_date.year, @invoice_date.month, @due_day)
    end

    def total
      billable_amount + @expenses_amount
    end

    def billable_amount
      @billable_hours * @rate
    end
  end
end
