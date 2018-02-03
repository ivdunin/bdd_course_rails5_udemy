require 'rails_helper'

RSpec.feature "Creating Article" do
  scenario "A user creates a new article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: "Creating a blog"
    fill_in "Body", with: "Lorem Ipsum"

    click_button "Create Article"

    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)
  end

  scenario "A user fails to create new article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: ""
    fill_in "Body", with: ""

    click_button "Create Article"

    expect(page).to have_content("Arcticle has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end

  scenario "A user fails to create new article with long title or body" do
    TITLE_LENGTH = 255
    BODY_LENGTH = 4096
    visit "/"

    click_link "New Article"

    fill_in "Title", with: "A" * (TITLE_LENGTH.to_i + 1)
    fill_in "Body", with: "A" * (BODY_LENGTH.to_i + 1)

    click_button "Create Article"

    expect(page).to have_content("Arcticle has not been created")
    expect(page).to have_content("Title is too long (maximum is #{TITLE_LENGTH} characters)")
    expect(page).to have_content("Body is too long (maximum is #{BODY_LENGTH} characters)")
  end
end