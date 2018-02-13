#!/usr/bin/env ruby

require 'rmagick'

ARGV.each do |file|
  name = File.basename(file, ".*").upcase
	img = Magick::Image.read(file).first
  fsize = (img.rows/12).to_i
  text = Magick::Draw.new
  text.annotate(img, 0,0,0,0, name) {
    self.font = "DejaVu-Serif-Condensed"
    self.pointsize = fsize
    self.gravity = Magick::SouthGravity
  }
	img.write(img.filename) { self.quality = 100 }
end
