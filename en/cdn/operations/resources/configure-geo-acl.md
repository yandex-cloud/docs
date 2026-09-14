---
title: Configuring a country-based access policy
description: "Follow this guide to set up country-based access to\_a CDN resource."
---

# Configuring a country-based access policy

You can use a [country-based access policy](../../concepts/geo-acl.md) to allow or deny access to a CDN resource for users from specific countries.

{% include [geo-policy-warning](../../../_includes/cdn/geo-policy-warning.md) %}

To configure a country-based access policy:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.
  1. [Navigate]({{ link-console-main }}/link/cdn) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Click the resource name.
  1. Navigate to the ![image](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.cdn.label_resource-security }}** tab.
  1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Enable **Country-based access**.
  1. In the **Access policy** field, select:

      * `Block specified countries` to restrict access to the resource from countries listed in the **Country list** field and allow access from all other countries.
      * `Allow specified countries only` to allow access to the resource only from countries on the **Country list** and deny access from all other countries.

  1. In the **Country list** field, enter two-letter uppercase [country codes](../../concepts/geo-acl.md#country-codes) separated by commas, e.g., `RU, KZ`.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- REST API {#rest-api}

  To configure a policy, add the `geoAcl` section when using the [create](../../api-ref/Resource/create.md) or [update](../../api-ref/Resource/update.md) method for a [Resource](../../api-ref/Resource/index.md):

  ```json
  "geoAcl": {
    "enabled": "boolean",
    "mode": "string",
    "countries": [
      "string"
    ]
  }
  ```

  Where:

  * `enabled`: Enables the country-based access policy.
  * `mode`: Policy type:
      * `MODE_ALLOW`: Allow access only from countries specified in `countries`.
      * `MODE_DENY`: Restrict access from countries specified in `countries`.

  * `countries`: List of two-letter uppercase [country codes](../../concepts/geo-acl.md#country-codes).

- gRPC API {#grpc-api}

  To configure a policy, add the `geo_acl` section when using the [ResourceService/Create](../../api-ref/grpc/Resource/create.md) or [ResourceService/Update](../../api-ref/grpc/Resource/update.md) call:

  ```json
  "geo_acl": {
    "enabled": "bool",
    "mode": "Mode",
    "countries": [
      "string"
    ]
  }
  ```

  Where:

  * `enabled`: Enables the country-based access policy.
  * `mode`: Policy type:
      * `MODE_ALLOW`: Allow access only from countries specified in `countries`.
      * `MODE_DENY`: Restrict access from countries specified in `countries`.

  * `countries`: List of two-letter uppercase [country codes](../../concepts/geo-acl.md#country-codes).

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}

#### Useful links {#see-also}

* [{#T}](../../concepts/geo-acl.md)
* [{#T}](create-resource.md)
