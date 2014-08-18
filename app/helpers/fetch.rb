require "net/http"
require "uri"

helpers do

  def generate_new_user
    generate_user_name = params[:user][:email].scan(/(.*)@/)
    # generate_user_name = generate_user_name[0][0]
    @user = User.new(params[:user])
    # @user.update(name: generate_user_name)
    return @user
  end

  def get_user_name
    @user ||= User.find(session[:user_id]) if session[:user_id]
    return @user.email
  end

end
