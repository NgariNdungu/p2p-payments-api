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

  test 'should have an account after creation' do
    agency = nil
    assert_difference('Account.where(owner_type: "Agency").count') do
      agency = create(:agency)
    end
    refute_nil agency.account, 'should have account after creation'
  end

  test 'should have a single account' do
    agency = create(:agency)
    account = nil
    assert_no_difference('Account.count', 'should not create another account') do
      account = Account.create(owner: agency)
    end
    assert account.errors[:agency].present?, 'should have error on existing agency account'
  end
end
