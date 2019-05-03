require 'spec_helper'

describe 'apostrophes' do
  context "brazil's land revolution" do
    it 'the results should be the same whether or not '\
       'the apostrophe is present in the query' do
      resp = solr_resp_ids_from_query "brazil's land revolution"
      expect(resp).to(
        have_the_same_number_of_results_as(
          solr_resp_ids_from_query('brazils land revolution')
        )
      )
    end
  end

  context "love's labour's lost" do
    it 'the results should be the same whether or not '\
       'the apostrophe and "s" are present in the query' do
      resp = solr_resp_ids_from_query "love's labour's lost"
      expect(resp).to(
        have_the_same_number_of_results_as(
          solr_resp_ids_from_query('love labour lost')
        )
      )
    end
  end
end
