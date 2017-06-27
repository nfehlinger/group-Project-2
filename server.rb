require 'sinatra'
require 'sendgrid-ruby'
include SendGrid
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

# Nick
get '/about' do
	@title = "About Us"

erb :about
end

post '/about' do
#get from address from form
	from = Email.new(email: params[:email])
	to = Email.new(email: 'nfehlinger@gmail.com')
#get subject from our form
	subject = params[:subject]
#get content from form
	content = Content.new(type: 'text/plain', value: <<-EMAILBODY
NAME: #{params[:name]}

COMMENT: #{params[:comment]}
EMAILBODY
)
	mail = Mail.new(from, subject, to, content)

	sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
	response = sg.client.mail._('send').post(request_body: mail.to_json)
	puts response.status_code
	puts response.body
	puts response.headers

	redirect_to("/about")
end


get '/:product' do
@product = @products[params[:product].to_sym]
@title = @product[:name]
erb :product
end