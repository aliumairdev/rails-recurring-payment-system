module StripeServices
  # Service for Stripe Customer operations
  class CustomerService
    def self.create(user)
      response = Stripe::Customer.create({ email: user.email })
      user.stripe_customer_identity = response.id
      user.save
    end
  end

  # Service for Stripe Product operations
  class ProductService
    def self.create(feature)
      feature.stripe_product = Stripe::Product.create({ name: feature.name }).id
      StripeServices::PriceService.create(feature)
      feature.save
    end

    def self.update(feature)
      Stripe::Product.update(feature.stripe_product, name: feature.name)
    end
  end

  # Service for Stripe Price operations
  class PriceService
    def self.create(feature)
      feature.stripe_price = create_flat_price(feature).id
      feature.stripe_metered_price = create_meterd_price(feature).id
    end

    def self.update(feature)
      Stripe::Price.update(feature.stripe_price.to_s, active: false)
      Stripe::Price.update(feature.stripe_metered_price.to_s, active: false)
      create_flat_price(feature)
      create_meterd_price(feature)
      feature.save
    end

    def self.create_flat_price(feature)
      Stripe::Price.create(
        {
          product: feature.stripe_product,
          currency: 'usd',
          unit_amount: feature.unit_price * 100,
          recurring: { interval: 'month', interval_count: 1 }
        }
      )
    end

    def self.create_meterd_price(feature)
      Stripe::Price.create(
        {
          product: feature.stripe_product, currency: 'usd', billing_scheme: 'tiered', tiers_mode: 'graduated',
          tiers: [{ unit_amount_decimal: 0, up_to: feature.max_unit_limit },
                  { unit_amount_decimal: feature.unit_price * 100, up_to: 'inf' }],
          recurring: { interval: 'month', interval_count: 1, usage_type: 'metered', aggregate_usage: 'sum' }
        }
      )
    end
  end
end
