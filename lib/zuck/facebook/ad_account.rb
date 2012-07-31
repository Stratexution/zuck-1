require_relative 'fb_object'

module Zuck
  class AdAccount < FbObject

    # These are taken from https://developers.facebook.com/docs/reference/ads-api/adaccount/
    # the API actually returns more
    known_keys :account_id,
               :name,
               :account_status,
               :daily_spend_limit,
               :users,
               :currency,
               :timezone_id,
               :timezone_name,
               :capabilities,
               :account_groups,
               :is_personal,
               :business_name,
               :business_street,
               :business_street2,
               :business_city,
               :business_state,
               :business_zip,
               :business_country_code,
               :vat_status,
               :agency_client_declaration

    def self.all(graph = Zuck.graph)
      r = get(graph, 'me/adaccounts')
      r.map do |a|
        new(graph, a)
      end
    end

    def initialize(graph, data)
      self.graph = graph
      set_hash_delegator_data(data)
    end

    def campaigns
      Campaign.all(graph, self)
    end
  end
end