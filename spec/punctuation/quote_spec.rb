require 'spec_helper'

describe 'smart single quotes' do  
  context 'Encyclopaedia of the Qurʼān' do
    it 'Qurʼan and Qur\'an should return the same results' do
      resp = solr_resp_ids_from_query 'Encyclopaedia of the Qurʼān'
      expect(resp).to include('DUKE003888510')
    end

    it 'Qurʼan and Qur\'an should return the same results' do
      resp = solr_resp_ids_from_query 'Encyclopaedia of  the Qur\'an'
      expect(resp).to include('DUKE003888510')
    end
  end
end  