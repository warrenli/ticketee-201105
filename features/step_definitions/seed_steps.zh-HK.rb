# encoding: utf-8

假設 /^有一個名稱為"([^"]*)"的專案$/ do |name|
  @project = Factory(:project, :name => name)
end
