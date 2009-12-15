COLLECTION_NAME = "breakpoints"
BREAKPOINT_TAG = "rs_agent_dev:break_point=devmode_test::test_should_never_run"

# Add our instance UUID as a tag
right_link_tag "rs_instance:uuid=#{node[:rightscale][:instance_uuid]}"

# Query servers for our breakpoint tag...
server_collection COLLECTION_NAME do
  tags BREAKPOINT_TAG
end

# Check query results to see if we have the breakpoint set.
ruby_block "debug" do
  block do
    uuids = [ ]
    node[:server_collection][COLLECTION_NAME].each do |id, tags|
      Chef::Log.info("CKP:id#{id} tags #{tags.inspect}")
      uuids = tags.select { |s| s =~ /rs_instance:uuid/ }
    end 
    
    Chef::Log.info("CKP: uuids: #{uuids.inspect}")
    
    # is our uuid in this list of tags?
    uuids.each do |tag|
      uuid = tag.split("=").last
      if uuid == node[:rightscale][:instance_uuid]
        Chef::Log.info("Found our UUID in list of tags!!")
        node[:devmode_test][:has_breakpoint] = true
        break;
      end
    end
    
  end
end

# Set breakpoint if not set.
right_link_tag BREAKPOINT_TAG do
  not_if node[:devmode_test][:has_breakpoint]
end

#TODO: add a reboot count check and fail if count > 3

# Reboot, if not set
ruby_block "reboot" do
  not_if node[:devmode_test][:has_breakpoint]
  block do
    `init 6`
  end
end
