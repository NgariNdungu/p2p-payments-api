class TransaktionsController < ApplicationController
	before_action :set_agency, only: [:deposit]

	def send_money
		#send money method				
	end
	def withdraw
		
	end
	def deposit		
		if @transaktion=@agency.deposit(recipient: set_params[:phone], amount: set_params[:amount])
			render json: @transaktion, status: 200
		else
			render json: @transaktion.errors, status: 400
		end
	end

	private
		#testing
		def set_agency
			@agency=Agency.find_by(id: set_params[:agent])			
		end
		def set_params
			params.require(:data).permit(:phone, :agent, :amount, :email)
		end
end
