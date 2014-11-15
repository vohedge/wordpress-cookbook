default_unless[:wordpress]                         = {}
default[:wordpress][:base_dir]                     = '/var/www'
default[:wordpress][:site_defaults][:name]         = 'wordpress.example.com'
default[:wordpress][:site_defaults][:version]      = 4.0
default[:wordpress][:site_defaults][:lang]         = nil
default[:wordpress][:site_defaults][:db][:name]    = 'wordpress'
default[:wordpress][:site_defaults][:db][:user]    = 'wordpress'
default[:wordpress][:site_defaults][:db][:pass]    = SecureRandom.hex
default[:wordpress][:site_defaults][:db][:host]    = 'localhost'
default[:wordpress][:site_defaults][:db][:charset] = 'utf8'
default[:wordpress][:site_defaults][:db][:collate] = ''
default[:wordpress][:site_defaults][:table_prefix] = 'wp_'
default[:wordpress][:site_defaults][:debug]        = 'false'

