# The Whale Museum API's

A Ruby gem for interacting with [The Whale Museum](http://whalemuseum.org) API's.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twm-ruby'
```

## Usage

Currently only the [Whale Hotline API](http://hotline.whalemuseum.org/api) is supported. There is no authentication required, however usage of the API requires that The Whale Museum receive full acknowledgment as the data source through citation where the data is used.

```ruby
require 'twm-ruby'

twm = TWM::API.new

total_count = twm.hotline.count
=> 17829

sightings = twm.hotline.search(limit: 1000)
=> [...]

orca_count = twm.hotline.count(species: 'orca')
=> 17179

pages = (orca_count.to_f/1000.to_f).ceil
orca_sightings = []
1.upto(pages) do |page|
  orca_sightings.concat twm.hotline.search(limit: 1000, page: page)
end

orca_sightings.first['id']
=> "52c4a6da686f741c25000000"

sighting = twm.hotline.find("52c4a6da686f741c25000000")
sighting['species']
=> 'orca'

```