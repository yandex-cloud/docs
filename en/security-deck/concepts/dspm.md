---
title: Data Security Posture Management in {{ sd-full-name }}
description: Data Security Posture Management (DSPM) is a {{ sd-name }} module that helps detect sensitive information stored in {{ objstorage-full-name }} buckets, as well as assess its impact on security posture and compliance with regulations and industry standards.
---

# Data Security Posture Management (DSPM)

[Data Security Posture Management, or DSPM]({{ link-sd-main }}dspm/), is a tool that helps to quickly detect sensitive information stored in {{ objstorage-full-name }} [buckets](../../storage/concepts/bucket.md) and take timely action to protect it against unauthorized access or leaks (configure [access policies](../../storage/concepts/policy.md), anonymize data, etc.).

With proper integration, DSPM can work in leak prevention mode, blocking the sharing or saving of confidential information.

## Scanning for sensitive information {#scanning}

DSPM scans _data sources_ to identify sensitive information in buckets.

Before you start scanning, select a data source and specify the _data categories_ to search for. 

### Data source {#data-source}

A data source contains information on the bucket to scan, along with additional settings.

For example, you can set the scan scope for a data source, `All files` or `Files by template`. If you select `Files by template`, you can use [regular expressions](https://en.wikipedia.org/wiki/Regular_expression) to set the criteria which the names of the files to scan must or must not match.

You can create multiple data sources for a single bucket, each with its own scan scope settings.

### Data categories {#data-categories}

When setting up a new scan, you can specify the category of data to search for. You can select all the available categories at once or any of them separately.

Data categories available for scanning:

* `Personal data`: Full names, phone numbers, email addresses, document numbers, IP addresses, etc.
* `Secrets`: Cloud access keys, passwords, tokens, SSH keys, etc.

To create data sources, set up and run scans, and view scan results, the user must have the appropriate [roles](../security/index.md).

#### See also {#see-also}

* [{#T}](../operations/dspm/create-data-source.md)
* [{#T}](../operations/dspm/create-scan.md)