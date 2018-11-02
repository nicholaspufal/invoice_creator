require "yaml"
require "ostruct"
require "singleton"

class ConfigReader
  include Singleton

  def initialize
    @yaml = YAML.load_file("config.yml")
  end

  def extra_info
    data.extra_info
  end

  def from
    data.from
  end

  def to
    data.to
  end

  def date_format
    settings.date_format
  end

  def currency_format
    settings.currency_format
  end

  def rate
    settings.rate
  end

  def due_day
    settings.due_day
  end

  def invoice_identifier
    settings.invoice_identifier
  end

  def filename
    settings.filename
  end

  private

  def settings
    @settings ||= OpenStruct.new(@yaml["settings"])
  end

  def data
    @data ||= OpenStruct.new(@yaml["data"])
  end
end
