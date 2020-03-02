require "thor"

require_relative "app/config_reader"
require_relative "app/models/invoice"
require_relative "app/services/invoice_printer"
require_relative "app/presenters/invoice"

class InvoiceCreator < Thor
  desc "create HOURS [EXPENSES_AMOUNT]", "Generates an invoice for the given amount of HOURS"
  option :number, required: true
  long_desc <<-LONGDESC
    `./bin/invoice_generator create HOURS` will generate an invoice based on an amount of hours
    of your choosing. Please update `config.yml` with your preferences before
    running this command.

    You can optionally specify a second parameter that represents an expenses
    amount and which will be shown as part of a second row in your invoice.

    Example:
    > $ ./bin/invoice_generator create 168 450.25

    A flag `--number` can also be used to define the invoice's number (the default is 1).
    The actual number mask is defined within `config.yml`

    > $ ./bin/invoice_generator create --number 25 168 450.25
  LONGDESC
  def create(hours, expenses_amount = 0.0)
    invoice = Models::Invoice.new(
      rate: ConfigReader.instance.rate,
      due_day: ConfigReader.instance.due_day,
      billable_hours: hours.to_f,
      expenses_amount: expenses_amount.to_f,
      number: options[:number]
    )

    presenter = Presenters::Invoice.new(
      invoice: invoice,
      config: ConfigReader.instance
    )

    Services::InvoicePrinter.new(
      presenter: presenter,
      filename: ConfigReader.instance.filename
    ).print

    puts <<~MESSAGE
      Invoice created.
      #{Dir.pwd}/#{ConfigReader.instance.filename}
    MESSAGE
  end
end
