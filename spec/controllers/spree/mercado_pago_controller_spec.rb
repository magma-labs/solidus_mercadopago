# frozen_string_literal: true

require 'spec_helper'

describe Spree::MercadopagoController, type: :controller do
  describe '#ipn' do
    let(:operation_id) { 'op123' }

    context 'for valid notifications' do
      let(:use_case) { double('use_case') }

      it 'handles notification and returns success' do
        allow(Mercadopago::HandleReceivedNotification).to receive(:new).and_return(use_case)
        expect(use_case).to receive(:process!)

        post :ipn, params: { id: operation_id, topic: 'payment', format: :json }
        expect(response).to be_ok

        notification = Mercadopago::Notification.order(:created_at).last
        expect(notification.topic).to eq('payment')
        expect(notification.operation_id).to eq(operation_id)
      end
    end

    context 'for invalid notification' do
      it 'responds with invalid request' do
        post :ipn, params: { id: operation_id, topic: 'nonexistent_topic', format: :raw }
        expect(response).to be_bad_request
      end
    end
  end
end
