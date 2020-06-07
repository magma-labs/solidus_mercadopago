//= require spree/frontend

Mercadopago = {
  hidePaymentSaveAndContinueButton: function(paymentMethod) {
    if (Mercadopago.paymentMethodID && paymentMethod.val() == Mercadopago.paymentMethodID) {
      $('.continue').hide();
      $('[data-hook=coupon_code]').hide();
    } else {
      $('.continue').show();
      $('[data-hook=coupon_code]').show();
    }
  }
};

$(document).ready(function() {
  checkedPaymentMethod = $('div[data-hook="checkout_payment_step"] input[type="radio"]:checked');
  Mercadopago.hidePaymentSaveAndContinueButton(checkedPaymentMethod);
  paymentMethods = $('div[data-hook="checkout_payment_step"] input[type="radio"]').click(function (e) {
    Mercadopago.hidePaymentSaveAndContinueButton($(e.target));
  });

  $('button.mercadopago_button').click(function(event){
    $(event.target).prop("disabled",true);
  });
});
