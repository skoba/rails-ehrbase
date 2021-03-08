require 'openehr'
require 'rails/generators'

module OpenEHR
  module Rails
    module Generators

      class ArchetypedBase < ::Rails::Generators::NamedBase
        source_root File.expand_path('templates', __dir__)

        def initialize(args, *options)
          @opt_file = args[0]
          super
        end

        def web_template
          @web_template ||= JSON.parse @json_file
        end
        
        def operational_template
          @operational_template ||=
            ::OpenEHR::Parser::OPTParser.new(@opt_file).parse
        end

        def archetype_path
          Rails.root.join('app/archetypes')
        end

        def template_name
          operational_template.archetype_id.name
        end

        def controller_name
          template_name.underscore
        end

        def controller_file_path
          controller_name
        end
      end
    end
  end
end
