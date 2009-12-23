TAG = "rs_agent_dev:cookbooks_path=" 
UUID = node[:rightscale][:instance_uuid]
UUID_TAG = "rs_instance:uuid=#{UUID}"

# Add our instance UUID as a tag
right_link_tag UUID_TAG

# Query servers for our cookbook tag...
server_collection UUID do
  tags UUID_TAG
end

# Check query results to see if we have our TAG set.
ruby_block "Query for cookbook" do
  block do
    Chef::Log.info("Checking server collection for tag...")
    h = node[:server_collection][UUID]
    tags = h[h.keys[0]]
    
    result = []
    if tags
      result = tags.select { |s| s == TAG }
    end
  
    unless result.empty?
      Chef::Log.info("  Tag found!")
      node[:devmode][:loaded_custom_cookbooks] = true
    else
      Chef::Log.info("  No tag found -- set and reboot!") 
    end
  end
end

SETUP_FILE = "/root/Dropbox/setup_instance_links.sh"
ruby_block "wait for setup file" do
  not_if do node[:devmode][:loaded_custom_cookbooks] end
  block do
    Chef::Log.info("Waiting for #{SETUP_FILE} to exist.")
    60.times do
      break if ::File.exists?(SETUP_FILE)
      Chef::Log.info("    Still waiting...")
      Kernel.sleep 60
    end
    Chef::Log.info("  Found!")
  end
end

ruby_block "call setup file" do
  not_if do node[:devmode][:loaded_custom_cookbooks] end
  block do
    Chef::Log.info("Executing #{SETUP_FILE}...")
    `chmod +x #{SETUP_FILE}`
    `#{SETUP_FILE}`
  end
end

# /tmp/cookbooks.txt should be created by setup file.
COOKBOOK_FILE = "/tmp/cookbooks_path.txt"
ruby_block "read #{COOKBOOK_FILE}" do
  not_if do node[:devmode][:loaded_custom_cookbooks] end
  only_if do ::File.exists(COOKBOOK_FILE) end
  block do
    ::File.open("#{COOKBOOK_FILE}", "r").each do |f|
      while (line = f.gets) 
        node[:devmode][:cookbooks_tag] = "rs_agent_dev:cookbooks_path=#{line}"
        Chef::Log.info("")
      end
    end
  end
end

# Tell RightLink where to find your development cookbooks
# if not, add tag to instance and...
# right_link_tag node[:devmode][:cookbooks_tag] do
#   not_if do node[:devmode_test][:loaded_custom_cookbooks] end
#   only_if do ::File.exists(COOKBOOK_FILE) end
# end
ruby_block "hack provider with a dynamic tag name" do
  not_if do node[:devmode][:loaded_custom_cookbooks] end
  only_if do ::File.exists(COOKBOOK_FILE) end
  block do
    resrc = Chef::Resource::RightLinkTag.new(node[:devmode][:cookbooks_tag])
    provider = Chef::Provider::RightLinkTag.new(node, resrc)
    provider.send("action_publish")
  end
end

# only reboot if cookbook_path.txt is found!
# ruby_block "reboot" do
#   not_if do node[:devmode_test][:loaded_custom_cookbooks] end
#   only_if do ::File.exists(COOKBOOK_FILE) end
#   block do
#     `init 6`
#   end
# end