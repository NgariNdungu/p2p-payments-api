# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :debit_account, only: %i[withdraw send_money]

  def send_money
    txn = current_user.send_money(transaction_params)
    if txn
      render json: txn, status: :ok
    else
      render status: :bad_request
    end
  end

  def withdraw
    txn = current_user.withdraw(transaction_params)
    if txn
      render json: txn, status: :ok
    else
      render status: :bad_request
    end
  end

  def deposit
    agent = debit_account(type: 'agency')
    current_user.agency.deposit(transaction_params)
    render json: agent.transaktions.last, status: :ok
  end

  private

  def debit_account(type: 'user')
    @user = current_user
    return @user.account if type == 'user'

    @user.agency.account
  end

  def transaction_params
    permitted = params.require(:data).permit(:phone, :amount, :agent_number)
          .to_h
    raise ActionController::Badrequest if permitted[:amount].match? /[^0-9.]/

    permitted[:amount] = permitted[:amount].to_f if !permitted[:amount].match? /[^0-9.]/
    permitted
  end

  def valid_amount?
    !amount.to_s.match? /[^0-9.]/
  end
end
