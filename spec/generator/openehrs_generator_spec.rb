require 'generators/openehr/openehr_generator'

RSpec.describe "ArchetypedBase", type: :generator do
  describe ArchetypedBase do
    let(:opt_file) { Rails.root.join('app', 'archetypes', 'covid19_self_monitoring.opt').to_s }

    context 'operational template file' do
      it 'operational template file is opt_file' do
        archetyped_base = ArchetypedBase.new([opt_file])
        expect(archetyped_base.operational_template_file).to eq opt_file
      end
    end

    describe 'protected values' do
      let(:archetyped_base) { ArchetypedBase.new([opt_file])}
      
      context 'archetype path' do
        it 'archetype_path is app/archetypes' do
          expect(archetyped_base.archetype_path).to eq Rails.root.join('app/archetypes').to_s
        end
      end

#         context 'model name' do
#           it 'is origined form archetype id' do
#             expect(archetyped_base.model_name).to eq 'open_ehr_ehr_observ
# ation_blood_pressure_v1'
#           end
#         end

      context 'controller_name' do
        it 'is originated from archtype id' do
          expect(archetyped_base.controller_name).to eq 'covid19_self_monitoring'
        end
      end
    end
  end
end
