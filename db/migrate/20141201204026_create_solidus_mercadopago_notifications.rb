# frozen_string_literal: true

class CreateSolidusMercadopagoNotifications < ActiveRecord::Migration[4.2]
  def change
    create_table :mercadopago_notifications do |t|
      t.string :topic
      t.string :operation_id
      t.timestamps
    end
  end
end
