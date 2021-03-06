require "rails_helper"

RSpec.feature "Showing an Article " do
    before do
        @john = User.create(email: "john@example.com", password: "password")
        @Ann = User.create(email: "Ann@example.com", password: "password")
        @article = Article.create(title: "the first article", body: "Cos tam zawsze jest", user: @john)
    end

    scenario "to non-signed in user hide the edit and delete buttons" do
        visit "/"

        click_link @article.title

        expect(page).to have_content(@article.title)
        expect(page).to have_content(@article.body)
        expect(current_path).to eq(article_path(@article))

        expect(page).not_to have_link("Edit Article")
        expect(page).not_to have_link("Delete Article")
    end

    scenario "to non-owner in user hide the edit and delete buttons" do
        login_as(@Ann)
        visit "/"

        click_link @article.title

        expect(page).to have_content(@article.title)
        expect(page).to have_content(@article.body)
        expect(current_path).to eq(article_path(@article))
        
        expect(page).not_to have_link("Edit Article")
        expect(page).not_to have_link("Delete Article")
    end

    scenario "A signed in owner see both the edit and delete buttons" do
        login_as(@john)
        visit "/"

        click_link @article.title

        expect(page).to have_content(@article.title)
        expect(page).to have_content(@article.body)
        expect(current_path).to eq(article_path(@article))
        
        expect(page).to have_link("Edit Article")
        expect(page).to have_link("Delete Article")
    end
end