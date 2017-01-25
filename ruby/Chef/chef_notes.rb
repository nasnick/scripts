if platform_family?('rhel')

  ruby_block 'Get the hostname returned by hostnamectl' do
    block do
      Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut) 
      command = "hostnamectl | grep 'Static hostname:' | awk '{print $3}'"
      command_out = shell_out(command)
      node.force_default['rhel_hostname'] = command_out.stdout + '.key'
   end
  action :create
 end
end

#-----------------------------------------------------------------
