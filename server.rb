require 'sinatra'
# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

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

get '/contact' do
	@title = "Contact"

erb :contact
end

post '/contact' do
	# get from address from our form
	# get subject from our form
	# get content from our form
from = Email.new(email: params[:email])
to = Email.new(email: 'hanssebastian.p@gmail.com')
subject = params[:title]
content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers
redirect '/contact'
end