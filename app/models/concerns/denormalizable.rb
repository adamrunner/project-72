module Denormalizable
  extend ActiveSupport::Concern
  included do
    before_create :update_denormalized_models
  end

  module ClassMethods

    attr_accessor :denormalized_fields
    def denormalize(*args)
      options, attribute_names = parse_args(args)

      self.send(:belongs_to, options[:to])

      prefix = normalize_prefix(options)

      self.denormalized_fields ||= {}.with_indifferent_access
      self.denormalized_fields[options[:to]] = attribute_names.map {|name| {"#{name}" => "#{prefix}#{name}"}}.inject(:merge)

      destination_class = options[:to].to_s.camelize.constantize

      attribute_names.each do |attribute_name|
        field_type  = self.fields[attribute_name.to_s].type
        destination_class.send(:field, "#{prefix}#{attribute_name}", {type: field_type})
      end
    end


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
  end

  def update_denormalized_models
    models = self.class.denormalized_fields.keys
    models.each do |model_name|
      model_id = self.read_attribute("#{model_name}_id")
      model = model_name.to_s.camelize.constantize.find(model_id)
      new_attributes = denormalized_attributes(model_name)
      model.update_attributes(new_attributes)
    end
  end

  def denormalized_attributes(model_name)
    fields = self.class.denormalized_fields[model_name]
    fields.each_with_object({}) do |pair,hash|
      hash[pair[1]] = self.read_attribute(pair[0])
    end
  end
end