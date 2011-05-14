=begin
Given /^"([^"]*)" can view the "([^"]*)" project$/ do |user, project|
  create_permission(user, find_project(project), "view")
end

Given /^"([^"]*)" can create tickets in the "([^"]*)" project$/ do |user, project|
  create_permission(user, find_project(project), "create tickets")
end
=end

permission_step = /^"([^"]*)" can ([^"]*?) ([o|i]n)?\s?the "([^"]*)" project$/

Given permission_step do |user, permission, on, project|
  create_permission(user, find_project(project), permission)
end


def create_permission(email, permissible_object, action)
  Permission.create!(:user => User.find_by_email!(email),
                     :permissible => permissible_object,
                     :action => action)
end

def find_project(name)
  Project.find_by_name!(name)
end
