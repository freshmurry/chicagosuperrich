class PagesController < ApplicationController
  def home
  	@homes = Home.limit(300)
  end

  def search
  	
  	if params[:search].present? && params[:search].strip != ""
  		session[:loc_search] = params[:search]
  	end

  	@arrResult = Array.new

  	if session[:loc_search] && session[:loc_search] != ""
  		@homes_address = Home.where(active: true).near(session[:loc_search], 5000000, order: 'distance')
  	else
  		@homes_address = Home.where(active: true).all
  	end

  	@search = @homes_address.ransack(params[:q])
  	@homes = @search.result

  	@arrhomes = @homes.to_a

  	if (params[:start_date] && params[:end_date] && !params[:start_date].empty? & !params[:end_date].empty?)

  		start_date = Date.parse(params[:start_date])
  		end_date = Date.parse(params[:end_date])

  		@homes.each do |home|

  			not_available = home.reservations.where(
  					"(? <= start_date AND start_date <= ?)
  					OR (? <= end_date AND end_date <= ?) 
  					OR (start_date < ? AND ? < end_date)",
  					start_date, end_date,
  					start_date, end_date,
  					start_date, end_date
  				).limit(1)

  			if not_available.length > 0
  				@arrHomes.delete(home)	
  			end	

  		end

  	end

  end
end