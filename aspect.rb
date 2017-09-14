#!/usr/bin/ruby

require 'rmagick'

golden_ratio = nil

def calcRatio(img)
	x = img.columns.to_f
	y = img.rows.to_f
	y/x
end

def resizeImage(img, x, y)
	img.gravity=Magick::CenterGravity
	img.crop!(Magick::CenterGravity, x, y)
	img.write(img.filename)
end

ARGV.each do |file|
	img = Magick::Image.read(file).first
	x = img.columns
	y = img.rows
	if !golden_ratio
		golden_ratio = calcRatio(img)
	end
	if (x * golden_ratio).round > y.round
		new_x = (y / golden_ratio).round
		new_y = y.round
		puts "Resizing #{img.filename}. Was #{x}x#{y}, now is #{new_x}x#{new_y}."
		resizeImage(img, new_x, new_y)
	elsif (x * golden_ratio).round < y.round
		new_x = x.round
		new_y = (x * golden_ratio).round
		puts "Resizing #{img.filename}. Was #{x}x#{y}, now is #{new_x}x#{new_y}."
		resizeImage(img, new_x, new_y)
	else
		puts "#{img.filename} is already at correct ratio"
		next
	end
end
