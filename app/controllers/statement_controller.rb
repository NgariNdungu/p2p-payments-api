class StatementController < ApplicationController		
	# def generate_pdf
	# 	# statement = render_to_string pdf: "statement", template: "statment.html.erb", encoding: "UTF-8"
	# 	# pdf = WickedPdf.new.pdf_from_string(statement)
	# 	# send_data pdf, filename: 'statement.pdf'
	# end	
	def get_statement
		StatementMailer.send_statement('tomnyongesa@outlook.com').deliver		
	end
end
