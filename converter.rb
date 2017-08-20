#!/usr/bin/ruby

require 'rmagick'

ARGV.each do |file|
	img = Magick::Image.read(file).first
	img.strip!
	img.change_geometry!("1920x1280"){ |cols, rows, img|
		img.resize!(cols, rows)
	}
	img.write(img.filename) { self.quality = 70 }
end
