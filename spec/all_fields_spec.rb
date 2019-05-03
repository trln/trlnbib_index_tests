require 'spec_helper'

describe 'All Fields' do
  context 'known author and title' do
    it 'the first two titles should match the query' do
      resp = solr_resp_ids_titles_from_query(
        'carre the spy who came in from the cold'
      )
      expect(resp).to(
        include(
          'title_main' => /^The spy who came in from the cold/i
        ).in_each_of_first(2).documents
      )
    end

    it '(Duke) the book and film adaptation should '\
       'be among the first four results' do
      resp = solr_resp_ids_titles(
        all_fields_search_duke('carre the spy who came in from the cold')
      )
      expect(resp).to include(%w[DUKE001357733 DUKE004063454]).in_first(4)
    end
  end
end
