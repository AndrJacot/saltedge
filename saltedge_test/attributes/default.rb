#
# Cookbook:: saltedge_test
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

default['errbit']['name']         = "errbit"
default['errbit']['user']         = "aj"
default['errbit']['password']     = "8a$7OjvSFw3LCK0oPFR2WzT6vuwusujpZFa7OZu8FLSBpp2NEtSP1cZxXVtfRHbzZKf.NIkXS7TGgSHKqXgSv3o40"
default['errbit']['group']        = node['errbit']['user']
default['errbit']['install_to']   = "/home/aj"
default['errbit']['wdir']         = "/home/aj/errbit"
default['errbit']['repo_url']     = "https://repo.mongodb.org/apt/debian"
default['errbit']['repo_dist']    = "buster/mongodb-org/4.4"
default['errbit']['repo_key']     = "https://www.mongodb.org/static/pgp/server-4.4.asc"
default['errbit']['revision']     = "master"
# errbit env vars
default['errbit']['config']['host']                               = "127.0.0.1"
default['errbit']['config']['port']                               = "8989"