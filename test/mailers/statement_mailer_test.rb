require 'test_helper'

class StatementMailerTest < ActionMailer::TestCase
  test "mail sent" do  	
  	@recipient=create(:user)
  	@recipient2=create(:user)
  	# binding.pry
  	email=StatementMailer.send_statement(@recipient.email)
  	assert_emails 1 do
  		email.deliver_now
  	end
  	assert_equal(["usera@domain.com"], email.to)
  	assert_equal(["from@example.com"], email.from)
  	assert_equal('Statement', email.subject)
  end
end
