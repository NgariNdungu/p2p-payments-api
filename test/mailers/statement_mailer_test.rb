require 'test_helper'

class StatementMailerTest < ActionMailer::TestCase
  test "mail sent" do  	
  	email=StatementMailer.send_statement('from@example.com')
  	assert_emails 1 do
  		email.deliver_now
  	end
  end
end
