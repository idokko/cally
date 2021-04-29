# # $ ->
# #     nowChecked = $('input[name="reward[artist]"]:checked').val()
# #     $('input[name="reward[artist]"]').click ->
# #         if $(this).val() == nowChecked
# #             $(this).prop 'checked', 
# #             nowChecked = 2
# #             $('.text').show()
# #         else
# #             nowChecked = $(this).val()
# #             $('.text').hide()
# #         return
# #     return

# # $ ->
# #     $('input[name="reward[artist]"]').change ->
# #         val = $(this).val()
# #         if val == "yes"
# #             $("#form-group.text").hide()
# #         else
# #             $("#form-group.text").show()
# #         return
# #     return

# $(document).on 'turbolinks:load', ->
#     selecterBox = document.getElementById('profile-field')
    
#     formSwitch = ->
#         check = document.getElementsByClassName
#         if check[0].checked
#             selecterBox.style.display = 'none'
#         else if check[yes].checked
#             selecterBox.style.display = 'block'
#         else
#             selectorBox.style.display = 'none'
#         return
        
#         entryChange2 = ->
#             if document.getElementById('changeSelect')
#                 id = document.getElementById('changeSelect').value
#             return
        
#         window.addEventListener 'load', formSwitch()
#     # $ ->
#     #     $("input.constraction").change ->
#     #         val = $(this).val()
#     #         if val == "yes"
#     #             $('#plofile-field').show()
#     #         else
#     #             $('#plofile-field').hide()
#     #         return
#     #     return
    
#     # $ ->
#     #     nowChecked = $('input[name="product[artist]"]').val()
#     #     $('input[name="reward[artist]"]').click ->
#     #         if $(this).val() == nowChecked
#     #             $(this).prop 'checked', false
#     #             nowChecked = "no"
#     #             $('.text').show()
#     #         else
#     #             nowChecked = $(this).val()
#     #             $('.text').hide()
#     #         return
#     #     return
#     # $ ->
#     # $('input[name="product[artist]"]').change ->
#     #     val = $(this).val()
#     #     if val == "yes"
#     #         $(".text").hide()
#     #     else
#     #         $(".text").show()
#     #     return
#     # return
#     # $ ->
#     #     $("div.form-group").dblclick ->
#     #         alert("Hello World!")
# return