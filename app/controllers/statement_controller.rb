class StatementController < ApplicationController
	before_action :authenticate_user!		
	# def generate_pdf
	# 	# statement = render_to_string pdf: "statement", template: "statment.html.erb", encoding: "UTF-8"
	# 	# pdf = WickedPdf.new.pdf_from_string(statement)
	# 	# send_data pdf, filename: 'statement.pdf'
	# end	
	def get_statement
		@recipient=current_user
		@account=Account.find(params[:account_id])
		@start_date=Date.parse(params[:start_date])
		@end_date=Date.parse(params[:end_date])
		# binding.pry
		@statement_transaktions=Transaktion.where(created_at: @start_date..@end_date, account_id: @account.id)
		StatementMailer.send_statement(@recipient.email, @statement_transaktions).deliver
	end	
end
