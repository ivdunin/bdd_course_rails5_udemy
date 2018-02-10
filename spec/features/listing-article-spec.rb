require 'rails_helper'

RSpec.feature "Listing articles" do
  before do
    @article1 = Article.create(title: "The first", body: "First text")
    @article2 = Article.create(title: "The second", body: "Second text")
    @article3 = Article.create(title: "My third", body: "A" * 3000)
  end

  scenario "A user lists all articles" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_link(@article1.title)

    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.title)
    expect(page).to have_link(@article2.title)
  end

  scenario "Article body should be truncated to 500 symbols" do
    visit "/"

    expect(page).to have_content(@article3.title)
    expect(page).to have_content(@article3.body.truncate(500))
    expect(page).not_to have_content(@article3.body.truncate(501))
  end

  scenario "A user has no articles" do
    Article.delete_all
    visit "/"
    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_link(@article1.title)

    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article2.title)

    within ("h1#no-articles") do
      expect(page).to have_content("No Articles Created")
    end
  end
end