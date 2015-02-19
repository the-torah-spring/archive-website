require 'RMagick'

class Thumbnails < Jekyll::Command
  class << self
    def init_with_program(prog)

      prog.command(:generate_thumbnails) do |c|
        c.syntax "generate_thumbnails [options]"
        c.description 'Generate PDF Thumbnails.'
	c.alias :thumbs
	
	add_build_options(c)

	c.option 'pdf_loc', '-s SRC', 'Source of PDF files.'
        c.option 'thumb_loc', '-d DEST', 'Where the thumbnails should go.'

        c.action do |args, options|
	  options = configuration_from_options(options)
	  Dir.glob(options['pdf_loc'] + "**/*" + options['pdf_ext']) do |fn| # note one extra "*"
	    fn.slice! options['pdf_loc']
	    fn.slice! options['pdf_ext']

	    pdf_fn = options['pdf_loc'] + fn + options['pdf_ext'] + "[0]" # first page in PDF
	    thumb_fn = options['thumb_loc'] + fn + options['thumb_ext']
            
	    dir = File.dirname(thumb_fn)
            unless File.directory?(dir)
              FileUtils.mkdir_p(dir)
            end
	    
	    if !File.file?(thumb_fn)
	      puts "Writing  #{thumb_fn}"
              pdf = Magick::Image.read(pdf_fn).first
              thumb = pdf.thumbnail(300, 250)
              thumb.write thumb_fn
#	    else
#	      puts "Skipping #{thumb_fn}"
	    end
          end
        end
      end
    end
  end
end