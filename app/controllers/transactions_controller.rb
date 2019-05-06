# frozen_string_literal: true

class TransactionsController < ApplicationController
  # TODO: use jsonapi for responses
  before_action :authenticate_user!

  # OPTIMIZE: return appropriate debit/credit transaction
  # currently returns a list with the full debit and credit
  def send_money
    txn = current_user.send_money(transaction_params)
    if txn
      render json: txn, status: :ok
    else
      # FIXME: return appropriate error content
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
    # TODO: handle errors 
    txn = current_user.agency.deposit(transaction_params)
    render json: txn, status: :ok
  end

  def get_report
    render json: current_user.get_report(current_user.account), status: :ok
  end

  private

  def transaction_params
    permitted = params.require(:data).permit(:phone, :amount, :agent_number)
          .to_h
    raise ActionController::Badrequest if permitted[:amount].match? /[^0-9.]/

    permitted[:amount] = permitted[:amount].to_f if !permitted[:amount].match? /[^0-9.]/
    permitted
  end
end
