# encoding: utf-8

假設 /^有一個名稱為"([^"]*)"的專案$/ do |name|
  @project = Factory(:project, :name => name)
end

假設 /^我去設定基本資料$/ do
  load Rails.root + "db/seeds.rb"
end
