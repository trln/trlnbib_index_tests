require 'spec_helper'

describe 'oclc' do
  context 'returns Arkkitehti.' do
    it 'the query should succeed if it contains oclc less than 8 numbers' do
      resp = solr_resp_ids_titles(all_fields_search_ncsu('1514178'))
      expect(resp).to include('NCSU282495')
    end     
  end
end
