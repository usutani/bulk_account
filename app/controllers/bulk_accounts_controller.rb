class BulkAccountsController < ApplicationController
  def new
    @accounts = 2.times.map{ Account.new }
  end

  def create
    @accounts = accounts_params.map { Account.new(_1).tap(&:valid?) }
    if @accounts.none? { _1.errors.any? }
      @accounts.each(&:save)
      redirect_to new_bulk_account_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def accounts_params
      params.require(:accounts).map { _1.permit(:name, :email) }
    end
end
