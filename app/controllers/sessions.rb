require 'sinatra'

configure do
  enable :sessions
end

helpers do

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

end

get '/sessions/:id' do
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session.clear
  200
end

