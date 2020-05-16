Paperclip.options[:content_type_mappings] = { xls: ["application/octet-stream", "application/vnd.ms-excel" ], xml: ["application/xml", "text/xml"]}
Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_credentials] = YAML.load(ERB.new(File.read(File.join(Rails.root, 'config', 's3.yml'))).result).deep_symbolize_keys!
Paperclip::Attachment.default_options[:s3_protocol] = :https
Paperclip::Attachment.default_options[:s3_region] = 'us-east-2'
Paperclip::Attachment.default_options[:s3_host_name] = "s3-us-east-2.amazonaws.com"
Paperclip::Attachment.default_options[:s3_headers] = {'Content-Disposition' => 'attachment'}
Paperclip::DataUriAdapter.register
# Paperclip::Attachment.default_options[:path] = "#{Rails.root}/tmp/test_files/:class/:id_partition/:style.:extension"