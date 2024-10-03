---
title: '{{ iam-full-name }} release notes'
description: This section contains {{ iam-name }} release notes.
---

# {{ iam-full-name }} release notes

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## Q1 2024 {#q1-2024}

* Added the [{{ sts-name }}](./concepts/authorization/sts.md) component to get temporary access keys compatible with [AWS S3 API](../storage/s3/index.md). This feature is at the [Preview stage](../overview/concepts/launch-stages.md). {{ tag-cli }} {{ tag-api }}
* Added OAuth client authentication support by authenticating a service account token.
* Added the option of using masked token ID for {{ at-name }} logs.
* Improved the key rotation mechanism in [OpenID Connect](https://openid.net/).
