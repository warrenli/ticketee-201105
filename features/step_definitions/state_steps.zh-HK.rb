# encoding: utf-8

假設 /^有一個狀態是"([^"]*)"$/ do |name|
  State.create!(:name => name)
end

當 /^我點擊"([^"]*)"旁邊的鏈接"([^"]*)"$/ do |name, link|
  state = State.find_by_name!(name)
  steps(%Q{When I follow "#{link}" within "#state_#{state.id}"})
end
