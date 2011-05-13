# encoding: utf-8

假設 /^有以下帳戶:$/ do |table|
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
