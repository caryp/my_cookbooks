maintainer        "RightScale, Inc."
maintainer_email  "cookbooks@rightscale.com"
license           "Copyright (c) 2009 RightScale, Inc, All Rights Reserved Worldwide."
description       "installs the pasenger version of rails"
version           "0.1"

attribute "rails",
  :display_name => "rails hash",
  :description => "hash of rails attributes",
  :type => "hash"
  
attribute "rails/code",
  :display_name => "rails application code hash",
  :description => "hash of rails code attributes",
  :type => "hash"

#
# required
#
attribute "rails/db_app_user",
  :display_name => "database user",
  :description => "username for database access",
  :required => true

attribute "rails/db_app_passwd",
  :display_name => "database password",
  :description => "password for database access",
  :required => true

attribute "rails/db_schema_name",
  :display_name => "database schema name",
  :description => "database schema to use",
  :required => true

attribute "rails/db_dns_name",
  :display_name => "database dns name",
  :description => "FQDN of the database server",
  :required => true


attribute "rails/code/url",
  :display_name => "repository url",
  :description => "location of application code repository",
  :required => true

attribute "rails/code/user",
  :display_name => "repository username",
  :description => "username for code repository",
  :required => true

attribute "rails/code/creditials",
  :display_name => "repository credentials",
  :description => "credentials for code repository",
  :required => true

#
# recommended
#
attribute "rails/server_name",
  :display_name => "server name",
  :description => "FQDN for the server",
  :default => "myserver"

attribute "rails/application_name",
  :display_name => "application name",
  :description => "give a name to your application",
  :default => "myapp"

attribute "rails/env",
  :display_name => "rails environment",
  :description => "production, test, staging, etc.",
  :default => "production"

#
# optional
#
attribute "rails/code/destination",
  :display_name => "application home",
  :description => "what directory do you want your application to live in?",
  :default => "/home/webapp/<app_name>"

attribute "rails/code/branch",
  :display_name => "repository branch",
  :description => "branch to pull source from",
  :default => "master"
  
attribute "rails/application_port",
  :display_name => "application port",
  :description => "the port your rails application will listen on",
  :default => "8000"

attribute "rails/spawn_method",
  :display_name => "spawn method",
  :description => "what spawn method should we use?",
  :default => "conservative"

attribute "rails/opt_gems_list",
  :display_name => "opt_gems_list",
  :description => "list of gems required by your application",
  :type => "array",
  :required => false
