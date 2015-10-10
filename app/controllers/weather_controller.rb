class WeatherController < ApplicationController
  def form
  end

  def display
  	if params[:city] != nil
    params[:city].gsub! " ", "_"
end


	  
response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_key']}/geolookup/conditions/q/#{params['state']}/#{params['city']}.xml")

if response['response']['error'] != nil
    flash[:notice] =  "This city doesn't exist.  Check your spelling and try again!"
    redirect_to action: :form
else
  	@res = {
        city: response['response']['location']['city'],
        state: response['response']['location']['state'],
        country: response['response']['location']['country'],
        updated: response['response']['current_observation']['observation_time'],
        weather: response['response']['current_observation']['weather'],
        weather_icon: response['response']['current_observation']['icon_url'],
        temp: response['response']['current_observation']['temp_f'],
        wind: response['response']['current_observation']['wind_string'],
        more_link: response['response']['current_observation']['forecast_url']
    }
  end
end
end