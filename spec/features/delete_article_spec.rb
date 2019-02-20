require 'rails_helper'

RSpec.feature "Deleting an article" do 
    before do
        @article = Article.create(title: "the first article", body: "Cos tam zawsze jest")
    end

    scenario "A user deletes an article" do 
        visit "/"

        click_link @article.title
        click_link "Delete Article"

        expect(page).to have_content("Article has been deleted")
        expect(current_path).to eq(articles_path)
    end
end 