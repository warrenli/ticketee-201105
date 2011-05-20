# encoding: utf-8

那麼 /^該郵件包含(\d+)個部分$/ do |num|
  current_email.parts.size.should eql(num.to_i)
end

那麼 /^應該有一部分content type是"([^"]*)"$/ do |content_type|
  current_email.parts.detect do |p|
    p.content_type.include? content_type
  end.should_not be_nil
end
