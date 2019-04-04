# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :debit_account, only: %i[withdraw send_money]
  before_action :credit_account, only: %i[deposit send_money]
  # see how you can push the logic here to the model
  def send_money
    txn = current_user.send_money(
      amount: transaction_params[:data][:amount],
      to: transaction_params[:data][:recipient]
    )
    if txn
      render json: txn, status: :ok
    else
      render status: :bad_request
    end
  end

  def withdraw
    txn = current_user.withdraw(
      amount: transaction_params[:data][:amount],
      agent: transaction_params[:data][:agent_number]
    )
    # change to
    # txn = current_user.withdraw(withdraw_params)
    if txn
      render json: txn, status: :ok
    else
      render status: :bad_request
    end
  end

  def deposit
    agent = debit_account(type: 'agency')
    current_user.agency.deposit(
      amount: transaction_params[:data][:amount],
      recipient: transaction_params[:data][:phone]
    )
    render json: agent.transaktions.last, status: :ok
  end

  private

  def debit_account(type: 'user')
    @user = current_user
    return @user.account if type == 'user'
    @user.agency.account
  end

  def credit_account; end

  def agent_account?; end

  def transaction_params
    params.permit(data: {})
  end
end
