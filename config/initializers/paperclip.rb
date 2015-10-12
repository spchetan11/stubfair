require "paperclip/railtie"

require 'paperclip/media_type_spoof_detector'

Paperclip::Railtie.insert

module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end