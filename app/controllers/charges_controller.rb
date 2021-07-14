# frozen_string_literal: true

class ChargesController < ApplicationController
  # Hi there! I apologize for the confusion and the commented code, the stripe was new to me,
  # I wanted to deal with the sessions (since I realized that the Charge is outdated)
  # but alas, it does not complete successfully.
  def create
    # session = Stripe::Checkout::Session.create({
    #   customer: stripe_customer.id,
    #   payment_method_types: params[:stripePaymentType],
    #   allow_promotion_codes: true,
    #   line_items: [
    #     price_data: {
    #       product: '{{PRODUCT_ID}}',
    #       unit_amount: 1500,
    #       currency: 'usd',
    #     },
    #     quantity: 1,
    #   ],
    #   mode: 'payment',
    #   success_url: 'https://success_example.com',
    #   cancel_url: 'https://cancel_example.com'
    # })

    # render json: session, status: :ok

    charge = Stripe::Charge.create(
      customer: stripe_customer.id,
      amount: params[:stripeAmount],
      description: params[:stripeDescription],
      currency: params[:stripeCurrency]
    )

    render json: charge, status: :ok
  rescue Stripe::CardError => e
    render json: { message: e.message }, status: :not_acceptable
  end

  def add_source
    Stripe::Customer.create_source(stripe_customer.id, { source: params[:stripeTypeSource] })
    render json: I18n.t('message.card_added'), status: :ok
  rescue Stripe::CardError => e
    render json: { message: e.message }, status: :not_acceptable
  end

  private

  def stripe_customer
    StripeCustomerService.new(current_user, params).call
  end
end
