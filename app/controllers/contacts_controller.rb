class ContactsController < ApplicationController


  def index
    @contacts = Contact.where(status: "[]").where(user: current_user).paginate(page: params[:c_pg], per_page: 10)
  end

  def not_imported
    @contacts = Contact.where.not(status: "[]").where(user: current_user).paginate(page: params[:c_pg], per_page: 10)
  end
end
