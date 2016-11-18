# lita-cluster

This is the extension for lita two-node HA.   
Two nodes works as hot-standby mode.  
The node which started first will serve, and second one stays in stand-by mode, and check the status of first node through HTTP API.  
Once the first node is down, second node will start serving instantly.
 
## Installation

Add lita-cluster to your Lita plugin's gemspec:

``` ruby
spec.add_runtime_dependency "lita-cluster"
```

## Usage

Add the following into lita_config.rb
```ruby
require 'lita-cluster'
```

## Confgiuration

This extension looks at lita_config.rb for the following items:
```ruby
$hipchat = {
  'hipchat_token' => '*******',
  'hipchat_endpoint' => 'https://*******.hipchat.com',
  'hipchat_user' => 'username@that.com'
}
```
So make ensure they are configured before starting the lita BOT.
