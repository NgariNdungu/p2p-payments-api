class StatementController < ApplicationController
    def statement
        # @user=User.first
        StatementMailer.send_statement('tomnyongesa@outlook.com').deliver
    end
end
