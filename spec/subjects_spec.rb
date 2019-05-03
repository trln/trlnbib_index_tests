require 'spec_helper'

describe 'Subjects' do
  context 'social surveys' do
    let(:resp) do
      solr_resp(subject_search_duke('social surveys'))
    end

    let(:docs) do
      resp['response']['docs']
    end

    it 'the titles should match one or more query terms' do
      expect(resp).to(
        include('title_main' => /(social|survey)/i).in_each_of_first(5)
                                                   .documents
      )
    end

    it 'the results should be published with the last ten years' do
      pub_years = docs.map { |d| d.fetch('publication_year_sort', nil) }.compact
      current_year_minus_ten = Date.today.year - 10
      expect(
        pub_years.select { |y| y.to_i < current_year_minus_ten }
      ).to be_empty
    end

    it 'the results should be mostly English' do
      count = docs.count
      langs = docs.flat_map { |d| d.fetch('language_a', nil) }.compact
      english_results_count = langs.select { |l| l == 'English' }.count
      expect((english_results_count.to_f / count)).to be > 0.75
    end
  end
end
