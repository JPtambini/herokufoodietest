require 'sinatra'
require 'sinatra/activerecord'
require './models'

enable :sessions

set :database, "sqlite3:foodie_base.sqlite3"

time=Time.now
def add_user(params)
	User.create(fname:params[:first_name], lname:params[:last_name],uname:params[:username],password: params[:password],email:params[:email],location:params[:location], date_time:"#{time.year}-#{time.month}-#{time.day} [#{time.hour}:#{time.min}:#{time.sec}]")
end

def current_user
    if session[:id]
       User.find(session[:id])
    end
end

def add_post(params)
time=Time.now
	Post.create(name:params[:enter_name], subject:params[:topic_subject], body:params[:text_body], date_time:"#{time.year}-#{time.month}-#{time.day} [#{time.hour}:#{time.min}:#{time.sec}]" ,user_id:current_user.id)
end

def edit_account(params)
    User.find(current_user.id).update_attributes(fname:params[:first_name], lname:params[:last_name],uname:params[:username],password: params[:password],email:params[:email],location:"new")
end

def delete_account
	User.destroy(current_user.id)
end

def following(params)
    @id=params[:follower_id].to_i
    if @id != current_user.id 
        Follow.create(follower_id: @id, followee_id: current_user.id)
    else
    end
end


 get '/' do 
 	erb :signup
 end
 get '/edit' do
 	erb :edit
 end
 get '/mini_feed' do
 	erb :feed
 end
 get '/post' do
     @posts=Post.where(user_id: current_user.id)
 	erb :post
 end
 get '/profile' do
     @follow_id=params[:id]
 	erb :profile 
 end

get "/profile_others" do
     @follow_id=params[:id]
     erb :profile_others
end

post "/sign_up" do
 	add_user(params)
    redirect"/post"
end

post "/log_out" do
    session[:id]=nil
    redirect"/"
end

post "/log_in" do
     params[:username]
     @user=User.where(uname: params[:username]).first
     @post=Post.all
     puts @user.password
    if @user.password == params[:password]
        session[:id] = @user.id
        session[:username] = @user.uname
        current_user
        redirect "/mini_feed"
    else 
        redirect "/"
    end
end

post "/edit-page" do
    edit_account(params)
    redirect "/edit"
end
post "/del_page" do
    delete_account
    redirect "/"
end

post "/post_feed" do
	add_post(params)
    redirect "/post"
end

post "/follow" do
    following(params)
    redirect "/mini_feed"
end
