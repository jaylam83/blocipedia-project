class ChargesController < ApplicationController
def new
  @stripe_btn_data = {
  key: "#{ Rails.configuration.stripe[:publishable_key] }",
  description: "Upgrade to Premium Account",
  amount: "5000"
  }
end

def create

  #Amount
  @amount = 5000
  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
    )

  charge = Stripe::Charge.create(
    customer: customer.id,
    amount: @amount,
    description: "Premium Membership - #{current_user.email}",
    currency: 'usd'
    )

  flash[:success] = "Thank you for upgrading, #{current_user.name}!"
  current_user.role = "premium"
  current_user.save!
  redirect_to edit_user_registration_path


rescue Stripe::CardError => e 
  flash[:error] = e.message
  redirect_to new_charge_path
end
end

