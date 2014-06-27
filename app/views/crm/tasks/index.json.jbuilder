json.array!(@crm_tasks) do |crm_task|
  json.extract! crm_task, :id
  json.url crm_task_url(crm_task, format: :json)
end
