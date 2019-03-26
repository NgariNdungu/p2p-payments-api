require 'test_helper'

class AgencyTest < ActiveSupport::TestCase
  test 'should create agency' do
    assert_difference('Agency.count') do
      create(:agency)
    end
  end

  test 'should not save agency with missing details' do
    agency = Agency.new
    binding.pry
    assert_not agency.save, 'should not save agency with missing details'
    assert agency.errors[:business_name].present?, 'should have error on missing business name'
    assert agency.errors[:location].present?, 'should have error on missing location'
  end

  test 'should delete agency' do
    create(:agency)
    assert_difference('Agency.count', -1) do
      Agency.last.destroy
    end
  end

  test 'should update agency details' do
    business_name = 'new business'
    agency = create(:agency)
    agency.update_attributes({business_name: business_name})
    # agency.reload
    assert_equal business_name, agency.business_name, 'Should update business name'
  end
end
