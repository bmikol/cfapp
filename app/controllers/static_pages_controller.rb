class StaticPagesController < ApplicationController
  before_action :disable_nav, only: [:landing_page]

  def home
  end

  def landing_page
    @landing_page = true
    @products = Product.limit(5)
  end

  def thank_you
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    UserMailer.contact_form(@email, @name, @message).deliver_now
  end

  private

  def contact_params
    params.require(:name, :email, :message)
  end
end
