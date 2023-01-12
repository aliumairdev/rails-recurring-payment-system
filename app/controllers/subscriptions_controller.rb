class SubscriptionsController < ApplicationController
  def create
    current_user.set_payment_processor :stripe
    # current_user.customer
    prices = Feature.joins(:plans).where(plans: { id: params[:plan_id] }).select(:stripe_price, :stripe_metered_price,
                                                                                 :max_unit_limit)
    session = current_user.payment_processor.checkout(
      mode: 'subscription',
      line_items: [
        *prices.map { |item| { price: item.stripe_price, quantity: item.max_unit_limit } },
        *prices.map { |item| { price: item.stripe_metered_price } }
      ]
    )
    redirect_to session[:url]
  end
end
