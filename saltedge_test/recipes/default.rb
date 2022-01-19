#
# Cookbook:: saltedge_test
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

# Install required tools and binary
build_essential

apt_package %w(git gnupg ruby-full ruby-dev libxml2-dev libxslt1-dev libcurl4-gnutls-dev dirmngr apt-transport-https software-properties-common ca-certificates curl)

gem_package "bundler" do
  version "2.1.4"
  action :install
end

# Add MongoDB repository for Debian buster
apt_repository 'MongoDB' do
  uri node['errbit']['repo_url']
  components ['main']
  distribution node['errbit']['repo_dist']
  key node['errbit']['repo_key']
  action :add
end

# Update sources
apt_update 'update the sources'

# Add new user
group node['errbit']['group']
user node['errbit']['user'] do
  action :create
  comment "Deployer user"
  gid node['errbit']['group']
  shell "/bin/bash"
  home "/home/#{node['errbit']['user']}"
  password node['errbit']['password']
  manage_home true
  system true
end

# Install MongoDB
apt_package 'mongodb-org'

# Start and Enable MongoDB
service 'mongod.service' do
  action [ :enable, :start ]
end

# Clone Errbit repository
bash "clone git repo" do
  cwd node['errbit']['install_to']
  code "git clone https://github.com/errbit/errbit.git"
  user "aj"
  group "aj"
end

# Config errbit env 
template "#{node['errbit']['wdir']}/env" do
  source "env.erb"
  variables(params: {
    host: node['errbit']['config']['host'],
	port: node['errbit']['config']['port']
  })
end

# Install gems for errbit
bash "install required gems" do
  cwd node['errbit']['wdir']
  code "bundle install"
end

# Generate initial admin username and password that can be found at /home/aj/errbit/bootstrap.out
bash "bootstrap to create admin user" do
  cwd node['errbit']['wdir']
  code "bundle exec rake errbit:bootstrap > /home/aj/errbit/bootstrap.out"
  user "aj"
  group "aj"
end

# Add systemd service for errbit
template "/etc/systemd/system/errbitaj.service" do
  source "errbitaj.service.erb"
  owner "root"
  group "root"
  mode 0644
end

# Start and enable on boot errbit 
service 'errbitaj.service' do
  action [:enable, :start]
end