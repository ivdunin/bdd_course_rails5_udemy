require 'rails_helper'

RSpec.feature "Listing articles" do
  before do
    @article1 = Article.create(title: "The first", body: "First text")
    @article2 = Article.create(title: "The second", body: "Second text")
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
end