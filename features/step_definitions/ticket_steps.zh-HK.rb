# encoding: utf-8

假設 /^"([^\"]*)"給這個專案建立以下工作單:$/ do |email, table|
  table.hashes.each do |attributes|
    @project.tickets.create!(attributes.merge!(:user => User.find_by_email!(email)))
  end
end
