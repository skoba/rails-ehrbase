require 'openehr'

module OpenEHR
  module Rails
    module Generators
      source_root File.expand_path('templates', __dir__)

      class ArchetypedBase < Rails::Generators::NamedBase
        def initialize(args, *options)
          @opt_file = args[0]
          super
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
