require 'sinatra'
# Universal
before do
	@products = {
		product_name:{name: "productName", image: "images/QA-Danny-DeVito-008.jpg", description: "product description goes here", categories: ["category1", "category2"]},
		product_name2:{name: "productName2", image: "images/QA-Danny-DeVito-008.jpg", description: "product description 2 goes here", categories: ["category1", "category2"]}		
	}

	@n = 0
	@nav = [{link: "/", text: "Home"},{link: "/about", text: "About Us"},{link: "/category", text: "Browse By Category"},{link: "/" + @products.keys.sample.to_s, text: "Find A Random Product"}]
end

# Hans
get '/' do
@title = "SiteName"

erb :home
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

# Nick
get '/:product' do
@product = @products[params[:product].to_sym]
@title = @product[:name]
erb :product
end