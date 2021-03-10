require 'rails_helper'

RSpec.describe OpenEHR::Rails::Generators::ArchetypedBase, type: :generator do
  let(:opt_file) { File.expand_path('../../templates/covid19_self_monitoringopenEHR-EHR-OBSERVATION
.blood_pressure.v1.adl', __FILE__) }

  context 'archetype file' do
    xit 'archetype file is adl_file' do
      archetyped_base = OpenEHR::Rails::Generators::ArchetypedBase.new([adl_file])
      expect(archetyped_base.send(:archetype_file)).to eq(File.expand_path('
../../                                                 templates/openEHR-EHR-OBSERVATION.blood_pressure.v1.adl', __FILE__))     
    end
  end
  
  xdescribe 'protected values' do
    let(:archetyped_base) { Openehr::Generators::ArchetypedBase.new([archetype])}

    context 'archetype path' do
      it 'archetype_path is app/archetypes' do
        expect(archetyped_base.send(:archetype_path)).to eq('app/archetypes')
      end
    end

    context 'model name' do
      it 'is origined form archetype id' do
        expect(archetyped_base.send(:model_name)).to eq 'open_ehr_ehr_observation_blood_pressure_v1'
      end
    end

    context 'controller_name' do
      it 'is originated from archtype id' do
        expect(archetyped_base.send(:controller_name)).to eq 'open_ehr_ehr_observation_blood_pressure_v1'         
      end
    end
  end
end
