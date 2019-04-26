class StatementMailer < ApplicationMailer
	default from: "statements@greenmamba.com"
	# layout "mail"
	def send_statement(recipient, transaktions)
		@recipient=recipient
		@transaktions=transaktions		
		mail(to: @recipient, subject: "Statement")
	end	
end
