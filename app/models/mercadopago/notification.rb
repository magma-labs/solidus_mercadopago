# frozen_string_literal: true

module Mercadopago
  class Notification < ActiveRecord::Base
    self.table_name = 'mercadopago_notifications'

    validates :topic, presence: true, inclusion: { in: %w[payment preapproval authorized_payment merchant_order] }
    validates :operation_id, presence: true
  end
end
