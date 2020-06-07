# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  post '/mercadopago/checkout', to: 'mercadopago#checkout', as: :mercadopago_checkout
  get  '/mercadopago/success', to: 'mercadopago#success', as: :mercadopago_success
  get  '/mercadopago/failure', to: 'mercadopago#failure', as: :mercadopago_failure
  post '/mercadopago/ipn', to: 'mercadopago#ipn', as: :mercadopago_ipn
end
