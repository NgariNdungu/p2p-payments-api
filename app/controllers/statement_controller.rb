<<<<<<< HEAD
class StatementController < ApplicationController		
	# def generate_pdf
	# 	# statement = render_to_string pdf: "statement", template: "statment.html.erb", encoding: "UTF-8"
	# 	# pdf = WickedPdf.new.pdf_from_string(statement)
	# 	# send_data pdf, filename: 'statement.pdf'
	# end	
	def get_statement
		StatementMailer.send_statement('tomnyongesa@outlook.com').deliver		
	end
=======
class StatementController < ApplicationController
    def statement
        # @user=User.first
        StatementMailer.send_statement('tomnyongesa@outlook.com').deliver
    end
>>>>>>> ed88a389b624c3db25e779d21093ce41f08cc19c
end
