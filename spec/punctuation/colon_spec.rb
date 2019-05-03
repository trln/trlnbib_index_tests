require 'spec_helper'

describe 'colon' do
  context 'ae : canadian journal of aesthetics' do
    it 'the query should succeed if the colon is '\
       'present and escaped in the query' do
      resp = solr_resp_ids_from_query 'ae \: canadian journal of aesthetics'
      expect(resp).to include('DUKE004350496')
    end

    it 'the query should succeed if the colon is missing from the query' do
      resp = solr_resp_ids_from_query 'ae canadian journal of aesthetics'
      expect(resp).to include('DUKE004350496')
    end

    it 'the query should succeed if the colon is delimited by a single space' do
      resp = solr_resp_ids_from_query 'ae: canadian journal of aesthetics'
      expect(resp).to include('DUKE004350496')
    end
  end

  context "ICALEO '90 : optical methods in flow"\
          'and particle diagnostics : proceedings' do
    it 'the query should suceed when multiple colons are present and escaped' do
      resp = solr_resp_ids_from_query(
        'ICALEO \'90 \: optical methods in flow '\
        'and particle diagnostics \: proceedings'
      )
      expect(resp).to include('NCSU785984')
    end
  end
end
