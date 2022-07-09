class BulkAccountsController < ApplicationController
  def new
    @accounts = 2.times.map{ Account.new }
  end

  def create
    is_success = false
    @accounts = accounts_params.map { Account.new(_1).tap(&:valid?) }
    ActiveRecord::Base.transaction do
      is_success = @accounts.none? { _1.errors.any? } and @accounts.all?(&:save!)
      raise ActiveRecord::RecordInvalid unless is_success
    end
  rescue ActiveRecord::RecordInvalid
    is_success = false
  rescue ActiveRecord::RecordNotUnique
    is_success = false
    flash.now[:alert] = "Account already exists."
  ensure
    if is_success
      redirect_to new_bulk_account_url, notice: "Accounts were successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def accounts_params
      params.require(:accounts).map { _1.permit(:name, :email) }
    end
end
