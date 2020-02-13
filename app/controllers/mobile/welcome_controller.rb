class Mobile::WelcomeController < Mobile::ApplicationController
  layout 'mobile'

  def scanner
    render layout: 'qrscanner'
  end
end
