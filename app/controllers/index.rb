# ------------------INDEX------------------------
get '/' do
  @users = User.all
  session[:current_results]=[]
  p session
  p current_user
  p 'hello world'
  erb :index
end

# ------------------SESSIONS------------------------

post '/sessions/error' do
  if params[:signin]=="Sign In"
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect '/'
    else
      @error = "Invalid email or password"
      erb :index
    end
  elsif params[:signin]=="Sign Up"
    generate_new_user
    if @user.save
      session[:user_id]=@user.id
      redirect '/'
    else
      @error = "Email is already taken"
      erb :index
    end
  end
end

delete '/sessions/:id' do
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session.clear
  200
end

# ------------------USERS------------------------

get '/users/:user_id' do
  @user = User.find(params[:user_id])
  erb :'users/show'
end
