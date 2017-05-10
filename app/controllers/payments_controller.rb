class PaymentsController < ApplicationController
  def create
    token = params[:stripeToken]
    @product = Product.find(params[:product_id])
    @user = current_user
    # Create charge on Stripe's servers to charge the user's card
    begin
      charge = Stripe::Charge.create(
        amount: (@product.price * 100), # Amount in cents
        currency: 'usd',
        description: params[:stripeEmail],
        receipt_email: @user.email,
        source: token
      )

    if charge.paid
      Order.create(product_id: @product.id, user_id: @user.id, total: @product.price, created_at: Time.now)
    end

    rescue Stripe::CardError => e
      # The card has been declined
      body = e.json_body
      err = body[:error]
      flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
    end
    redirect_to product_path(@product), notice: 'Purchase complete. Thank you!'
  end
end
