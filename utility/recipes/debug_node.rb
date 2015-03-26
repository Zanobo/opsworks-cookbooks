include_recipe "deploy"

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  template "#{deploy[:deploy_to]}/shared/config/debug.txt" do
    source "debug.erb"
    cookbook 'rails'
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables(:node => node)

    only_if do
      File.directory?("#{deploy[:deploy_to]}/shared/config/")
    end
  end

end