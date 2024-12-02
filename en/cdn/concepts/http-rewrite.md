---
title: Redirecting content requests
description: This section describes the CDN resource option which allows you to modify the paths of requests from the CDN resource to an origin using _rewrite_ rules.
---

# Redirecting requests

You can [customize redirection](../operations/resources/setup-http-rewrite.md) of requests from a [CDN resource](./resource.md) to an origin by changing the [URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) of the request using a `Rewrite` [rule](#rewrite-rule).

For example, you can use this option to reconfigure content request paths if the file and folder structure of the [origin](./origins.md) has changed. You can also use redirection if you want to keep search engine rankings of your content when moving your resource to a new address.

You can enable request redirection for a CDN resource using the [management console]({{ link-console-main }}), [CLI](../../cli/cli-ref/cdn/cli-ref/resource/update.md), or [API](../api-ref/Resource/update.md).

To configure request redirection, you need to set a [rewrite rule](#rewrite-rule) and specify a [flag](#flag).

For more information about redirecting requests, see the documentation of the EdgeCenter CDN provider:
* [Rewrite. Configuring request redirection](https://edgecenter.ru/knowledge-base/cdn/cdn-rewrite?c=17)
* [API documentation](https://apidocs.edgecenter.ru/cdn#tag/Resources/operation/change_cdn_resource)

## Rewrite rule {#rewrite-rule}

A rewrite rule must contain two space-separated directives:

* **Source path**: URI part to replace. It is specified as a [regular expression](https://en.wikipedia.org/wiki/Regular_expression).

    Regular expression parts can be placed in brackets. In this case, the URI parts mapped to such expression parts will be available in the _edited path_ in the values of the `$1`, `$2`, ... `$9` variables, where the variable number matches the sequence number of the regular expression part in the _source path_.

* **Edited path**: URI part that must replace the original path matching the specified regular expression.

    In the edited path, you can use variables containing parts of the source path which have been placed in brackets: `$1`, `$2`, ... `$9`.

**Rewrite rule example:**

> `/(videos)/(events)/(\d{4}-\d{2}-\d{2})/(.*) /$2/$1/$3-$4`
>
> This rule will modify the request URI as follows:
>
> Source URI: `https://example.com/videos/events/2024-01-01/new-year.avi`
> Target URI: `https://example.com/events/videos/2024-01-01-new-year.avi`

## Flag {#flag}

Flags allow you to stop further processing of `Rewrite` directives or return `redirect` to the user. The following flags are available for `Rewrite` rules:

{% include [rewrite-flag-list](../../_includes/cdn/rewrite-flag-list.md) %}

#### See also {#see-also}

* [Guide for enabling request redirection](../operations/resources/setup-http-rewrite.md)