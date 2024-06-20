# Filters

You can describe a filter in the `routes` section within the `channel`:`pipe`:`filter` element. Alternatively, you can do this in the `pipes` section.

The common filter description format is:

```yaml
- filter:
    plugin: ... # plugin name
    id: ... # (recommended) filter ID, which is used in metrics and logs
    config: # filter configuration
        ...
```

## assign filter {#assign_filter}

This filter assigns metadata to a session or message.

The metadata value is generated using a template. Template syntax: `{key:format|default}`. Curly brackets are escaped by `\`: `"\{\}"`.

The `key` value:

- `_timestamp`: Message timestamp.
- `_payload`: Message body.
- `key`: Metadata with the `key` key.

If the metadata key is not found at the message level (in the `message` section), a search for the key will be conducted through the session metadata. If the key is not found at the session level, the default value `({_host|default_host})` will be used. If no default value is set, an empty string will be used.

You can also specify the following macros as the `key` value:
- `$host_name`: Local name of the machine.
- `$short_host_name`: Short local name of the machine (up to the first dot).
- `$env('name')`: Environment variable named `name`.
- `$file('name')`: Contents of the file named `name`.

The macro's arguments can be substituted from the metadata.
For example, in the case of `$file(name)`, the file name will be taken from the metadata with the `name` key.

The `format` value is a formatting string in [strftime](http://man7.org/linux/man-pages/man3/strftime.3.html) format. It can only be specified for `_timestamp`.

The `default` value:

- Specifies the default value if there is no metadata with this key or `_payload` is empty.
- Cannot be specified for `_timestamp` because `_timestamp` is always present.
- Supported for the `$env` and `$file` macros. It is used if the specified file is not found or the environment variable is an empty string.
- An empty string is used by default.

Parameter descriptions:

```yaml
- filter:
    plugin: assign
    config:
        # At least one of the message or session sections must be specified.

        # Values to be written to the message metadata.
        # Inside the message there must be a list of single-element map functions with metadata name for the key and formatting template for the value.
        # The macros enclosed in curly brackets in the template may contain the metadata keys ({_host}) as well as built-in functions ({$file('test-file')}).
        # If the metadata key is not found at the message level (in the message section), a search for the key will be conducted through the session metadata.
        # If the key is not found at the session level, the default value, `({_host|default_host})`, will be used. If no default value is set, an empty string will be used.
        # Below are some template examples.
        message: # optional, not set by default
            # Output example: 'Nov 27 21:03:24 test-host test-app:test_payload'.
            # The timestamp uses the strftime format (http://man7.org/linux/man-pages/man3/strftime.3.html).
            # In this example, the value _app test-app: has a colon at the end, which is a typical result of parsing a syslog message.
            - _payload: "{_timestamp:%b %d %H:%M:%S} {_host} {_app}{_payload}"

            # Replace $file with the value from the file named test-file.
            # If the contents of the test-file file is test-content, the output is prefix_test-content_suffix.
            - m1: "prefix_{$file('test-file')}_suffix"

            # Substitute a value from the file whose name can be taken from the metadata with the test-file-name key.
            - m2: "prefix_{$file(test-file-name)}_suffix"

            # Substitute the value from the test-env environment variable.
            - m3: "prefix_{$env('test-env')}_suffix"

            # Substitute the value from the environment variable whose name can be taken from the metadata with the test-env-name key.
            - m4: "prefix_{$env(test-env-name)}_suffix"

            # Substitute the name of the host the agent is running on.
            - m5: "$host_name"

            # Same as for $host_name but without the domain (prefix up to the first dot).
            # For example, if $host_name is lbk-dev-02.search.yandex.net, then $short_host_name becomes lbk-dev-02.
            - m6: "$short_host_name"

        # Values to be assigned to the session metadata.
        session: # optional, not set by default
            # Similar to message.
            - m1: v1
            - m2: v2
```

## convert_metrics filter {#convert_metrics_filter}

A filter for converting metrics between different formats. The format for input messages is taken from the session metadata with the `_metrics_format` key (if any) or from the message metadata with the same key (if any).

If the format of an incoming message cannot be identified (`_metrics_format` is not specified at the session level or the message level), the incoming message is discarded and the `RejectedMessages` counter for the plugin increases by 1.

Parameter descriptions:

```yaml
- filter:
    plugin: convert_metrics
    config:
        # The output format to convert the incoming set of metrics to.
        # Exactly one of the nested elements must be specified.
        format: # required
          # Convert to JSON {{ monitoring-full-name }} (../../../api-ref/MetricsData/write.md)
          json:
              # Determines whether to merge metrics with the same tags.
              # Possible values: default (merging disabled), merge_metrics (merging enabled).
              merging_mode: default # optional, the default value is *default* (merging disabled)

              # Determines whether to format JSON in a human-readable format (with line breaks and idents).
              # Sets the size of indents. If 0, no formatting is needed.
              indentation: 0 # optional, formatting is disabled by default

        # A set of labels to be added to the output set of metrics.
        labels: # optional, not specified by default
            l1: v1
            l2: v2

        # The default time value to be added to the output set of metrics.
        # Two syntax formats for these parameters are supported: absolute and relative.
        # In the absolute format, the time value is expected in the ISO 8601 format.
        # Examples: 2014-03-25 03:59:56.654563, 2012-11-23 11:12:13, 2012-11-23, 1990-03-15T15:10:12.
        # In the relative format, an offset from a preset value must be specified:
        # * now: Current time.
        # * today: The beginning of today.
        # * yesterday: The beginning of yesterday.
        # * tomorrow: The beginning of tomorrow.
        # The offset includes an arbitrary number of time deltas separated by the + or - operators.
        # Possible values for the delta:
        # * m: Minute.
        # * h: Hour.
        # * d: Day.
        # * w: Week.
        # For example, --since yesterday leaves messages for yesterday and today, while --since now-5m --until now-5m+10s leaves messages in the interval of 10 seconds that began five minutes ago.
        # By default, deltas are counted from now. That means you can use -2m instead of now-2m.
        common_time: null # optional, not set by default
```

## filter_metrics filter {#filter_metrics_filter}

The filter allows screening out the metrics you are transferring based on label values.

```yaml
- filter:
    plugin: filter_metrics
    config:
        # Condition for the metrics you want to keep. All other metrics will be filtered out.
        match: "{name=gauge-*}" # required
```

See also the [query syntax description](../../../concepts/querying.md#selectors).

## match filter {#match_filter}

Filtering messages based on metadata: the filter lets through only messages containing all listed metadata.

Parameter descriptions:

```yaml
- filter:
    plugin: match

    config:
        # Session metadata in the key:value format.
        session: # optional
            a: b

        # Message metadata in the key:value format.
        message: # optional
            c: d
            e: f

        # In the above configuration, the filter lets through only messages where:
        # * Session metadata contains the "a" key with the "b" value.
        # * Message metadata contains the "c" key with the "d" value and the "e" key with the "f" value (must contain both).
        # The metadata may also contain any other keys.
```

## transform_metric_label filter {#transform_metric_label_filter}

The filter helps add new labels to metrics, as well as delete and replace existing labels. A label value can be a string literal or a text expression with other labels. You can use the `match` expression to limit the collection of metrics the transformation is applied to.

Parameter descriptions:
```yaml
- filter:
    plugin: transform_metric_labels

    config:
      # The filter will only apply to those metrics that meet this condition.
      match: "{name=gauge-*}" # optional parameter, not specified by default, filter applies to all metrics

      # Description of label transformations in "label name: expression" format.
      # Label name: label that is being assigned a new value.
      # Expression: text string describing the new value.
      # This string can refer to current label values using the "{my_label}" syntax,
      # including the label being modified at that moment in time. This reference will use its previous value.
      # Transformations take place in a specified order; in the expressions that follow
      # you can reference the output of the previous ones.
      # Expression syntax is similar to that used in the assign filter.
      # Using {my_label|default_value}, you can specify a default value if my_label is not found.
      # To delete a label, use my_label: "-".
      labels:
        - l2: "prefix_{l1}_suffix"                # required
        - l3: "prefix2_{l2}_s_{l1|default_value}" # required
        - l4: "-" # required
```

See also the [query syntax description](../../../concepts/querying.md#selectors).
