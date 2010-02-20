maintainer       "RightScale, Inc."
maintainer_email "cary@rightscale.com"
license          "All rights reserved"
description      "Installs/Configures rightlink_test"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1"

recipe "rightlink_test::resource_remote_recipe_ping","Called by resource_remote_recipe_test_start -- Add as a operational script."
recipe "rightlink_test::tag_break_point_test","Add a breakpoint at tag_break_point_test_should_never_run recipe and reboots server."
recipe "rightlink_test::core_env_test","Verifies all require rightscale environment variables are available in the Chef node."
recipe "rightlink_test::resource_remote_recipe_test_start","Starts the remote_recipe 'ping-pong' test.  This must be run as an operational script (or you will get stuck in an endless loop)"
recipe "rightlink_test::tag_break_point_test_should_never_run","Used by tag_break_point_test. This must be the last boot script in your template."
recipe "rightlink_test::ohai_plugin_test","Verifies all custom ohai plugin values are available in the Chef node."
recipe "rightlink_test::resource_remote_recipe_pong","Called by resource_remote_recipe_test_start -- Add as a operational script."
recipe "rightlink_test::resource_server_collection_test","Tests the ability to query tags on the local server."
recipe "rightlink_test::resource_right_link_tag_test","Test the ability to add and remove tags."
recipe "rightlink_test::resource_remote_recipe_setup","Tags a server as a ping receiver.  Any server with this tag needs resource_remote_recipe_ping & resource_remote_recipe_pong as operational scripts."
recipe "rightlink_test::tag_cookbook_path_test","Copies this repo to a local dir, sets the cookbook_path tag, and reboots server."
recipe "rightlink_test::state_test_setup","Overwrites default attribute the first time run. This can be boot or op script."
recipe "rightlink_test::state_test_check_value","Verifies attribute setup in state_test_setup was persisted. This should be run as an operational script."

attribute "state_test/value",
  :display_name => "State Test Value",
  :desription => "The default value for the attribute used in the state test recipes.",
  :recipes => [ "rightlink_test::state_test_setup" ]