require 'openehr'
require 'json'
require 'rails/generators'

module OpenEHR
  module Rails
    module Generators
      class ArchetypedBase < Rails::Generators::NamedBase
        source_root File.expand_path('templates', __dir__)
        
        def initialize(args, *options)
          @web_template_file = args[0]
          super
        end
        
        def web_template
          @web_template ||= JSON.parse(File.read(@web_template_file))
        end
        
        def operational_template_file
          @opt_file
        end
        
        def operational_template
          @operational_template ||=
            ::OpenEHR::Parser::OPTParser.new(operational_template_file).parse
        end
        
        def archetype_path
          Rails.root.join('app/archetypes').to_s
        end
        
        def template_name
          operational_template.concept
        end
        
        def controller_name
          template_name.underscore
        end
        
        def controller_file_path
          controller_name
        end
        
        def model_name
          
        end
      end
    end
  end
end
