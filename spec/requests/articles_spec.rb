require 'rails_helper'

RSpec.describe "Articles", type: :request do
    before do 
        @john = User.create(email: "john@example.com", password: "password")
        @fred = User.create(email: "fred@example.com", password: "password")
        @article = Article.create!(title: "Title One", body: "Body of article one", user: @john)
    end
    
    describe 'DELETE /articles/:id' do 

        context 'with signed in user as owner successfull delete'do
            before do
                login_as(@john)
                delete "/articles/#{@article.id}"
            end
            it "Article has been deleted" do 
                expect(response.status).to eq 302
            end
        end

        context 'with signed in user as non-owner' do 
            before do 
                login_as(@fred)
                delete "/articles/#{@article.id}"
            end
             it "does not delete article" do 
                expect(response.status).to eq 302
                flash_message = "You can only delete you own article"
                expect(flash[:alert]).to eq flash_message
             end
        end

    end

    describe 'GET /article/:id/edit' do
        
        context 'with non-signed in user' do
            before { get "/articles/#{@article.id}/edit"}

            it "redirects to the signin page" do 
                expect(response.status).to eq 302
                flash_message = "You need to sign in or sign up before continuing."
                expect(flash[:alert]).to eq flash_message
            end
        end

        context 'with signed in user who is non-owner'do
            before do
                login_as(@fred)
                get "/articles/#{@article.id}/edit"
            end

            it "redirects to the home page" do 
                expect(response.status).to eq 302
                flash_message = "You can only edit you own article."
                expect(flash[:alert]).to eq flash_message
            end
        end

        context 'with signed in user as owner successful edit' do 
            before do 
                login_as(@john)
                get "/articles/#{@article.id}/edit"
            end

            it "successfully edits article" do
                expect(response.status).to eq 200
            end
        end
    end

    describe 'GET /articles/:id' do
        context 'with existing article' do
            before { get "/articles/#{@article.id}"}

            it "handle existing article" do 
                expect(response.status).to eq 200
            end
        end

        

        context 'with non-existing article' do 
            before { get "/articles/xxx"}

            it "handles non-exsting article" do 
                expect(response.status).to eq 302
                flash_message  = "the article you are looking for could not be found"
                expect(flash[:alert]).to eq flash_message
            end
        end
    end
end