# frozen_string_literal: true

require 'spec_helper'

module Mercadopago
  describe Notification do
    describe 'without basic parameters' do
      it { expect(described_class.new).not_to be_valid }
    end

    describe 'with unknown topic' do
      it { expect(described_class.new(topic: 'foo', operation_id: 'op123')).not_to be_valid }
    end

    describe 'with correct parameters' do
      it { expect(described_class.new(topic: 'payment', operation_id: 'op123')).to be_valid }
    end
  end
end
