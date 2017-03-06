class StaticPagesController < ApplicationController
  def index
  end

  def landing_page
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
