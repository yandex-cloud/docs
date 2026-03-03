# Log annotation recommendations

This section provides recommendations for using fields and attributes to optimally structure logs for enhanced visualization and system performance.

## Nesting and namespaces {#nesting-namespaces}

The {{ monium-name }} data model does not support nesting, yet you may need to group related attributes.

To address this, follow these rules:

* Key must consist of one or more components separated by dots.
* All components must be lowercase.
* Final component is the name, and all the preceding ones are namespaces.
* Namespaces can be nested.
* Namespace cannot be a key (e.g., if your data contains a `my.namespace.something` key, do not use `my.namespace` as a separate key).

Here are some examples of key names:

```
request.auth.login
request.auth.type
request.method
request.path
stacktrace
```

For additional guidance on key naming, refer to [this OpenTelemetry guide](https://opentelemetry.io/docs/specs/semconv/general/attribute-naming/).

Beyond improving attribute grouping in visualizations, this approach enhances autocomplete functionality. To avoid memorizing the entire attribute key, start typing its namespaces, and the system will suggest matching keys. In the above example, typing `request.` will display all available keys: `request.auth.login`, `request.auth.type`, etc. 

## Labels and metadata {#labels_vs_meta}

In the {{ monium-name }} data model, there are two types of attributes: _labels_ and _meta_.

When choosing between [labels](../../concepts/data-model.md#labels) and [meta](../../concepts/data-model.md#meta), keep in mind that requirements to labels are stricter.

When constraints are violated, labels are automatically moved to metadata. This may cause confusion when writing labels with uncontrolled data, as the same attribute may be duplicated in both labels and metadata, which complicates data search.

Labels are not intended for high-cardinality data (e.g., request IDs, random values, or noise). Including such attributes in labels slows down query performance and may violate {{ monium-name }} limits on the number of unique label values.

### How to choose between a label and metadata {#selection-rules}

You should store an attribute as a label only if all of the following is true:

* You intend to filter data by the attribute's value (such filtering solves a specific task).
* Filtering will minimize the number of log lines you need to review.
* This attribute has a unique value or is closely related to other attributes, i.e., attributes within the same namespace should be stored as labels.
* Attribute's possible values respect the [constraints](../../concepts/data-model.md#labels) on label names and values.
* This attribute has finite unique values.

{% include [labels-vs-meta](../../../_includes/monium/labels-vs-meta.md) %}