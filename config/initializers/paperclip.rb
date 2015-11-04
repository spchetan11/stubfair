require "paperclip/railtie"

require 'paperclip/media_type_spoof_detector'

Paperclip::Railtie.insert

Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end