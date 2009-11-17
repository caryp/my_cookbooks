maintainer       "RightScale, Inc."
maintainer_email "cary@rightscale.com"
license          "All rights reserved"
description      "Installs/Configures storage_test"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"


attribute "storage_test/s3/user",
  :display_name => "Amazon Access Key ID",
  :required => true

attribute "storage_test/s3/key",
  :display_name => "Amazon Secret Access Key",
  :required => true
  
attribute "storage_test/cloudfiles/user",
  :display_name => "Rackspace Username",
  :required => true

attribute "storage_test/cloudfiles/key",
  :display_name => "Rackspace Authorization Key",
  :required => true