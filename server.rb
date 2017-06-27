require 'sinatra'
# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

# Universal
before do
	@products = {
		product_name:{name: "productName", image: "/images/QA-Danny-DeVito-008.jpg", description: "product description goes here", categories: ["category1"]},
		product_name2:{name: "productName2", image: "/images/QA-Danny-DeVito-008.jpg", description: "product description 2 goes here", categories: ["category2","category1"]},
		product_name3:{name: "productName3", image: "/images/QA-Danny-DeVito-008.jpg", description: "product description 2 goes here", categories: ["category3"]},
		product_name4:{name: "productName4", image: "/images/QA-Danny-DeVito-008.jpg", description: "product description 2 goes here", categories: ["category4","category3"]},
		product_name5:{name: "productName5", image: "/images/QA-Danny-DeVito-008.jpg", description: "product description 2 goes here", categories: ["category1"]},
		product_name6:{name: "productName6", image: "/images/QA-Danny-DeVito-008.jpg", description: "product description 2 goes here", categories: ["category2"]},
		product_name7:{name: "productName7", image: "/images/QA-Danny-DeVito-008.jpg", description: "product description 2 goes here", categories: ["category3"]},
		product_name8:{name: "productName8", image: "/images/QA-Danny-DeVito-008.jpg", description: "product description 2 goes here", categories: ["category4"]},
		product_name9:{name: "productName9", image: "/images/QA-Danny-DeVito-008.jpg", description: "product description 2 goes here", categories: ["category1"]},
		product_name10:{name: "productName10", image: "/images/QA-Danny-DeVito-008.jpg", description: "product description 2 goes here", categories: ["category2"]},
	}
	@categories = @products.reduce([]) do |arr,(key,hash)|
		arr | hash[:categories]
	end
	@n = 0
	@nav = [{link: "/", text: "Home"},{link: "/about", text: "About Us"},{link: "/category", text: "Browse By Category"},{link: "/p/" + @products.keys.sample.to_s, text: "Find A Random Product"}]
end

# Hans
get '/' do
@title = "SiteName"

erb :home
end

# Steven
get '/category' do
	@title = "Categories"

erb :categories
end

get '/c/:category' do
	@category = @categories[@n].to_sym
	@title = params[:category]

	erb :category
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

get '/p/:product' do
@product = @products[params[:product].to_sym]
@title = @product[:name]
erb :product

end
