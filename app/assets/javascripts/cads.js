window.addEventListener('turbolinks:load', function() {
    if(document.location.pathname !== "/cards/new") return false;
    const payjp = Payjp('pk_test_2956ed7ed3b3ff8f29a0cfd1');
    var elements = payjp.elements();
    var numberElement = elements.create('cardNumber');
    var expiryElement = elements.create('cardExpiry');
    var cvcElement = elements.create('cardCvc');
    numberElement.mount ('#number-form');
    expiryElement.mount ('#expiry-form');
    cvcElement.mount ('#cvc-form');
    const submit_btn = $("#info-submit");
    
    submit_btn.click(function(e) {
        e.preventDefault();
        payjp.createToken(numberElement).then(function(response) {
          if (response.error) {
              alert(response.error.message)
              regist_card.prop('disabled', false);
              return ;
          } 
          else {
              alert("クレジットカードを登録しました")
              $("#card_token").append(
                  '<input type="hidden" name="payjp_token" value=${response.id}> <input type="hidden" name="card_token" value=${response.card.id}>'
                  );
            numberElement.clear()
            $('#card_form')[0].submit()
          }
        });
    });
});