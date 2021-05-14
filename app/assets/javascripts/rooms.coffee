$(document).on 'turbolinks:load', ->
    $target = document.querySelector('.target')
    $button = document.querySelector('.button')
    $button.addEventListener 'click', ->
        $target.classList.toggle 'hidden'
        return
