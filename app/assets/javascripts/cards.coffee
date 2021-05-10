$(window).bind 'turbolinks:load', ->
    if document.URL.match(/cards/)
        payjp = Payjp('pk_test_0c2dc88b8402a1cb63f0687d')
        elements = payjp.elements()
        
        numberElement = elements.create('cardNumber')
        expiryElement = elements.create('cardExpiry')
        cvcElement = elements.create('cardCvc')
        
        numberElement.mount '#number-form'
        expiryElement.mount '#expiry-form'
        cvcElement.mount '#cvc-form'
        submit_btn = $('#info-submit')
        submit_btn.click (e) ->
            e.preventDefault()
            payjp.createToken(numberElement).then (response) ->
                if response.error
                    alert response.error.message
                    regist_card.porp 'disabled', false
                else
                    alert '登録が完了しました'
                    $('#card-form').append $('<input type="hidden" name="payjp_token">').val(response.id), 
                                            '<input type="hidden" name="card_token">'.val(response.card.id)
                    $('#card-form')[0].submit()
                    $('#card_number').removeAttr 'name'
                    $('#cvc-form').removeAttr 'name'
                    $('#exp_month').removeAttr 'name'
                    $('#exp_year').removeAttr 'name'
                return
            return
    return