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
    if attributes[:admin] == "true"
      @user.admin = true
      @user.save!
    end
  end
end

Given /^"([^\"]*)" has confirmed their account$/ do |email|
  User.find_by_email(email).confirm!
end

Given /^I am signed in as "([^\"]*)"$/ do |email|
  @user = User.find_by_email!(email)
#  steps("Given I am signed in as them")
  steps %Q(
    Given I am on the homepage
    When I follow "Sign in"
    And I fill in "Email" with "#{@user.email}"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Signed in successfully"
  )
end

Given /^I am signed in as them$/ do
  steps %Q(
    Given I am on the homepage
    When I follow "Sign in"
    And I fill in "Email" with "#{@user.email}"
    And I fill in "Password" with "#{@user.password}"
    And I press "Sign in"
    Then I should see "Signed in successfully"
  )
end
