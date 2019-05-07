require 'spec_helper'

describe 'dashes' do
  context 'utopian and anti-utopian fiction' do
    it 'the query should succeed if the dash is replaced by a space' do
      resp = solr_resp_ids_from_query 'utopian and anti utopian fiction'
      expect(resp).to include('DUKE008670706')
    end

    it 'the query should succeed if the dash is missing' do
      resp = solr_resp_ids_from_query 'utopian and antiutopian fiction'
      expect(resp).to include('DUKE008670706')
    end

    it 'the query should succeed if the dash is present' do
      resp = solr_resp_ids_from_query 'utopian and anti-utopian fiction'
      expect(resp).to include('DUKE008670706')
    end
  end
end
