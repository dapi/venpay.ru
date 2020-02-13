$(() => {
  $('#new_start_form')
    .on('ajax:complete', (e) => $(e.target).html(e.detail[0].response))
})
