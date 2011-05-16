# encoding: utf-8

假設 /^"([^\"]*)"可以閱讀"([^\"]*)"專案$/ do |user, project|
  create_permission(user, find_project(project), "view")
end

假設 /^"([^\"]*)"可以在"([^\"]*)"專案建立工作單$/ do |user, project|
  create_permission(user, find_project(project), "create tickets")
end

假設 /^"([^\"]*)"可以在"([^\"]*)"專案修改工作單$/ do |user, project|
  create_permission(user, find_project(project), "edit tickets")
end

假設 /^"([^\"]*)"可以在"([^\"]*)"專案刪除工作單$/ do |user, project|
  create_permission(user, find_project(project), "delete tickets")
end


def create_permission(email, permissible_object, action)
  Permission.create!(:user => User.find_by_email!(email),
                     :permissible => permissible_object,
                     :action => action)
end

def find_project(name)
  Project.find_by_name!(name)
end
