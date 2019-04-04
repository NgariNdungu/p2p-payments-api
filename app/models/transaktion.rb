# frozen_string_literal: true

class Transaktion < ApplicationRecord
  belongs_to :account

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # how to avoid duplicate tranction add uniqieness of transaction via compund fields
end
