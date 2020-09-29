require "prawn"
require "prawn/table"

module Services
  class InvoicePrinter
    def initialize(presenter:)
      @presenter = presenter
      @prawn = Prawn::Document.new
    end

    def print
      @prawn.define_grid(:columns => 5, :rows => 8, :gutter => 10)

      @prawn.grid([0,3], [0,4]).bounding_box do
        @prawn.text "<b>INVOICE</b>", size: 30, align: :right, inline_format: true
      end

      @prawn.grid([1,3], [1,4]).bounding_box do
        @prawn.text "<b>Invoice#</b> #{@presenter.invoice_identifier}", align: :right, inline_format: true
        @prawn.move_down 5
        @prawn.text "<b>Invoice Date</b> #{@presenter.date}", align: :right, inline_format: true
        @prawn.move_down 5
        @prawn.text "<b>Due Date</b> #{@presenter.due_date}", align: :right, inline_format: true
      end

      @prawn.grid([0,0], [0,2]).bounding_box do
        @prawn.text "<b>From</b>", align: :left, inline_format: true
        @prawn.text @presenter.from
      end

      @prawn.grid([1,0], [1,2]).bounding_box do
        @prawn.text "<b>To</b>", align: :left, inline_format: true
        @prawn.text @presenter.to
      end

      @prawn.table([%w[Item HRS/QTY Rate Amount], *rows], row_colors: ["F0F0F0", "FFFFFF"], width: 550)

      @prawn.move_down 20
      @prawn.text "<b>Total (#{@presenter.currency_abbreviation}) #{@presenter.total}</b>", align: :right, inline_format: true
      @prawn.move_down 20
      @prawn.stroke_horizontal_rule
      @prawn.move_down 20

      @prawn.text @presenter.extra_info, inline_format: true

      @prawn.render_file @presenter.filename
    end

    private

    def rows
      rows = []

      rows << Array(
        ["Software Development", @presenter.billable_hours, @presenter.rate, @presenter.billable_amount]
      )

      if @presenter.has_expenses?
        rows << Array(["Expenses", 1, @presenter.expenses_amount, @presenter.expenses_amount])
      end

      rows
    end
  end
end
