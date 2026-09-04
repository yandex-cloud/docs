---
title: Public API versioning in {{ datalens-full-name }}
description: Public API versioning in {{ datalens-full-name }} ensures compatibility of methods and object schemas between the API and the interface.
---
# Public API versioning in {{ datalens-full-name }}

As the Public API in {{ datalens-name }} evolves, its methods, their arguments, and object schemas, e.g., dashboard, chart, or dataset schemas, may change.

These changes may be either non-breaking or breaking:

* Adding new fields is a non-breaking change.
* Removing or renaming fields, modifying schema structure, or removing methods constitute breaking changes.

With each breaking change, a [new Public API version](../release-notes/api-changelog.md) is created and the API version number is incremented by one. If multiple breaking changes are introduced to methods or object schemas at once, the API version is still incremented by one.

The version number is provided in the `X-DL-API-Version` request header. To specify the latest version available at the moment, provide `latest` in the header.

The previous Public API version remains supported for some time after a new release to give users time to migrate to the new version.

The {{ datalens-name }} interface only supports the latest version of schemas. As a result, all objects modified via the interface are automatically saved under the latest version. Attempts to access such objects using an older Public API version will fail and return an error.

{% note info %}

Regularly update your Public API to ensure correct operation.

{% endnote %}

## Example of a non-breaking change {#non-breaking-change}

Added a field for providing a description to the report creation method:

Previously:

```bash
X-DL-API-Version: 1
POST {{ api-host-datalens }}/rpc/createReport {key, config}
```

Now:

```bash
X-DL-API-Version: 1
POST {{ api-host-datalens }}/rpc/createReport {key, config, description}
```

Reports created before this update will be converted, and the new field will be populated with a default value.

## Example of a breaking change {#breaking-change}

Removed the `key` argument from the report creation method and replaced it with `workbookId`.

Previously:

```bash
X-DL-API-Version: 1
POST {{ api-host-datalens }}/rpc/createReport {key, config}
```

Now:

```bash
X-DL-API-Version: 2
POST {{ api-host-datalens }}/rpc/createReport {workbookId, config}
```

You can use the legacy method behavior while the previous API version is still supported. To do this, specify the required version in the header:

```bash
X-DL-API-Version: 1
POST {{ api-host-datalens }}/rpc/createReport {key, config}
```


## Viewing the legacy version in Swagger {#swagger-versions}

During the transition period, you can view the legacy API version in Swagger. To do this, specify the version number in the link:

   > `{{ api-host-datalens }}/<version_number>`


