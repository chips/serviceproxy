require 'hpricot'

# Service Endpoints
class ISBNService < ServiceProxy::Base  
  
  def build_is_valid_isbn13(options)
    soap_envelope(options) do |xml|
      xml.sISBN(options[:isbn])
    end
  end
  
  def parse_is_valid_isbn13(response)
    xml = Hpricot.XML(response.body)
    xml.at("m:IsValidISBN13Result").inner_text == 'true' ? true : false
  end
  
  def service_port
    local_uri = URI.parse(self.isbn_service_soap_uri.to_s)
    local_uri.path << "?dummy=1"
    local_uri
  end
end

class SHAGeneratorService < ServiceProxy::Base
  
  def build_gen_ssha(options)
    soap_envelope(options) do |xml|
      xml.text(options[:text])
      xml.hashtype(options[:hash_type])
    end
  end
  
  def parse_gen_ssha(response)
    xml = Hpricot.XML(response.body)
    xml.at("return").inner_text
  end
end

class InvalidSHAGeneratorService < ServiceProxy::Base
  
  def build_gen_ssha(options)
    soap_envelope(options) do |xml|
      xml.text(options[:text])
      xml.hashtype(options[:hash_type])
    end
  end
  
end

class EbayService < ServiceProxy::Base
end