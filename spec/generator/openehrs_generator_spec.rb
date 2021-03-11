require 'generators/openehr/openehr_generator'


  context 'archetype file' do
    xit 'archetype file is adl_file' do
      archetyped_base = OpenEHR::Rails::Generators::ArchetypedBase.new([adl_file])
      expect(archetyped_base.send(:archetype_file)).to eq(File.expand_path('
../../                                                 templates/openEHR-EHR-OBSERVATION.blood_pressure.v1.adl', __FILE__))     
    end
  end
  
  xdescribe 'protected values' do
    let(:archetyped_base) { Openehr::Generators::ArchetypedBase.new([archetype])}


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
