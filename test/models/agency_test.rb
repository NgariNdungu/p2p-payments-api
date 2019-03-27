require 'test_helper'

class AgencyTest < ActiveSupport::TestCase
  test 'should create agency' do
    assert_difference('Agency.count') do
      create(:agency)
    end
  end

  test 'should not save agency with missing details' do
    agency = Agency.new
    assert_not agency.save, 'should not save agency with missing details'
    assert agency.errors[:business_name].present?, 'should have error on missing business name'
    assert agency.errors[:location].present?, 'should have error on missing location'
    assert agency.errors[:user].present?, 'should have error on missing user'
  end

  test 'should have an account' do
    agency = nil
    assert_difference('Account.count') do
      agency = create(:agency)
    end
    assert_raises(StandardError) do
      agency.create_account
    end
  end
end
