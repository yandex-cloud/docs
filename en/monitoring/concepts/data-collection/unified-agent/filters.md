# Filters

You can describe a filter in the `routes` section within the `channel`:`pipe`:`filter` element. Alternatively, you can do this in the `pipes` section.

The common filter description format is:

```yaml
- filter:
    plugin: ... # plugin name
    id: ... # (recommended) filter ID, used in metrics and logs
    config: # filter configuration
        ...
```

## assign filter {#assign_filter}

This filter assigns metadata to a session or message.

The metadata value is generated using a template. Template syntax: `{key:format|default}`. Curly brackets are escaped by `\`: `"\{\}"`.

`key` value:

- `_timestamp`: Message timestamp.
- `_payload`: Message body.
- `key`: Metadata with the key named `key`.

If the metadata key is not found at the message level (in the `message` section), a search for the key will be conducted through the session metadata. If the key is not found at the session level, the default value `({_host|default_host})` will be used. If no default value is set, an empty string will be used.

You can also specify the following macros as the `key` value:
- `$host_name`: Local name of the machine.
- `$short_host_name`: Short local name of the machine (up to the first dot).
- `$env('name')`: Environment variable named `name`.
- `$file('name')`: Contents of the file named `name`.

You can substitute the macro arguments from the metadata.
For example, in the case of `$file(name)`, the file name will be taken from the metadata with the `name` key.

The `format` value is a formatting string in [strftime](http://man7.org/linux/man-pages/man3/strftime.3.html) format. It can only be specified for `_timestamp`.

Value: `default`:

- Specifies the default value if there is no metadata with this key or if `_payload` is empty.
- Cannot be specified for `_timestamp` because `_timestamp` is always present.
- Supported for the `$env` and `$file` macros. It is used if the specified file is not found or the environment variable is an empty string.
- An empty string is used by default.

Parameter descriptions:

```yaml
- filter:
    plugin: assign
    config:
        # You must specify at least one of these sections: `message` or `session`.

        # Values to be written to the message metadata.
        # Inside `message`, there must be a list of single-element `map` functions with metadata name for the key and formatting template for the value.
        # The macros enclosed in curly brackets in the template may contain the metadata keys ({_host}) as well as built-in functions ({$file('test-file')}).
        # If the metadata key is not found at the message level (in the `message` section), a search for the key will be conducted through the session metadata.
        # If the key is not found at the session level, the default value `({_host|default_host})` will be used. If no default value is set, an empty string will be used.
        # Below are some such template examples.
        message:  # optional, not set by default
            # Result example: 'Nov 27 21:03:24 test-host test-app:test_payload'.
            # The timestamp uses the strftime format (http://man7.org/linux/man-pages/man3/strftime.3.html).
            # In this example, the _app 'test-app:' value ending with a colon is a typical result of parsing a syslog message.
            - _payload: "{_timestamp:%b %d %H:%M:%S} {_host} {_app}{_payload}"

            # Replacing `$file` with a value from the file named `test-file`.
            # If the contents of `test-file` equals `test-content`, the output will be `prefix_test-content_suffix`.
            - m1: "prefix_{$file('test-file')}_suffix"

            # Substituting a value from the file whose name can be taken from the metadata with the `test-file-name` key.
            - m2: "prefix_{$file(test-file-name)}_suffix"

            # Substituting a value from the `test-env` environment variable.
            - m3: "prefix_{$env('test-env')}_suffix"

            # Substituting a value from the environment variable whose name is taken from the metadata with the `test-env-name` key.
            - m4: "prefix_{$env(test-env-name)}_suffix"

            # Substituting the name of the host where the agent is running.
            - m5: "$host_name"

            # It is similar to `$host_name` but without the domain (prefix up to the first dot).
            # For example, if $host_name equals `lbk-dev-02.search.yandex.net`, then $short_host_name will get the `lbk-dev-02` value.
            - m6: "$short_host_name"

        # Values to be assigned to the session metadata.
        session:  # optional, not set by default
            # Similar to `message`.
            - m1: v1
            - m2: v2
```

## convert_metrics filter {#convert_metrics_filter}

A filter for converting metrics between different formats. The format for input messages is taken from the session metadata with the `_metrics_format` key (if any) or from the message metadata with the same key (if any).

If the incoming message format cannot be identified (`_metrics_format` not specified at session level or message level), the incoming message is discarded and the `RejectedMessages` counter for the plugin increases by one.

Parameter descriptions:

```yaml
- filter:
    plugin: convert_metrics
    config:
        # Output format to convert the incoming set of metrics to.
        # Exactly one of the nested elements must be specified.
        format:  # required
          # Converting to the {{ monitoring-full-name }} JSON format (../../../api-ref/MetricsData/write.md).
          json:
              # Whether to merge metrics with the same set of labels.
              # Possible values: `default` (merging disabled), `merge_metrics` (merging enabled).
              merging_mode: default  # optional, the default value is `default` (merging disabled)

              # Whether to format JSON into a human-readable format (with line breaks and indents).
              # Sets the size of indents. If `0`, no formatting is needed.
              indentation: 0  # optional, formatting is disabled by default

        # Additional labels that need to be added to the output metrics.
        labels:  # optional, not set by default
            l1: v1
            l2: v2

        # The default time value that need to be added to the output metrics.
        # Two syntax formats for these parameters are supported: absolute and relative.
        # In the absolute format, the time value is expected in ISO 8601 format.
        # Examples: 2014-03-25 03:59:56.654563, 2012-11-23 11:12:13, 2012-11-23, 1990-03-15T15:10:12.
        # In the relative format, you must specify an offset from one of the preset values:
        # * now: Current time.
        # * today: Beginning of the current day.
        # * yesterday: Beginning of the day before the current one.
        # * tomorrow: Beginning of the next day.
        # The offset consists of any number of time deltas separated by the + or - operators.
        # Possible delta values:
        # * m: Minute
        # * h: Hour
        # * d: Day
        # * w: Week
        # For example, `--since yesterday` will leave messages for yesterday and today, while `--since now-5m --until now-5m+10s` will leave messages for the 10-second interval that began five minutes ago.
        # By default, deltas are counted from `now` which means you can use `-2m` instead of `now-2m`.
        common_time: null  # optional, not set by default
```

## filter_metrics filter {#filter_metrics_filter}

The filter allows screening out the metrics you are transferring based on label values.

```yaml
- filter:
    plugin: filter_metrics
    config:
        # Condition for the metrics that need to stay. All other metrics will be filtered out.
        match: "{name=gauge-*}"  # required
```

See also the [query syntax description](../../../concepts/querying.md#selectors).

## match filter {#match_filter}

Filtering messages based on metadata: the filter lets through only messages containing all the listed metadata.

Parameter descriptions:

```yaml
- filter:
    plugin: match

    config:
        # Session metadata in `key:value` format.
        session:  # optional
            a: b

        # Message metadata in `key:value` format.
        message:  # optional
            c: d
            e: f

        # In the above configuration, the filter will only let through the messages where:
        # * Session metadata contains the `a` key with the `b` value.
        # * Message metadata contains the `c` key with the `d` value and the `e` key with the `f` value (both are required).
        # The metadata may contain any other keys as well.
```

## transform_metric_label filter {#transform_metric_label_filter}

This filter allows you to rename the metric label or add a prefix to it.

Parameter descriptions:
```yaml
- filter:
    plugin: transform_metric_label
    config:
        # Name of the label that needs to be transformed.
        label: name  # required

        # Adding a prefix to the label value.
        add_value_prefix: ua  # optional

        # Renaming a label.
        rename_to: second_name  # optional

        # Separator that should be used between the prefix you are adding and the current label value.
        delimiter: .  # optional, the default value is `.`
```

## transform_metric_labels filter {#transform_metric_labels_filter}

This filter allows you to add new labels to metrics as well as to delete and replace the existing ones. A label value can be represented by a fixed string or a text expression that uses other labels. You can use the `match` expression to limit the collection of metrics the transformation applies to.

Parameter descriptions:
```yaml
- filter:
    plugin: transform_metric_labels

    config:
      # Limiting the filter to metrics that satisfy a given condition.
      match: "{name=gauge-*}"  # optional, not set by default, the filter applies to all metrics

      # Description of label transformations in "label name: expression" format.
      # Label name: Label that gets a new value.
      # Expression: Text string describing the new value.
      # In this string, you can use the `{my_label}` syntax to refer to current label values,
      # including the label currently modified. This reference will use its previous value.
      # Transformations take place in a specified order; in the expressions that follow,
      # you can reference the output of the previous ones.
      # Expression syntax is similar to the one used in the `assign` filter.
      # Using `{my_label|default_value}`, you can specify a default value if `my_label` is not found.
      # To delete a label, use this syntax: my_label: "-".
      labels:
        - l2: "prefix_{l1}_suffix"                # required
        - l3: "prefix2_{l2}_s_{l1|default_value}" # required
        - l4: "-" # required
```

See also the [query syntax description](../../../concepts/querying.md#selectors).