# frozen_string_literal: true
# This migration comes from solidus_mercadopago (originally 20141201204026)

class CreateSolidusMercadopagoNotifications < ActiveRecord::Migration[4.2]
  def change
    create_table :mercadopago_notifications do |t|
      t.string :topic
      t.string :operation_id
      t.timestamps
    end
  end
end
