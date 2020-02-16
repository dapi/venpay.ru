// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import 'jquery'
import 'bootstrap/dist/js/bootstrap.bundle'
import 'bootstrap/dist/css/bootstrap'
import 'noty_flash'
import 'noty'

function importAll (r) { r.keys().forEach(r); }
importAll(require.context('../elements', true, /\.js$/))

const initialHandler = () => {
  $(document). // TODO bind on modal content only
    on('shown.bs.modal', (e) => $('[autofocus]', e.target).focus() )
  $('[data-toggle="tooltip"]').tooltip()
}

document.addEventListener('turbolinks:load', initialHandler)

$.ajaxSetup({
  xhrFields: {
    withCredentials: true
  }
})


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
