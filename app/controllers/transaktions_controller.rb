class TransaktionsController < ApplicationController
	def send_money
		#send money method				
	end
	def withdraw
		
	end
	def deposit
		
	end

	private
		def set_params
			params.require(:data).permit(:phone, :agent, :amount, :email)
		end
end
