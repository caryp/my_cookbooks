maintainer       "RightScale, Inc."
maintainer_email "cary@rightscale.com"
license          "All rights reserved"
description      "Installs/Configures rest_connection"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"

attribute "rest_connection/api/user",
  :display_name => "API Username",
  :description => "Username used to access the RigthScale API.",
  :required => true

attribute "rest_connection/api/url",
  :display_name => "API URL",
  :description => "URL used to access the RigthScale API.",
  :required => true

attribute "rest_connection/api/password",
  :display_name => "API Password",
  :description => "Password used to access the RigthScale API.",
  :required => true

attribute "rest_connection/ssh/key",
  :display_name => "SSH Key",
  :description => "SSH Key to login to server so we can run commands.",
  :required => true
