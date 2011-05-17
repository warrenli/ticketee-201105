Given /^there is a project called "([^\"]*)"$/ do |name|
  @project = Factory(:project, :name => name)
end

Given /^I have run the seed task$/ do
  load Rails.root + "db/seeds.rb"
end
