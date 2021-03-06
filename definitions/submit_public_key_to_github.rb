define :submit_public_key_to_github, :user => nil, :home => nil, :key_path => nil, :github_user => nil, :github_password => nil do
  home               = params[:home] || "/home/#{username}"
  key_name           = params[:key_name] || "#{params[:user]}@#{node[:hostname]}"
  key_path           = params[:key_path] || "#{home}/.ssh/id_rsa.pub"
  github_user        = params[:github_user] || node[:ssh_keys][:github][:user]
  github_password    = params[:github_password] || node[:ssh_keys][:github][:password]
  github_oauth_token = params[:github_oauth_token] || node[:ssh_keys][:github][:oauth_token]

  raise ":user is required" unless params[:user]
  raise ":github_oauth_token or pair of :github_user and :github_password is required" unless github_oauth_token || (github_user && github_password)

  package "curl" do
    action :install
  end

  ssh_known_hosts_entry 'github.com'

  bash "github_public_key" do
    if github_oauth_token
      code <<-EOH
        KEY=`cat #{key_path}`
        JSON="{\\"title\\": \\"#{key_name}\\", \\"key\\": \\"${KEY}\\"}"
        curl -f -i -H "Authorization: token #{github_oauth_token}" -d "${JSON}" https://api.github.com/user/keys
      EOH
      not_if "curl -i -H \"Authorization: token #{github_oauth_token}\" https://api.github.com/user/keys | grep '\"title\": \"#{key_name}\"'"
    else
      code <<-EOH
        KEY=`cat #{key_path}`
        JSON="{\\"title\\": \\"#{key_name}\\", \\"key\\": \\"${KEY}\\"}"
        curl -f -i -u "#{github_user}:#{github_password}" -d "${JSON}" https://api.github.com/user/keys
      EOH
      not_if "curl -i -u \"#{github_user}:#{github_password}\" https://api.github.com/user/keys | grep '\"title\": \"#{key_name}\"'"
    end

    subscribes :run, resources("execute[generate_ssh_keys_for_#{params[:user]}]")
  end

  cookbook_file "#{home}/.ssh/config" do
    cookbook "github_ssh_keys"
    source "github_ssh_config"
    action :create_if_missing
    owner params[:user]
    mode 00600
  end
end
