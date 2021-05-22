# frozen_string_literal: true

require 'spec_helper'

describe Spree::MercadopagoController, type: :controller do
  describe '#ipn' do
    let(:operation_id) { 'op123' }

    context 'when valid notifications' do
      let(:use_case) { instance_double('use_case') }
      let(:notification) { Mercadopago::Notification.order(:created_at).last }

      before do
        allow(Mercadopago::HandleReceivedNotification).to receive(:new).and_return(use_case)
        allow(use_case).to receive(:process!)

        post :ipn, params: { id: operation_id, topic: 'payment', format: :json }
      end

      it 'returns success' do
        expect(response).to be_ok
      end

      it 'handles notification topic' do
        expect(notification.topic).to eq('payment')
      end

      it 'handles notification operation_id' do
        expect(notification.operation_id).to eq(operation_id)
      end
    end

    context 'when invalid notification' do
      it 'responds with invalid request' do
        post :ipn, params: { id: operation_id, topic: 'nonexistent_topic', format: :raw }
        expect(response).to be_bad_request
      end
    end
  end
end
