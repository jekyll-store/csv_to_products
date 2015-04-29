# CSV to Products

[![Build Status](https://travis-ci.org/jekyll-store/csv_to_products.svg?branch=master)](https://travis-ci.org/jekyll-store/csv_to_products)

A command line tool for parsing a csv of product data into markdown files with front matter suitable for use with [Jekyll-Store Front](https://github.com/jekyll-store/front).

## Usage

To install:

```
$ gem install csv_to_products
```

To parse:

```
$ csv_to_products my-products.csv my-products-folder
```

If the arguments are missing, it will try to parse `products.csv` into the `_products` folder.

Each product must have a unique name and a numeric price.

## Collection

Any field name of the form `collection[Member]` with be treated as a collection. For example a csv with fields like this,

| available_sizes[Small] | available_sizes[Medium] | available_sizes[Large] |
| ---------------------- | ----------------------- | ---------------------- |
| y                      | n                       | y                      |

Will be collected into the front matter as:

```yaml
available_sizes: Small Large
```

All values will be treated as false, except for: `y`, `Y`, `1`, `true`, `yes`, and `Yes`.

## Contributing

1. [Fork it](https://github.com/jekyll-store/csv_to_products/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request