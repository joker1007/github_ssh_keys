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
  user "joker1007"
  github_user "joker1007"
  key_path "/var/github/publickey"
end
```

# Attributes
| attributes                    | description                                        |
| -----------------             | --------------                                     |
| user                          | username, used submit key title and home directory |
| home (optional)               | home directory path, used key_path base            |
| key_path (optional)           | absolute path for submit key                       |
| github_user                   | github username                                    |
| github_password (optional)    | github password                                    |
| github_oauth_token (optional) | github oauth token                                 |

# Node attributes
| attributes                             | description                     |
| ---------------------------------      | ---------------------           |
| node[:ssh_keys][:github][:user]        | as github_user parameter        |
| node[:ssh_keys][:github][:password]    | as github_password parameter    |
| node[:ssh_keys][:github][:oauth_token] | as github_oauth_token parameter |

# Recipes

# Author

Author:: joker1007
