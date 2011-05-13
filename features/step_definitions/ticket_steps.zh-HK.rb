# encoding: utf-8

假設 /^這專案有一個工作單:$/ do |table|
  table.hashes.each do |attributes|
    @project.tickets.create!(attributes)
  end
end
