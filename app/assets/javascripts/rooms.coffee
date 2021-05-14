$(document).on 'turbolinks:load', ->
    document.amountBtn = ->
        amount_area = document.getElementById('amount_area')
        if amount_area.style.display == 'block'
            amount_area.style.display = 'none'
        else
            amount_area.style.display = 'block'
        return
        
    document.getElementById('amount_area').style.display = 'none'

# $(document).on 'turbolinks:load', ->
#     $target = document.querySelector('.target')
#     $button = document.querySelector('.button')
#     $button.addEventListener 'click', ->
#         $target.classList.toggle 'visible'
#         return
