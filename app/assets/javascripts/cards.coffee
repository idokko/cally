# document.addEventListener 'DOMContentLoaded' ->
#     if document.URL.match(/cards/)
#         console.log()
#         # if document.getElementById('info-submit') != blank
#         payjp = Payjp.setPublicKey('pk_test_2956ed7ed3b3ff8f29a0cfd1')
#         elements = payjp.elements()
        
#         numberElement = elements.create('cardNumber')
#         expiryElement = elements.create('cardExpiry')
#         cvcElement = elements.create('cardCvc')
#         numberElement.mount '#number-form'
#         expiryElement.mount '#expiry-form'
#         cvcElement.mount '#cvc-form'
#         submit_btn = $('#info-submit')
#         submit_btn.click (e) ->
#             e.preventDefault()
#             payjp.createToken(numberElement).then (response) ->
#                 if response.error
#                     alert response.error.message
#                     regist_card.porp 'disabled', false
#                 else
#                     alert '登録が完了しました'
#                     $('#card_token').append('<input type="hidden" name="payjp_token" val(response.id)>
#                                             <input type="hidden" name="card_token" val(response.card.id)>')
#                     # $('#card_token').append('<input type="hidden" name="payjp_token">'.value(response.id))
#                     $('#card_form')[0].submit()
#                     $('#card_number').removeAttr 'name'
#                     $('#cvc-form').removeAttr 'name'
#                     $('#exp_month').removeAttr 'name'
#                     $('#exp_year').removeAttr 'name'
#                 return
#             return
#         # return
#     return