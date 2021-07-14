# frozen_string_literal: true

class StripeCustomerService
  attr_reader :user

  def initialize(user, params)
    @user   = user
    @params = params
  end

  def call
    return find_customer if user.stripe_user_id

    create_customer
  end

  private

  def find_customer
    Stripe::Customer.retrieve(user.stripe_user_id)
  end

  def create_customer
    customer = Stripe::Customer.create(email: user.email, source: params[:stripeToken])
    update_user(customer)
    customer
  end

  def update_user(customer)
    user.update(stripe_user_id: customer.id)
  end
end
