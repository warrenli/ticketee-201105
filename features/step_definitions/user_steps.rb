Given /^there are the following users:$/ do |table|
  table.hashes.each do |attributes|
    unconfirmed_attr = attributes.delete("unconfirmed")||"false"
    unconfirmed = unconfirmed_attr.downcase == "true"
    @user = User.create!(
      attributes.merge!(
        :password_confirmation => attributes[:password]
      )
    )
    @user.confirm! unless unconfirmed
  end
end

Given /^"([^\"]*)" has confirmed their account$/ do |email|
  User.find_by_email(email).confirm!
end
