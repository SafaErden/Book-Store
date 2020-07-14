require "application_system_test_case"

class AuthsTest < ApplicationSystemTestCase
  setup do
    @auth = auths(:one)
  end

  test "visiting the index" do
    visit auths_url
    assert_selector "h1", text: "Auths"
  end

  test "creating a Auth" do
    visit auths_url
    click_on "New Auth"

    click_on "Create Auth"

    assert_text "Auth was successfully created"
    click_on "Back"
  end

  test "updating a Auth" do
    visit auths_url
    click_on "Edit", match: :first

    click_on "Update Auth"

    assert_text "Auth was successfully updated"
    click_on "Back"
  end

  test "destroying a Auth" do
    visit auths_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Auth was successfully destroyed"
  end
end
