require 'test_helper'

class StatementMailerTest < ActionMailer::TestCase
  test "mail sent" do
    @recipient = create(:user)
    # binding.pry
    @transaktions=Transaktion.all
    email = StatementMailer.send_statement(@recipient.email, @transaktions)
    assert_emails 1 do
      email.deliver_now
    end
    assert_equal([@recipient.email], email.to)
    assert_equal(["statements@greenmamba.com"], email.from)
    assert_equal('Statement', email.subject)
    
  end
end
