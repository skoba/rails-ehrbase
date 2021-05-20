# coding: utf-8
require 'orca_api'

class Person < ApplicationRecord
  attr_accessor :ehr

  before_create do
    self.ehr = Ehr.create! if @ehr.nil?
    self.ehr_id = @ehr.id
  end

  def name
    @name ||= params['WholeName']
  end

  def dob
    @dob ||= params['BirthDate']
  end

  def gender
    @gender ||= ['', '男','女',][params['Sex'].to_i]
  end

  def params
    @params ||= get_params_from_orca
  end


  def get_params_from_orca
    @con ||= HTTPClient.new(base_url: 'http://localhost:8888/api01rv2/')
    @con.set_auth('http://localhost:8888/api01rv2/', 'ormaster', 'ormaster')
    res = @con.get_content('patientgetv2', id: orca_id, 'format' => 'json')
    JSON.parse(res)['patientinfores']['Patient_Information']
  end

  def rm_type
    'Person'
  end
end
