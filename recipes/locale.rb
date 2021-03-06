#
# Cookbook Name:: platformstack
# Recipe:: locale
#
# Author:: Matthew Thode <matt.thode@rackspace.com>
#
# Copyright 2014. Rackspace, US Inc.
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

unless node['virtualization']['systems']['lxc'] == 'guest'
  case node['platform_family']
  when 'debian'
    execute 'fix_locale' do
      command "/usr/sbin/update-locale LANG=#{node['platformstack']['locale']}"
      user 'root'
      action 'run'
    end
  when 'redhat'
    template '/etc/sysconfig/i18n' do
      source 'centos-locale.erb'
      owner 'root'
      group 'root'
      mode '00644'
      variables(
        cookbook_name: cookbook_name
      )
      action 'create'
    end
  end
end
