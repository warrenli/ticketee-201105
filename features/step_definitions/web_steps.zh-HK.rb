# encoding: utf-8

require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

# Single-line step scoper
# When /^(.*) within ([^:]+)$/ do |step, parent|
當 /^(.*) 包含在"([^\"]*)"$/ do |step, parent|
#  puts "step: [" + step + "]"
  parent = '"' + parent + '"'
#  puts "parent: [" + parent + "]"
  with_scope(parent) { 當 step }
end

# Multi-line step scoper
# When /^(.*) within ([^:]+):$/ do |step, parent, table_or_string|
#   with_scope(parent) { When "#{step}:", table_or_string }
# end

# Given /^(?:|I )am on (.+)$/ do |page_name|
假設 /^(?:|我)來到(.+)$/ do |page_name|
  visit path_to(page_name)
end

# When /^(?:|I )go to (.+)$/ do |page_name|
當 /^(?:|我)瀏覽(.+)$/ do |page_name|
  visit path_to(page_name)
end

# When /^(?:|I )press "([^"]*)"$/ do |button|
當 /^(?:|我)按下了"([^\"]*)"按钮$/ do |button|
  click_button(button)
end

# When /^(?:|I )follow "([^"]*)"$/ do |link|
當 /^(?:|我)點擊鏈接"([^\"]*)"$/ do |link|
  click_link(link)
end

# When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
當 /^(?:|我)在"([^\"]*)"欄位中輸入"([^\"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

# When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
當 /^(?:|我)在"([^\"]*)"欄位中填寫"([^\"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
# When /^(?:|I )fill in the following:$/ do |fields|
當 /^(?:|我)載入如下資料:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{我在"#{name}"欄位中輸入"#{value}"}
  end
end

# When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
#   select(value, :from => field)
# end

# When /^(?:|I )check "([^"]*)"$/ do |field|
當 /^(?:|我)在"([^\"]*)"框打勾$/ do |field|
  check(field)
end

# When /^(?:|I )uncheck "([^"]*)"$/ do |field|
#   uncheck(field)
# end

# When /^(?:|I )choose "([^"]*)"$/ do |field|
#   choose(field)
# end

# When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
#   attach_file(field, File.expand_path(path))
# end
當 /^加入附加文件檔"([^"]*)"到欄位"([^"]*)"$/ do |path, field|
   attach_file(field, File.expand_path(path))
end

# Then /^(?:|I )should see "([^"]*)"$/ do |text|
那麼 /^(?:|我)應該看到"([^\"]*)"(?:|的提示信息)$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

# Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
那麼 /^(?:|我)應該看到 \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

# Then /^(?:|I )should not see "([^"]*)"$/ do |text|
那麼 /^(?:|我)應該不會看到"([^\"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

# Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
那麼 /^(?:|我)應該不會看到 \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

# Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
#   with_scope(parent) do
#     field = find_field(field)
#     field_value = (field.tag_name == 'textarea') ? field.text : field.value
#     if field_value.respond_to? :should
#       field_value.should =~ /#{value}/
#     else
#       assert_match(/#{value}/, field_value)
#     end
#   end
# end

# Then /^the "([^"]*)" field(?: within (.*))? should not contain "([^"]*)"$/ do |field, parent, value|
#   with_scope(parent) do
#     field = find_field(field)
#     field_value = (field.tag_name == 'textarea') ? field.text : field.value
#     if field_value.respond_to? :should_not
#       field_value.should_not =~ /#{value}/
#     else
#       assert_no_match(/#{value}/, field_value)
#     end
#   end
# end

# Then /^the "([^"]*)" checkbox(?: within (.*))? should be checked$/ do |label, parent|
#   with_scope(parent) do
#     field_checked = find_field(label)['checked']
#     if field_checked.respond_to? :should
#       field_checked.should be_true
#     else
#       assert field_checked
#     end
#   end
# end

# Then /^the "([^"]*)" checkbox(?: within (.*))? should not be checked$/ do |label, parent|
#   with_scope(parent) do
#     field_checked = find_field(label)['checked']
#     if field_checked.respond_to? :should
#       field_checked.should be_false
#     else
#       assert !field_checked
#     end
#   end
# end
 
# Then /^(?:|I )should be on (.+)$/ do |page_name|
那麼 /^(?:|我)(?:應該|停留)在(.+)(?:|專頁)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

# Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
#   query = URI.parse(current_url).query
#   actual_params = query ? CGI.parse(query) : {}
#   expected_params = {}
#   expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')} 
#   
#   if actual_params.respond_to? :should
#     actual_params.should == expected_params
#   else
#     assert_equal expected_params, actual_params
#   end
# end

# Then /^show me the page$/ do
那麼 /^顯示完整網頁$/ do
  save_and_open_page
end
