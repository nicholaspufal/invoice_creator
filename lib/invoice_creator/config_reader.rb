require "yaml"
require "ostruct"
require "singleton"

class InvoiceCreator::ConfigReader
  include Singleton

  def initialize
    @yaml = YAML.load_file("config.yml")
  end

  def settings
    @settings ||= OpenStruct.new(@yaml["settings"])
  end

  def data
    @data ||= OpenStruct.new(@yaml["data"])
  end

  # Hacky way to avoid having to define a method for each of the config properties.
  # Here just for fun and to make it easier to play around with the code.
  # This causes undesireable downstream effects, i.e. calling `respond_to?(:anything)`
  # would return true, which it's fine in this codebase/project
  def method_missing(method, *args, &block)
    settings.public_send(method) || data.public_send(method) || super
  end

  def respond_to_missing?(method_name, *args)
    true
  end
end
