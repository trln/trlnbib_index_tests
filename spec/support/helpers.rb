require 'date'

module Helpers
  # send a GET request to the default Solr request handler with the indicated query
  # @param query [String] the value of the 'q' param to be sent to Solr
  # @return [RSpecSolr::SolrResponseHash] object for rspec-solr testing the Solr response, with no facets, and only the id field for each Solr doc
  def solr_resp_ids_from_query(query)
    solr_resp_doc_ids_only({'q'=> query})
  end

  # send a GET request to the default Solr request handler with the indicated query
  # @param query [String] the value of the 'q' param to be sent to Solr
  # @return [RSpecSolr::SolrResponseHash] object for rspec-solr testing the Solr response, with no facets, and only the id and title_245a_display field for each Solr doc
  def solr_resp_ids_titles_from_query(query)
    solr_resp_ids_titles({'q'=> query})
  end

  def solr_resp(solr_params)
    solr_response(solr_params)
  end

  # send a GET request to the default Solr request handler with the indicated Solr parameters
  # @param solr_params [Hash] the key/value pairs to be sent to Solr as HTTP parameters, in addition to
  #  those to get only id fields and no facets in the response
  # @return [RSpecSolr::SolrResponseHash] object for rspec-solr testing the Solr response, with no facets, and only the id field for each Solr doc
  def solr_resp_doc_ids_only(solr_params)
    solr_response(solr_params.merge(doc_ids_only))
  end

  # send a GET request to the default Solr request handler with the indicated Solr parameters
  # @param solr_params [Hash] the key/value pairs to be sent to Solr as HTTP parameters, in addition to
  #  those to get only id fields and title_245a_display and no facets in the response
  # @return [RSpecSolr::SolrResponseHash] object for rspec-solr testing the Solr response, with no facets, and only the id and short title field for each Solr doc
  def solr_resp_ids_titles(solr_params)
    solr_response(solr_params.merge(doc_ids_titles))
  end

  def local_scope_duke
    { 'fq' => 'institution_f:duke' }
  end

  def local_scope_nccu
    { 'fq' => 'institution_f:nccu' }
  end

  def local_scope_ncsu
    { 'fq' => 'institution_f:ncsu' }
  end

  def local_scope_unc
    { 'fq' => 'institution_f:unc' }
  end

  def all_fields_search_duke(query_str)
    local_scope_duke.merge({ 'q' => query_str })
  end

  def all_fields_search_nccu(query_str)
    local_scope_nccu.merge({ 'q' => query_str })
  end

  def all_fields_search_ncsu(query_str)
    local_scope_ncsu.merge({ 'q' => query_str })
  end

  def all_fields_search_unc(query_str)
    local_scope_unc.merge({ 'q' => query_str })
  end

  def subject_search_duke(query_str)
    local_scope_duke.merge(subject_search_args(query_str))
  end

  def subject_search_nccu(query_str)
    local_scope_nccu.merge(subject_search_args(query_str))
  end

  def subject_search_ncsu(query_str)
    local_scope_ncsu.merge(subject_search_args(query_str))
  end

  def subject_search_unc(query_str)
    local_scope_unc.merge(subject_search_args(query_str))
  end

  def subject_search_args(query_str)
    { 'q' => query_str, 'qf' => '${subject_qf}', 'pf' => '${subject_pf}', 'bq' => subject_bq(query_str), 'bf' => subject_bf }
  end

  def subject_bq(query_str)
    "title_main_indexed_t:(#{query_str})^500, language_f:English^10000"
  end

  def subject_bf
    current_year = Date.today.year
    current_year_plus_two = current_year + 2
    current_year_minus_ten = current_year - 10
    "linear(map(publication_year_isort,#{current_year_plus_two},10000,#{current_year_minus_ten},abs(publication_year_isort)),11,0)^100"
  end


  private

  # send a GET request to the indicated Solr request handler with the indicated Solr parameters
  # @param solr_params [Hash] the key/value pairs to be sent to Solr as HTTP parameters
  # @param req_handler [String] the pathname of the desired Solr request handler (defaults to 'select')
  # @return [RSpecSolr::SolrResponseHash] object for rspec-solr testing the Solr response
  def solr_response(solr_params, req_handler='select')
    q_val = solr_params['q']
    RSpecSolr::SolrResponseHash.new(solr_conn.send_and_receive(req_handler, {:method => :get, :params => solr_params.merge("testing"=>"trlnbib_index_testing")}))
  end

  # use these Solr HTTP params to reduce the size of the Solr responses
  # response documents will only have id fields, and there will be no facets in the response
  # @return [Hash] Solr HTTP params to reduce the size of the Solr responses
  def doc_ids_only
    {'fl'=>'id', 'facet'=>'false'}
  end

  # response documents will only have id and title_245a_display fields, and there will be no facets in the response
  # @return [Hash] Solr HTTP params to reduce the size of the Solr responses
  def doc_ids_titles
    {'fl'=>'id,title_main', 'facet'=>'false'}
  end

  def solr_conn
    RSpec.configuration.solr
  end

  def solr_schema
    @schema_xml ||= solr_conn.send_and_receive('admin/file/', {:method => :get, :params => {'file'=>'schema.xml', :wt=>'xml'}})
  end

  def solr_config_xml
    @solrconfig_xml = solr_conn.send_and_receive('admin/file/', {:method => :get, :params => {'file'=>'solrconfig.xml', :wt=>'xml'}})
  end
end
