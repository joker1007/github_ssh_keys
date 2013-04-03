# github\_ssh\_keys cookbook

# Requirements
ssh\_known\_hosts cookbook

# Install
Write Berksfile
```ruby
cookbook "github_ssh_keys", git: "git://github.com/joker1007/github_ssh_keys.git"
```

# Usage
```ruby
# Submit /home/joker1007/.ssh/id_rsa.pub to github
submit_public_key_to_github "joker1007" do
  user "joker1007"
  github_user "joker1007"
  github_password "github_password"
end

# or

# Submit /var/github/publickey to github
submit_public_key_to_github "joker1007" do
  key_path "/var/github/publickey"
end
```

# Attributes

| attributes                          | description           |
| ---------------------------------   | --------------------- |
| node[:ssh_keys][:github][:user]     | github user account   |
| node[:ssh_keys][:github][:password] | github password       |

# Recipes

# Author

Author:: joker1007
