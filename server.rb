require 'sinatra'
# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

# Universal
before do
	@products = {
		knife:{name: "Knife", image: "/images/knife.jpg", description: "Multi-purpose knife, for cutting all types of bullshit out of your life", hook: "Cut out the hassle, get something awesome", categories: ["Tools"]},
		whiskey_stones:{name: "Whiskey stones", image: "/images/whiskey-stones.jpg", description: "Keeps your whiskey pure and cold", hook: "Chill, bro. Seriously, you're harshing my vibe.", categories: ["Drinks","Tools"]},
		drone:{name: "Drone", image: "/images/drone.jpg", description: "What are your neighbors up to? Take peeking tom to the next level", hook: "Hey mami' check me out", categories: ["Toys"]},
		hot_sauce:{name: "Hot Sauce", image: "/images/hotsauce.jpg", description: "Bring some spice into your life", hook: "Hey mami' check me out", categories: ["Food"]},
		wine_opener:{name: "Wine Opener", image: "/images/wine.jpeg", description: "Portable wine opener to get her drunk anywhere", hook: "Hey mami' check me out", categories: ["Drinks"]},
		wine_picnic:{name: "Wine Picnic", image: "/images/cocktailPicnic.jpg", description: "Listen, we all like booze. Oh hey, you like parks too? If only there were some way to mere the two! Introducing the wine picnic. An all in one solution to being dumb. Now you can be awesome thanks to the wine picnic. Or make other drinks, this is your goddamn party. We promise, Hans won't blow up your spot.", hook: "Looking for a way to drink on the go? We've got you covered!", categories: ["Drinks"]},
		wineskin:{name: "Wine Skin", image: "/images/wineskin.jpg", description: "Ernest Hemmingway wasn't wrong. Our certified Spanish wine skin will bring you back to a time when men were men and those men stabbed bulls with knives. Could you carry your wine arouund in a bottle like some kind of a loser? Yeah, sure. Could you carry it around in a box like the Tune Squad? Even better. Or should you carry it in a fucking wineskin and be a goddamned badass. That seems like the best option. Be bold. Be the TuneSquad. Buy a WineSkin.", hook: "Ernest Hemmingway used one of these. Are You better than Ernest Hemmingeway?", categories: ["Drinks","Food"]},
		foosballtable:{name: "Foosball Table", image: "/images/CS004-2.jpg", description: "I get it, you're wife said 'no'. But what did you're heart say? I knew it. You're heart said 'yes'. Because your heart knows what your heart needs and what your heart needs is a foosball table. Listen, we love you. Even if you refus to love yourself.", hook: "GOOOOOOOOOOAAAAAAAAALLLLLLLLLLL!!!!!!", categories: ["Toys"]},
		chair:{name: "My Chair", image: "/images/chair.jpg", description: "Sometimes you need a thing to put your butt on. Let me tell you something. This chair is the tits as far as it is to be a place to put your butt. It's, like, made for it. It's a total butt spot. Butts.", hook: "It's a place to put your butt. But it's our place to put your butt.", categories: ["Furniture"]},
		product_name10:{name: "productName10", image: "/images/QA-Danny-DeVito-008.jpg", description: "product description 2 goes here", hook: "Hey mami' check me out", categories: ["category2"]},
	}
	@categories = @products.reduce([]) do |arr,(key,hash)|
		arr | hash[:categories]
	end
	@n = 0
	@nav = [{link: "/", text: "Home"},{link: "/about", text: "About Us"},{link: "/category", text: "Browse By Category"},{link: "/p/" + @products.keys.sample.to_s, text: "Find A Random Product"}]
end

# Hans
get '/' do
@title = "Casual Gentlemen"

(@prod1,@prod2,@prod3,@prod4,@prod5,@prod6,@prod7, @prod8, @prod9, @prod10) = @products.keys.sample(10)
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

	redirect "/"

end

get '/p/:product' do
@product = @products[params[:product].to_sym]
@title = @product[:name]
erb :product

end
