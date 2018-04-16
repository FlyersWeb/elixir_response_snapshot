## Disclaimer

This is in development. A version 1.0 will mark the public release.

# ResponseSnapshot

ResponseSnapshot is a testing tool for Elixir that captures the output of responses
and ensures that they do not change in between test runs. The output is saved to disk,
meant to be checked into source control. This output can be used by frontend and other tests
to ensure proper integration between frontend and backend code, or to ensure that endpoint
responses do not change over time.

## Usage

The most basic is a simple call to store_and_compare! as such:

```
  response_json
    |> store_and_compare!(path: "test/location/i/want/output.json")
```

This will cause the output to be written to disk the first time, and then compared
using exact match in all future tests.

## Options

* path - The path of the fixture on disk
* mode - The comparison mode of the diff algorithm. Values must be: :exact, :keys
* ignored_keys - Keys to ignore during comparison. Can be exact or wildcard matches

## Comparison Modes

The `store_and_compare!` interface has 2 different modes, exact and keys. The `:exact`
mode is default and requires both key and value of the comparison to match the stored
snapshot. The `:keys` mode requires only the keys of the comparison to match the stored
snapshot. This can be useful in testing that the shape of an endpoint doesn't change
over time, without worrying about the test input.

## Ignored Keys

It is possible to ignore keys that will change between test runs. This is most common
for dynamic fields such as ids, timestamps, etc. Ignored keys can be done via an exact
string comparison, or a wildcard-like implementation.

```
  response_json
    |> store_and_compare!(path: path, ignored_keys: ["exact.example", {"partial", :any_nesting}])
```

The exact.example key requires that the shape of the JSON is exact -> key. The partial key
allows for matches such as "partial", "partial.nested", or "nested.partial".

## TODO

- [x] Setup desired testing interface
- [ ] Setup application option defaults
- [x] Compare JSON responses deeply
  - [x] value change doesn't fail mode (new / missing keys will fail)
  - [x] exact value mode (new / missing keys, changed values will fail)
- [x] Ignored keys
  - [ ] Ignore key should only ignore modifications because addition/removal is contract breakage
- [ ] Compare HTML responses at face value
- [x] Fail tests with helpful message on failure
- [ ] Allow re-recording of a snapshot with a switch passed to the test suite

## Installation

WIP
