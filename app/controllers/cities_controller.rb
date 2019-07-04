class CitiesController < ApplicationController
  require 'open-uri'
	def index
		@city = City.all
	end

  def new
  	@city = City.new
  end

	def create
		doc=Nokogiri::HTML(open(url_param["url"]))
		doc.css('table tr').each_with_index do |obj, i|
			if i!=0
				name = obj.css('td')[0].text
				latitude = obj.css('td')[1].text
				longitude = obj.css('td')[2].text
				puts "name: #{name}"
				puts "latitude: #{latitude}"
				puts "longitude: #{longitude}"
				@city = City.new()
				@city.name = name
				@city.latitude = latitude
				@city.longitude = longitude

				@city.save
			end
		end
	end

	private

	def url_param
		params.require(:city).permit(:url)
	end
end
