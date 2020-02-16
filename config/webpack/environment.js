const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/dist/jquery.min',
    jQuery: 'jquery/dist/jquery.min',
    Popper: ['popper.js', 'default']
  })
                           )

const config = environment.toWebpackConfig()
config.resolve.alias = {
  jquery: "jquery/dist/jquery.min",
}

module.exports = environment
