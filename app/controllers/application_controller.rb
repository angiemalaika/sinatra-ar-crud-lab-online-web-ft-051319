
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/articles"
  end

  #index
  get '/articles' do 
    @articles = Article.all
      erb :index 
  end 

   #new
 get '/articles/new' do
  @article = Article.new
  erb :new
end

  #create
  post '/articles' do
    @article = Article.create(params)
    redirect to "/articles/#{ @article.id }"
  end

   # Read /show 
   get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :"show"
  end

  #edit 

   get '/articles/:id/edit' do 
    @article = Article.find(params[:id])
    erb :"edit"
  end 

  patch '/articles/:id' do
    @article = Article.find(params[:id])
    
    @article.update(params[:article])
    @article.save 
    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    article = Article.find(params[:id])
    article.destroy 
    redirect '/articles'
  end  
end

