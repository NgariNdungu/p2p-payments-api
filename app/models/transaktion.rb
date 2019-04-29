# frozen_string_literal: true

class Transaktion < ApplicationRecord
  belongs_to :account

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # how to avoid duplicate tranction add uniqieness of transaction via compund fields


  # Method that works out balance summary for an account for last 24hrs
  scope :trasactions_for_last_24_hours, ->{ where(created_at: (Time.now - 24.hours)..Time.now) } 
end
