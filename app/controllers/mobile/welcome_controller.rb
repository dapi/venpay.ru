class Mobile::WelcomeController < ApplicationController
  layout 'qrscanner'

  def install
    render layout: 'mobile'
  end
end
