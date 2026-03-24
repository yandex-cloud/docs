---
title: Query language
description: Reference for the query language to search for traces and spans in {{ traces-name }}.
---

# Query language

The {{ traces-name }} query language allows you to filter traces and spans by attributes. Queries should be entered into the search bar on the [{#T}](traces-explorer.md) page. The interface supports autocompletion: start typing the attribute's name and the system will suggest the available options. Then start typing the value, and autocompletion will work for it too.

## Syntax {#syntax}

A query consists of key-value pairs enclosed in curly braces:

```
{ key="value", key="value", ... }
```

Conditions inside a query are joined using the **AND** logic, i.e., the result must satisfy all conditions at the same time.

Here is an example:

```
{ project="folder__b1g86q4m5vej********", service="api-gateway", span.duration>=1s }
```

This query will return traces (or spans) which, at the same time:
* Belong to the `folder__b1g86q4m5vej********` project.
* Belong to `api-gateway`.
* Contain at least one span of one second or longer.

## Supported keys {#keys}

### System keys {#system-keys}

* `project`: Project (folder) name. This is a required key.
* `cluster`: Environment, e.g., `production` or `staging`.
* `service`: Service or application name.

### Span attributes {#span-attributes}

In addition to system keys, you can search by span attributes. Some attributes are standard:

* `span.name`: Span name.
* `span.kind`: Span type, i.e., `server`, `client`, `producer`, `consumer`, or `internal`.
* `span.status`: Span status, i.e., `OK`, `ERROR`, or `UNSET`.
* `span.duration`: Span duration.

You can also search by any attributes that were added during instrumentation. Attributes are specified directly by name:

```
{ project="folder__b1g86q4m5vej********", http.method="GET", http.status_code=200 }
```

## Operators {#operators}

### String operators {#string-operators}

#|
|| Operator | Description | Example ||
|| `=` | Exact match or glob template. | `service="api-*"`: Services starting with `api-` ||
|| `!=` | Not equal to (supports glob). | `service!="test-*"`: All services except those starting with `test-` ||
|| `==` | Exact match without glob | `span.name=="GET /users"`: Exact match only ||
|| `!==` | Not equal to (without glob) | `span.name!=="GET /users"` ||
|| `=~` | Regular expression ([re2](https://github.com/google/re2/wiki/Syntax)) | `span.name=~"GET /users/[0-9]+"` ||
|| `!~` | Does not match regular expression | `span.name!~"POST.*"` ||
|#

### Comparison operators {#comparison-operators}

For numeric values and duration:

#|
|| Operator | Description | Example ||
|| `>` | Greater than | `span.duration>500ms` ||
|| `>=` | Greater than or equal to | `span.duration>=1s` ||
|| `<` | Less than | `span.duration<100ms` ||
|| `<=` | Less than or equal to | `span.duration<=2s` ||
|#

### Duration operators {#duration-operators}

The duration is specified with units of measurement:

* `ms`, milliseconds
* `s`, seconds
* `m`, minutes
* `h`, hours

Here are some examples:

```
{ span.duration>=500ms }
{ span.duration<2s }
{ span.duration>=1m }
```

### Special selectors {#special-selectors}

#|
|| Selector | Description | Example ||
|| `*` | Any value (attribute is present) | `http.method="*"`: All spans with the `http.method` attribute ||
|| `-` | No attribute | `http.method="-"`: Spans without the `http.method` attribute ||
|| `\|` | One out of several values (OR) | `span.kind="client\|server"`: Spans of the `client` or `server` type. ||
|#

## Query examples {#examples}

Finding traces from `api-gateway`:

```
{ project="folder__b1g86q4m5vej********", service="api-gateway" }
```

Finding traces from the production environment, except for test services:

```
{ project="folder__b1g86q4m5vej********", cluster="production", service!="test-*" }
```

Finding spans with the ERROR status:

```
{ project="folder__b1g86q4m5vej********", span.status="ERROR" }
```

Finding slow HTTP queries to a specific endpoint:

```
{ project="folder__b1g86q4m5vej********", service="api-gateway", http.route="/users/:id", span.duration>=500ms }
```

Finding errors in database queries:

```
{ project="folder__b1g86q4m5vej********", db.system="postgresql", span.status="ERROR" }
```

Finding client and server spans:

```
{ project="folder__b1g86q4m5vej********", span.kind="client|server" }
```

Finding spans with retries:

```
{ project="folder__b1g86q4m5vej********", http.resend_count="*" }
```
