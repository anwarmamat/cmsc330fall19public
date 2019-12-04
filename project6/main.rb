require "sinatra"
require "./controller"

#
# Constants
#

PORT_LOWER = 1024
PORT_RANGE = 48128
PORT_DEFAULT = 8080
CTRL = Controller.new

#
# Helpers
#

# using_grace : -> Boolean
# Returns whether server is running from grace
def using_grace?
	/^grace\d+\.umd\.edu$/ =~ `hostname`
end

# port_from_did : -> Integer
# Returns random (but valid) port number
def port_from_did
	(`whoami`.hash.abs) % PORT_RANGE + PORT_LOWER
end

# logged_in : -> Boolean
# Returns if user is logged in with correct session identifier
def logged_in?
	session[:user] and CTRL.authorize(session[:user], session[:session])
end

# get_layout : -> Symbol
# Returns correct page layout depending on login status, basically
# just changes the navigation links
def get_layout
	logged_in? and :page_user or :page_visitor
end

#
# Configuration
#

enable :sessions

set :public_folder, File.dirname(__FILE__) + "/static"

configure do
	port = (using_grace? and port_from_did) or PORT_DEFAULT
	set :port, port
end

not_found do
	status 404
	erb :not_found, :layout => get_layout
end

#
# Routes
#

get "/" do
	if logged_in? then
		erb :timeline,
			:layout => get_layout,
			:locals => {
				:posts => CTRL.all_posts,
				:token => CTRL.assign_token(session[:user])
			}
	else
		erb :index, :layout => get_layout
	end
end

post "/" do
	CTRL.publish_post(
		session[:user],
		session[:session],
		params["content"],
		params["token"].to_i)

	redirect "/"
end

get "/login" do
	if logged_in? then
		redirect "/"
	else
		erb :login, :layout => get_layout
	end
end

post "/login" do
	sess = CTRL.authenticate(params["user"], params["password"])

	if sess then
		session[:user] = params["user"]
		session[:session] = sess
		redirect "/"
	else
		redirect "/login"
	end
end

get "/register" do
	if logged_in? then
		redirect "/"
	else
		erb :register, :layout => get_layout
	end
end

post "/register" do
	succ = CTRL.register(
		params["user"],
		params["avatar"]["filename"],
		params["avatar"]["tempfile"],
		params["password"],
		params["confirm"])

	if succ then
		redirect "/login"
	else
		redirect "/register?failed=true"
	end
end

get "/logout" do
	CTRL.revoke(session[:user], session[:session])
	session.delete :user
	session.delete :session

	redirect "/"
end

get "/search" do
	locals = { :query => nil, :users => [] }
	locals = CTRL.search(params[:q]) if params[:q]

	erb :search,
		:layout => get_layout,
		:locals => locals
end

get "/prefs" do
	if logged_in? then
		erb :prefs,
			:layout => get_layout,
			:locals => {
				:token => CTRL.assign_token(session[:user]),
				:user => CTRL.get_user(session[:user])
			}
	else
		redirect "/login"
	end
end

post "/prefs" do
	CTRL.update_prefs(
		session[:user],
		session[:session],
		params["description"],
		params["token"].to_i)

	redirect "/prefs"
end

get "/testimonials" do
	erb :testimonials, :layout => get_layout
end

get "/user" do
	erb :user,
		:layout => get_layout,
		:locals => {
			:user => CTRL.get_user(params[:q]),
			:posts => CTRL.get_posts(params[:q])
		}
end
