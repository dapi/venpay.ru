# Генерирует QR коды
#
# Например:
#
# QRCodeGenerator.new(Machine.take).generate_png
#
class QrCodeGenerator
  DIR = Rails.root.join './public'

  def self.for_machine(machine)
    new Rails.application.routes.url_helpers.slug_url(machine.slug), machine.id
  end

  def initialize(url, file)
    @url = url
    @file = file
  end

  def generate_png
    png = qrcode.as_png(
      bit_depth:         1,
      border_modules:    4,
      color_mode:        ChunkyPNG::COLOR_GRAYSCALE,
      color:             'black',
      file:              nil,
      fill:              'white',
      module_px_size:    6,
      resize_exactly_to: false,
      resize_gte_to:     false,
      size:              120
    )

    IO.write(DIR.join(qr_code_path(:png)).to_s, png.to_s)
  end

  def generate_svg
    svg = qrcode.as_svg(
      offset:          0,
      color:           '000',
      shape_rendering: 'crispEdges',
      module_size:     6,
      standalone:      true
    )
    IO.write(DIR.join(qr_code_path(:svg)).to_s, svg.to_s)
  end

  def qr_code_url
    # TODO add HOST from routes
    '/' + qr_code_path
  end

  def qr_code_path(ext = :svg)
    "qrcodes/#{@file}.#{ext}"
  end

  private

  def qrcode
    @qrcode ||= RQRCode::QRCode.new( @url, size: 2, level: :m)
  end
end
