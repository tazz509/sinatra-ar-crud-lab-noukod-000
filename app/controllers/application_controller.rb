require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    Post.create(name:@params[:name],content:@params[:content])
    @posts=Post.all
    erb :index
  end

  get '/posts' do
    @posts=Post.all
    erb :index
  end

  get '/posts/:id/edit' do
    @post_id=@params[:id]
    @post=Post.find_by({id:@params[:id]})
    erb :edit
  end

  get '/posts/:id' do
    @post=Post.find_by({id:@params[:id]})
    erb :show
  end

  patch '/posts/:id' do
    @id=@params[:id]
    @post=Post.find_by({id:@id})
    @post.name=@params[:name]
    @post.content=@params[:content]
    @post.save
    redirect('/posts/'+@id)
  end

  delete '/posts/:id' do
    @id=@params[:id]
    @post=Post.find_by({id:@id})
    @post.destroy
  end



end
