#
# Cookbook Name:: app_php
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

rightscale_marker

log "  Setting provider specific settings for php application server."
node[:app][:provider] = "app_php"
node[:app][:version] = "5.4"
log "  Setting php application server version to 5.3."

# Setting generic app attributes
case node[:platform]
when "ubuntu"
  node[:app][:user] = "www-data"
  node[:app][:group] = "www-data"
  node[:app][:packages] = [
    "php5",
    "php-pear",
    "libapache2-mod-php5"
  ]
when "centos", "redhat"
  node[:app][:user] = "apache"
  node[:app][:group] = "apache"
  node[:app][:packages] = [
    "php54u",
    "php54u-pear",
    "php54u-zts",
    "php54u-xml"
  ]
end

# Sets required apache modules.
node[:app_php][:module_dependencies] = value_for_platform(
  "ubuntu" => {
    "default" => ["proxy_http", "php5"]
  },
  "default" => ["proxy", "proxy_http"]
)
