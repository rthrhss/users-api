json.data @users do |user|
  json.id user.id
  json.first_name user.first_name
  json.last_name user.last_name
  json.email user.email
  json.status user.status
  json.created_at user.created_at
end

json.meta do
  json.page @page
  json.per_page @per_page
  json.total_pages @total_pages
  json.total_count @total_count
end
