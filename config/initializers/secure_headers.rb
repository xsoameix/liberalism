::SecureHeaders::Configuration.configure do |config|
  config.hsts = {
    max_age: 90.years.to_i,
    include_subdomains: true,
    preload: true
  }
  config.x_frame_options = 'DENY'
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = {value: 1, mode: 'block'}
  config.x_download_options = 'noopen'
  config.x_permitted_cross_domain_policies = 'none'
  config.csp = {
    enforce: true,
    default_src: 'self',
    frame_src: 'none',
    img_src: 'self data:',
    script_src: 'self',
    style_src: 'self'
  }
end
