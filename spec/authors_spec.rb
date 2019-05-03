require 'spec_helper'

describe 'Authors' do
  context '"Murakami, Haruki, 1949-"' do
    let(:resp) do
      solr_resp(author_search_duke('"Murakami, Haruki, 1949-"'))
    end

    let(:docs) do
      resp['response']['docs']
    end

    it 'the results should be published with the last fifteen years' do
      pub_years = docs.map { |d| d.fetch('publication_year_sort', nil) }.compact
      current_year_minus_fifteen = Date.today.year - 15
      expect(
        pub_years.select { |y| y.to_i < current_year_minus_fifteen }
      ).to be_empty
    end

    it 'the results should be mostly English' do
      count = docs.count
      langs = docs.flat_map { |d| d.fetch('language_a', nil) }.compact
      english_results_count = langs.select { |l| l == 'English' }.count
      expect((english_results_count.to_f / count)).to be > 0.75
    end
  end

  context '"Rowling, J. K."' do
    let(:resp) do
      solr_resp(author_search_duke('"Rowling, J. K."'))
    end

    let(:docs) do
      resp['response']['docs']
    end

    it 'the results should be published with the last fifteen years' do
      pub_years = docs.map { |d| d.fetch('publication_year_sort', nil) }.compact
      current_year_minus_fifteen = Date.today.year - 15
      expect(
        pub_years.select { |y| y.to_i < current_year_minus_fifteen }
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
