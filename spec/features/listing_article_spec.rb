require "rails_helper"

RSpec.feature "Listing Articles" do
    
    before do
        @article1 = Article.create(title: "the first article", body: "Cos tam zawsze jest")
        @article2 = Article.create(title: "the second article", body: "body of the second article")
    end

    scenario "A user lists all articles" do 
        visit "/"

        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page).to have_content(@article2.title)
        expect(page).to have_content(@article2.body)
        expect(page).to have_link(@article1.title)
        expect(page).to have_link(@article2.title)
    end

end