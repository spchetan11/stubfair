class Picture < ActiveRecord::Base
	belongs_to :event, class_name: "Event"

	has_attached_file :image,
    # :path => ":rails_root/public/images/:id/:filename",
    # :url  => "/images/:id/:filename"

    # :storage => :s3,
    # :s3_host_name => ENV['s3-us-west-2.amazonaws.com'],
    # :s3_region => ENV['s3-us-west-2.amazonaws.com'],
    # :s3_protocol    => "https",
    # :bucket => ENV['S3_BUCKET_NAME'],
    # :s3_credentials => {
    # :bucket => ENV['S3_BUCKET_NAME'],
    # :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    # :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']}

    do_not_validate_attachment_file_type :image
end
