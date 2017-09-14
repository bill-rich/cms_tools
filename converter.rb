#!/usr/bin/env ruby

require 'rmagick'
require 'trollop'

opts = Trollop::options do
  opt :max_geometry, "Maximum geometry for processes pictures (default:1920x1280)", :type => :string, :default => "1920x1280"
  opt :quality, "Jpeg quality to save pictures at (default:70)", :type => :integer, :default => 70
end

ARGV.each do |file|
	img = Magick::Image.read(file).first
	img.strip!
	img.change_geometry!(opts[:max_geometry]){ |cols, rows, img|
		img.resize!(cols, rows)
	}
	img.write(img.filename) { self.quality =opts[:quality] }
end
