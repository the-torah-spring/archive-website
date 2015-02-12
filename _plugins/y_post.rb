require 'hebruby'
require 'filesize'

module Jekyll
  class Post
    alias_method :original_initialize, :initialize
    alias_method :original_to_liquid, :to_liquid
    alias_method :original_url_placeholders, :url_placeholders
    attr_accessor :heb_date
        
    def initialize(site, source, dir, name)
      original_initialize(site, source, dir, name)
      self.heb_date = Hebruby::HebrewDate.new(self.date.to_date)
    end
    
    def heb_year
      self.heb_date.year
    end
    def heb_month
      self.heb_date.month_name
    end
    def heb_day
      self.heb_date.day
    end
    
    def date_string
      "#{self.date.strftime("%B %e, %Y")} / #{self.heb_day} #{self.heb_month} #{self.heb_year}"
    end
    
    def pdf_name
      pdf_fn = self.data['pdf']
      pdf_fn.slice! site.config['pdf_ext']
      
      "#{self.heb_year}/#{self.data['pdf']}#{site.config['pdf_ext']}"
    end
    def thumb_name
      pdf_fn = self.data['pdf']
      pdf_fn.slice! site.config['pdf_ext']
      
      "#{self.heb_year}/#{pdf_fn}#{site.config['thumb_ext']}"
      
    end
    def pdf_abs_path
      "#{Dir.pwd}/#{site.config['pdf_loc']}#{pdf_name}"
    end
    def thumb_abs_path
      "#{Dir.pwd}/#{site.config['thumb_loc']}#{thumb_name}"
    end
    def pdf_link
      "#{site.config['pdf_link_loc']}#{pdf_name}"
    end
    def thumb_link
      "#{site.config['thumb_link_loc']}#{thumb_name}"
    end
    def has_pdf
      File.file?(self.pdf_abs_path)
    end
    def has_thumb
      File.file?(self.thumb_abs_path)
    end
    def pdf_size
      File.size?(self.pdf_abs_path)
    end
    def thumb_size
      File.size?(self.thumb_abs_path)
    end
    def pdf_size_pretty
      Filesize.new(self.pdf_size, Filesize::SI).pretty
    end
    
    def to_liquid(attrs = ATTRIBUTES_FOR_LIQUID)
      original_to_liquid(attrs + %w[
        date_string
	pdf_link
	thumb_link
	has_pdf
	has_thumb
	pdf_size
	pdf_size_pretty
	heb_year
      ])
    end
    
    def url_placeholders
      ph = original_url_placeholders
      ph.merge ({
        :heb_year    => self.heb_year.to_s
      })
    end
  end
end

class Filesize
  alias_method :original_to_s, :to_s

  # @param (see #to_f)
  # @return [String] Same as {#to_f}, but as a string, with the unit appended.
  # @see #to_f
  def to_s(unit = 'B')
    "%.0f%s" % [to(unit).to_f.to_s, unit]
  end
end
