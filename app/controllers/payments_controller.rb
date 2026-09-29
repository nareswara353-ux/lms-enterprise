class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:webhook], raise: false
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def index
    @payments = current_user.payments.recent.includes(:course)
  end

  def show
    @payment = current_user.payments.find(params.expect(:id))
  end

  def create
    course = Course.find(params.expect(:course_id))
    payment = current_user.payments.create!(course: course, amount: course.price, currency: "idr", status: :pending)
    checkout_url = StripeCheckoutService.new(payment).call
    redirect_to checkout_url, allow_other_host: true
  rescue Stripe::StripeError => e
    redirect_to course_path(course), alert: "Pembayaran gagal: #{e.message}"
  end

  def webhook
    event = StripeWebhookVerifier.new(request).verify
    StripeWebhookHandler.new(event).call
    head :ok
  rescue Stripe::SignatureVerificationError
    head :bad_request
  end
end
