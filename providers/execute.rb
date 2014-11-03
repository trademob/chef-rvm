include Chef::Cookbook::RVM::EnvironmentFactory
use_inline_resources
def load_current_resource
  true
end

def whyrun_supported?
  true
end

action :do do
  converge_by("Execute: rvm #{new_resource.ruby_string} do #{new_resource.command}") do
    env.rvm(Array(new_resource.ruby_string).join(','), :do, new_resource.command)
    new_resource.updated_by_last_action(true)
    Chef::Log.info("#{@new_resource} ran successfully")
  end
end

action :in do
  converge_by("Execute: rvm in #{new_resource.path} do #{new_resource.command}") do
    env.rvm(:in, new_resource.path, :do, new_resource.command)
    new_resource.updated_by_last_action(true)
  end
end
