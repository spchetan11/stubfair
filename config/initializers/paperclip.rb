require "paperclip/railtie"

require 'paperclip/media_type_spoof_detector'

Paperclip::Railtie.insert

Paperclip::Attachment.default_options[:url] = ':d103hpfao1jklo.cloudfront.net'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'
Paperclip::Attachment.default_options[:s3_region] = 'us-west-2'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end