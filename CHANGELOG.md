# Changelog

## Digital Token 0.3.0

This is the changelog for Digital Token version 0.3.0 released on May 14th, 2022.  For older changelogs please consult the release tag on [GitHub](https://github.com/kipcole9/digital_token/tags)

### Enhancements

* Add `DigitalToken.short_name/1` to return the short name of the digital token. This is analagous to the currency code for a currency.

* Add `DigitalToken.long_name/1` to return the long name of the digital token. This is analagous to the name of a currency.

* Add `DigitalToken.symbol/2` to return a "currency" symbol for a digital token that will be used for number formatting in [ex_cldr_numbers](https://github.com/elixir-cldr/cldr_numbers) and [ex_money](https://github.com/kipcole9/money).

## Digital Token 0.2.0

This is the changelog for Digital Token version 0.2.0 released on May 9th, 2022.  For older changelogs please consult the release tag on [GitHub](https://github.com/kipcole9/digital_token/tags)

### Bug Fixes

* Return only the token id from `DigitalToken.validate_token/1` when the argument is already a valid token identifier.

## Digital Token 0.1.0

This is the changelog for Digital Token version 0.1.0 released on May 8th, 2022.  For older changelogs please consult the release tag on [GitHub](https://github.com/kipcole9/digital_token/tags)

### Enhancements

* Initial release
