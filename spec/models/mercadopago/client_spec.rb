# frozen_string_literal: true

require 'spec_helper'
require 'json'

describe Mercadopago::Client, type: :model do
  let(:payment_method) {
    instance_double 'payment_method', id: 1, preferred_client_id: 'app id', preferred_client_secret: 'app secret'
  }

  let(:client) { described_class.new(payment_method) }

  describe '#initialize' do
    it "doesn't raise error with all params" do
      expect { client }.not_to raise_error
    end
  end

  describe '#authenticate' do
    let(:login_json_response) { file_fixture('authenticated.json').read }

    context 'when success' do
      let(:http_response) do
        response = instance_double('response')
        allow(response).to receive(:code).and_return 200
        allow(response).to receive(:to_str).and_return login_json_response
        response
      end

      let(:js_response) { JSON.parse(http_response) }

      before do
        allow(RestClient).to receive(:post).and_return(http_response)
      end

      it 'returns a response object' do
        expect(client.authenticate).to eq(js_response)
      end

      it '#errors returns empty array' do
        client.authenticate
        expect(client.errors).to be_empty
      end

      it 'sets the access token' do
        client.authenticate
        expect(client.auth_response['access_token']).to eq('TU_ACCESS_TOKEN')
      end
    end

    context 'when failure' do
      let(:bad_request_response) do
        response = instance_double('response')
        allow(response).to receive(:code).and_return 400
        allow(response).to receive(:to_str).and_return ''
        response
      end

      before do
        allow(RestClient).to receive(:post).and_raise(RestClient::Exception.new('foo'))
      end

      # rubocop:disable RSpec/MultipleExpectations
      it 'raise exception on invalid authentication' do
        expect { client.authenticate }.to raise_error(RuntimeError) do |_error|
          expect(client.errors).to include(I18n.t(:authentication_error, scope: :mercadopago))
        end
      end
      # rubocop:enable RSpec/MultipleExpectations
    end
  end

  # describe '#check_payment_status' do
  #   let(:collection) { {} }
  #   let(:expected_response) { { results: [collection: collection] } }
  #   let(:payment) { double :payment, payment_method: payment_method, id: 1, identifier: 'fruta' }

  #   before do
  #     allow(subject).to receive(:send_search_request).with(external_reference: payment.id)
  #                                                    .and_return(expected_response)
  #     allow(subject).to receive(:check_status).with(payment, {})
  #   end
  # end

  describe '#redirect_url with #create_preference returns offsite checkout url' do
    context 'when success' do
      subject(:create_preference) { client.create_preferences({ foo: 'bar' }) }

      let(:preferences_json_response) { file_fixture('preferences_created.json').read }
      let(:login_json_response) { file_fixture('authenticated.json').read }

      before do
        response = instance_double('response')
        allow(response).to receive(:code).and_return(200, 201)
        allow(response).to receive(:to_str).and_return(login_json_response, preferences_json_response)
        allow(RestClient).to(receive(:post).twice { response })
        client.authenticate
      end

      it 'return value should not be nil' do
        expect(create_preference).to be_truthy
      end

      it 'sandbox false' do
        allow(client).to receive(:sandbox).and_return(false)
        create_preference
        expect(client.redirect_url).to eq('https://www.Mercadopago.com/checkout/pay?pref_id=identificador_de_la_preferencia')
      end

      it 'sandbox true' do
        allow(client).to receive(:sandbox).and_return(true)
        create_preference
        expect(client.redirect_url).to eq('https://www.Mercadopago.com/checkout/sandbox')
      end
    end

    context 'when failure' do
      let(:preferences) { { foo: 'bar' } }

      it 'throws exception and populate errors' do
        is_second_time = nil
        allow(RestClient).to receive(:post).twice do
          raise RestClient::Exception, 'foo' if is_second_time

          is_second_time = true
          '{}'
        end
        client.authenticate

        expect { client.create_preferences(preferences) }.to raise_error(RuntimeError)
      end
    end
  end

  context 'with payment method preferences' do
    let(:preferences) do
      {
        client_id: '6nVDZ8MsMS',
        client_secret: 'o5ODEtNt6h',
        sandbox: false
      }
    end

    let(:payment_method) { Spree::PaymentMethod::Mercadopago.new(preferences: preferences) }

    let(:mercadopago) { described_class.new(payment_method) }

    describe '#client_id' do
      it 'comes from payment method' do
        expect(mercadopago.send(:client_id)).to eq payment_method.preferred_client_id
      end
    end

    describe '#client_secret' do
      it 'comes from payment method' do
        expect(mercadopago.send(:client_secret)).to eq payment_method.preferred_client_secret
      end
    end

    describe '#sandbox' do
      it 'comes from payment method' do
        expect(mercadopago.send(:sandbox)).to eq payment_method.preferred_sandbox
      end
    end
  end
end
