class CrudControllerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_crud_controller_files
    @base_class_name            = "ApplicationController"
    @camelized_resource_name    = name.camelize
    @resource_attributes        = resource_attributes
    @underscored_resource_name  = name.underscore
    @underscored_resources_name = name.underscore.pluralize
    template "crud_controller.erb", "app/controllers/#{@underscored_resources_name}_controller.rb"
  end

  def resource_attributes
    resource_constant.attribute_names.map do |attribute_name|
      ":#{attribute_name}"
    end
  end

  def resource_constant
    @camelized_resource_name.constantize
  end
end