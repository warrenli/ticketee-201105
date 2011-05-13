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
     if attributes[:admin] == "true"
       @user.admin = true
       @user.save!
     end
  end
end

假設  /^"([^\"]*)"已確認帳戶$/ do |email|
  User.find_by_email(email).confirm!
end

假設 /^我以"([^"]*)"登入系統$/ do |email|
  @user = User.find_by_email!(email)
  steps %Q(
    Given I am on the homepage
    When I follow "登入"
    And I fill in "電郵地址" with "#{@user.email}"
    And I fill in "帳戶密碼" with "password"
    And I press "登入"
    Then I should see "登錄成功。"
  )
end

假設 /^已成功登入系統$/ do
  steps %Q(
    Given I am on the homepage
    When I follow "登入"
    And I fill in "電郵地址" with "#{@user.email}"
    And I fill in "帳戶密碼" with "#{@user.password}"
    And I press "登入"
    Then I should see "登錄成功。"
  )
end
