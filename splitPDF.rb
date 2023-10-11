#!/usr/bin/env ruby

require 'combine_pdf'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: split_pdf_tool.rb [options]"

  opts.on("-i", "--input INPUT", "Input PDF file") do |v|
    options[:input] = v
  end

  opts.on("-o", "--output OUTPUT", "Output directory (default: current directory)") do |v|
    options[:output] = v
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!

unless options[:input]
  puts "Error: Please specify an input PDF file using the -i option."
  exit(1)
end

output_dir = options[:output] || "."

def split_pdf(input_file, output_dir)
  pdf = CombinePDF.load(input_file)
  pdf.pages.each_with_index do |page, index|
    output = CombinePDF.new
    output << page
    output_filename = File.join(output_dir, "output_page_#{index + 1}.pdf")
    output.save(output_filename)
    puts "Saved: #{output_filename}"
  end
end

split_pdf(options[:input], output_dir)

