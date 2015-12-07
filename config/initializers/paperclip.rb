require "paperclip/railtie"

require 'paperclip/media_type_spoof_detector'

Paperclip::Railtie.insert

#Paperclip::Attachment.default_options[:url] = 'pavan-events.s3.amazonaws.com'
#Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:filename'
Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'
Paperclip::Attachment.default_options[:s3_region] = 'us-west-2'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end