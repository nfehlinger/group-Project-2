require 'sinatra'
# Universal
before do
	@n = 0
	@nav = [{link: "/", text: "Home"},{link: "/about", text: "About Us"},{link: "/category", text: "Browse By Category"},{link: "/", text: "Find A Random Product"}]
	@products = []
	@categories = []
end

# Hans
get '/' do
@title = "SiteName"

erb :home
end

# Nick
get '/product' do
	# @title = @products[i]

erb :product
end

# Steven
get '/category' do
	# @title = @categories[i]

erb :categories
end

get '/about' do
	@title = "About Us"

erb :about
end