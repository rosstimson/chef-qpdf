# Encoding: utf-8
#
# Cookbook Name:: qpdf
# Recipe:: default
#
# Copyright 2014, Ross Timson
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Installation of build dependencies may fail unless package index files are
# up to date.

# chef-sugar makes it easier to target certain platform versions - the runtime
# lib name changes a lot.
include_recipe 'chef-sugar'

case node['platform_family']
when 'debian'
  include_recipe 'apt'
when 'rhel'
  include_recipe 'yum'
end

if platform_family?('rhel')
  yum_repository 'epel' do
    description 'Extra Packages for Enterprise Linux'
    mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch'
    gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
    action :create
  end
end

packages = case
           when amazon_linux?
             %w( qpdf qpdf-libs qpdf-devel )
           when centos?
             %w( qpdf qpdf-libs qpdf-devel )
           when ubuntu_after_saucy?
             %w( qpdf libqpdf13 libqpdf-dev )
           when ubuntu_after_precise?
             %w( qpdf libqpdf10 libqpdf-dev )
           else
             %w( qpdf libqpdf3 libqpdf-dev )
           end

packages.each do |name|
  package name
end
