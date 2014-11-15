name             'wordpress'
maintainer       'none'
maintainer_email 'vohedge@gmail.com'
license          'GPLv2'
description      'Installs/Configures WordPress'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apt'
depends 'apache2'
depends 'php'
depends 'mysql'
depends 'database'

