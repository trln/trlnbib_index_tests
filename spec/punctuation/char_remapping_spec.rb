require 'spec_helper'

describe 'ampersands' do
  context '"Human & Rousseau"' do
    it 'the results should be the same whether or not '\
       'the ampersand is spelled out' do
      resp = solr_resp_ids_from_query '"Human & Rousseau"'
      expect(resp).to(
        have_the_same_number_of_results_as(
          solr_resp_ids_from_query('"Human and Rousseau"')
        )
      )
    end
  end
end
