class StatementMailer < ApplicationMailer
	
	def send_statement(recipient)
		mail(to: recipient)
	end
end
