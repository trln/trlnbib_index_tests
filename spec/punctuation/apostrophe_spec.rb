# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Apostrophes" do

  it "brazil's land revolution" do
    resp = solr_resp_ids_from_query "brazil's land revolution"
    expect(resp).to have_the_same_number_of_results_as(solr_resp_ids_from_query "brazils land revolution")
  end

end
