# suggestionbot

Discord bot that "replaces" text using regex.

## Installation

```
shards install
crystal build src/suggestionbot.cr --release
```

Edit settings.json, adding your token/clientid

## Usage

```
./suggestionbot
```

In discord, message the bot the following to add regexes:

``--regex--replacement\_string``

or, change command_regex in settings.json, group 1 being the regex and group 2 the replacement text.

## Contributing

1. Fork it (<https://github.com/Jordan-Ross/suggestionbot/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Jordan-Ross](https://github.com/Jordan-Ross) Jordan Ross - creator, maintainer
