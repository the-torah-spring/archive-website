require 'hebruby'

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
      "#{self.heb_year}/#{self.data['pdf']}"
    end
    def pdf_abs_path
      "#{Dir.pwd}/#{site.config['file_loc']}#{pdf_name}"
    end
    def pdf_link
      "#{site.config['link_loc']}#{pdf_name}"
    end
    def has_pdf
      File.file?(self.pdf_abs_path)
    end
    def pdf_size
      "0 bytes"
    end
    
    def to_liquid(attrs = ATTRIBUTES_FOR_LIQUID)
      original_to_liquid(attrs + %w[
        date_string
	pdf_link
	has_pdf
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
