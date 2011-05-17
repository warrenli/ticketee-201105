# encoding: utf-8

假設 /^有一個狀態是"([^"]*)"$/ do |name|
  State.create!(:name => name)
end
