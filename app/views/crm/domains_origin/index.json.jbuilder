json.array!(@crm_domains) do |crm_domain|
  json.extract! crm_domain, :id
  json.url crm_domain_url(crm_domain, format: :json)
end
