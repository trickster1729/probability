class PerformanceController < ApplicationController
def new
		$performance1=Performance.new
		$performance2=Performance.new
		
	end
	def index
	end
	def create
		@player1count=0
		@player2count=0
		rating1 = params[:performance][:rating1]
		rating2 = params[:performance][:rating1]
		volatility1 = params[:performance][:volatility1]
		volatility2 = params[:performance][:volatility2]
		
		$performance1.rating=rating1
		$performance1.volatility=volatility1
		validate_performance1=$performance1.save
		#$player2=Player.new
		$performance2.rating=rating2
		$performance2.volatility=volatility2
		validate_performance2=$performance2.save
		if validate_performance1==false || validate_performance2==false
		render 'new'
		end
		
		
		rating1 = rating1.to_i
		rating2 = rating1.to_i
		volatility1 = volatility1.to_i
		volatility2 = volatility2.to_i
		
		
		#x = (rating1-rating2)/Math.sqrt(2*(volatility1*volatility1 + volatility2*volatility2))
		#y = 0.5 * Math.erf(x) + 1
		#return y
		10000.times do
			x = gaussian(rating1, volatility1)
			y = gaussian(rating2, volatility2)
			if x > y
				@player1count=@player1count+1
			else
				@player2count=@player2count+1
			end
			end
		@player1count=@player1count/100
		@player2count=@player2count/100

	end
		
	def gaussian(mean, stddev)
		rng = lambda { Kernel.rand }
		theta = 2 * Math::PI * rng.call
		rho = Math.sqrt(-2 * Math.log(1 - rng.call))
		scale = rho * stddev
		x = mean + scale * Math.cos(theta)
		y = mean + scale * Math.sin(theta)
		#y = mean + scale * Math.sin(theta)
		return (x + y) / 2
		#return x
	
	end
end
