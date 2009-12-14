COLLECTION_NAME = "breakpoints"

class Chef::Recipe
  include RightScale::ServerCollection
end

server_collection COLLECTION_NAME do
#  tags "rs_agent_dev:break_point=*"
  tags "*"
end

Chef::Log.info("CKP:server collection: #{get_collection(COLLECTION_NAME)}")


# right_link_tag "set breakpoint" do
#   not_if 