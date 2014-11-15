wordpress Cookbook
==================

Just another WordPress cookbook.
This cookbook supports multiple WordPress install.

Requirements
------------

#### Cookbooks

- apt
- apache2
- php
- mysql
- database

#### Pratform

- Ubuntu 12.04
- Ubuntu 14.04 ( maybe )

Attributes
----------

#### wordpress::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[:wordpress][:base_dir]</tt></td>
    <td>String</td>
    <td>This cookbook suports multiple WordPress install. Those sites are placed this directory.</td>
    <td><tt>/var/www</tt></td>
  </tr>
  <tr>
    <td><tt>[:wordpress][:sites][:name]</tt></td>
    <td>String</td>
    <td>Domain name of the site. This value is also used directory name.</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>[:wordpress][:sites][:version]</tt></td>
    <td>Integer</td>
    <td>WordPress version ex) 4.0</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>[:wordpress][:sites][:lang]</tt></td>
    <td>String</td>
    <td>The specified language file is downloaded into /wp-content/languages</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>[:wordpress][:sites][:db][:name]</tt></td>
    <td>String</td>
    <td>MySQL database name</td>
    <td><tt>wordpress.example.com</tt></td>
  </tr>
  <tr>
    <td><tt>[:wordpress][:sites][:db][:user]</tt></td>
    <td>String</td>
    <td>MySQL database user</td>
    <td><tt>wordpress</tt></td>
  </tr>
  <tr>
    <td><tt>[:wordpress][:sites][:db][:pass]</tt></td>
    <td>String</td>
    <td>MySQL database password</td>
    <td><tt>wordpress</tt></td>
  </tr>
  <tr>
    <td><tt>[:wordpress][:sites][:db][:host]</tt></td>
    <td>String</td>
    <td>MySQL database host</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>[:wordpress][:sites][:db][:charset]</tt></td>
    <td>String</td>
    <td>MySQL database charset</td>
    <td><tt>utf8</tt></td>
  </tr>
  <tr>
    <td><tt>[:wordpress][:sites][:db][:collate]</tt></td>
    <td>String</td>
    <td>MySQL database collate</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>[:wordpress][:sites][:table prefix]</tt></td>
    <td>String</td>
    <td>MySQL database table prefix</td>
    <td><tt>wp_</tt></td>
  </tr>
  <tr>
    <td><tt>[:wordpress][:sites][:debug]</tt></td>
    <td>String</td>
    <td>WordPress debug mode</td>
    <td><tt>false</tt></td>
  </tr>
</table>

Usage
-----
#### wordpress::default

Just include `wordpress` in your node's `run_list`:

```json
{
  "mysql": {
    "server_root_password": "p@ssw0rd",
    "server_repl_password": "p@ssw0rd",
    "server_debian_password": "p@ssw0rd",
    "remove_anonymous_users": true,
    "remove_test_database": true
  },
  "wordpress": {
    "sites": [
      {
        "name": "wp1.example.com",
        "version": 3.6,
        "lang": "ja",
        "db": {
          name: wp1
          user: wordpress1
          pass: wordpress1
        }
      },
      {
        "name": "wp2.example.com",
        "version": 4.0,
        "lang": "ja",
        "db": {
          name: wp2
          user: wordpress2
          pass: wordpress2
        }
      }
    ]
  },
  "run_list": [
    "recipe[wordpress]"
  ]
}
```

In this example, WordPress 3.6 is installed in `/var/www/wp1.example.com` and 
WordPress 4.0 is installed in `/var/www/wp2.example.com`.

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: vohedge

License: GPLv2

