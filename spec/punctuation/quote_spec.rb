require 'spec_helper'

describe 'single quotes' do
  context 'Encyclopaedia of the Qurʼān' do
    it 'the query should succeed if it contains a smart quote' do
      resp = solr_resp_ids_titles(all_fields_search_duke('Encyclopaedia of the Qurʼan'))
      expect(resp).to include('DUKE003888510')
    end    

    it 'the query should succeed if it contains a straight quote' do
      resp = solr_resp_ids_titles(all_fields_search_duke('Encyclopaedia of the Qur\'an'))
      expect(resp).to include('DUKE003888510')
    end    

    it 'the query should succeed if it does not contain a quote' do
      resp = solr_resp_ids_titles(all_fields_search_duke('Encyclopaedia of the Quran'))
      expect(resp).to include('DUKE003888510')
    end
  end
end