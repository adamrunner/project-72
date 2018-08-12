module Denormalizable
  extend ActiveSupport::Concern

  def normalize_prefix(options)
    # ensures trailing single underscore
    # removes duplicate underscores
    # ensures no leading underscore
    # can return empty string
    "#{options[:prefix]}_".gsub(/\_+/, "_").gsub(/^_+/, "")
  end

  def parse_args(arguments)
    if arguments[-1].is_a?(Hash)
      attribute_names = arguments[0...-1]
      options         = arguments[-1].with_indifferent_access
    else
      raise "Incorrect argument format, missing options hash!"
    end

    return options, attribute_names
  end

  module ClassMethods
    def denormalize(*args)
      options, attribute_names = parse_args(args)
      # TODO: send class method to included class
      # for defining the related id

      # field "#{options[:to]}_id"

      attribute_names.each do |attribute_name|

        prefix = normalize_prefix(options)
        field_type = #TODO: get field type from included class / field definitions
        # send method to included class
        # field "#{prefix}#{attribute_name}", type: type_class
      end
    end
  end
end