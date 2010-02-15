require "rubygems"
require "rest_connection"
require "net/ssh"

Given /A deployment./ do
  @all_servers = Array.new
  @all_responses = Array.new
  @deployment = Deployment.find_by_nickname_speed(ENV['DEPLOYMENT']).first
  raise "FATAL: Couldn't find a deployment with the name #{ENV['DEPLOYMENT']}! Please set the environment variable $DEPLOYMENT" unless @deployment
  puts "found deployment to use: #{@deployment.nickname}, #{@deployment.href}"
end

Given /^"([^\"]*)" operational servers./ do |num|
  servers = @deployment.servers_no_reload
  @servers = servers.select { |s| s.nickname =~ /#{ENV['SERVER_TAG']}/ }
  # only want 2 even if we matched more than that.
  @servers.slice!(2)
  raise "need at least #{num} servers to start, only have: #{@servers.size}" if @servers.size < num.to_i
  @servers.each { |s| s.start } 
  @servers.each { |s| s.wait_for_operational_with_dns } 
end

Given /A deployment named "(.*)"/ do | deployment |
  @all_servers = Array.new
  @all_responses = Array.new
  @deployment = Deployment.find_by_nickname_speed(deployment).first
  raise "FATAL: Couldn't find a deployment with the name #{deployment}!" unless deployment
end

Given /A server named "(.*)"/ do |server|
  servers = @deployment.servers_no_reload
  @server = servers.detect { |s| s.nickname =~ /#{server}/ }
  @server.start
  @server.wait_for_state("operational")
  raise "FATAL: couldn't find a server named #{server}" unless server
end

Given /^"([^\"]*)" operational servers named "([^\"]*)"$/ do |num, server_name|
  servers = @deployment.servers_no_reload
  @servers = servers.select { |s| s.nickname =~ /#{server_name}/ }
  @servers.each do |s| 
    @all_servers.push s
  end
  #@all_servers.push  { |s| s.nickname =~ /#{server_name}/ }
  raise "need at least #{num} servers to start, only have: #{@servers.size}" if @servers.size < num.to_i
  @servers.each { |s| s.start } 
  @servers.each { |s| s.wait_for_operational_with_dns } 
end

Then /^I should sleep (\d+) seconds\.$/ do |seconds|
  sleep seconds.to_i
end

Then /I should set a variation lineage./ do
  lin = "text:testlineage#{rand(1000000)}"
  @deployment.set_input('db/backup/lineage', lin)
end
