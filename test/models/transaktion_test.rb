# frozen_string_literal: true

require 'test_helper'

class TransaktionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'create a transaktion' do
    assert_difference('Transaktion.count', 1) do
      create(:transaktion)
    end
  end
end
