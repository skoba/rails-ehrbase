# coding: utf-8
class DiagnosesController < ApplicationController
  def index
    @diagnoses = params[:name].empty? ? [] : Diagnosis.search_code(params[:name])
  end

  def search
  end
end
