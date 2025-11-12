# Regions

A region is a geographic area that combines [availability zones](geo-scope.md). Each region has its own infrastructure and [services](services.md).

Your region depends on the management console in which you signed up for an account. In the management console, the user sees only the services and resources of the selected region.

Regions available in {{ yandex-cloud }}:

Region | Russia | Kazakhstan
--- | --- | ---
Availability zones | `ru-central1-a`<br/>`ru-central1-b`<br/>`ru-central1-d` | `kz1-a`
Management console | [https://console.yandex.cloud](https://console.yandex.cloud) | [https://kz.console.yandex.cloud](https://kz.console.yandex.cloud)
Paying for resources | [Plans for the Russia region](https://yandex.cloud/ru/prices) | [Plans for the Kazakhstan region](https://yandex.cloud/ru-kz/prices)
Service {{ billing-name }} | [https://center.yandex.cloud/billing](https://center.yandex.cloud/billing) | [https://kz.center.yandex.cloud/billing](https://kz.center.yandex.cloud/billing)
Endpoint {{ objstorage-full-name }} | https://storage.yandexcloud.net | https://storage.yandexcloud.kz

The following items are region-specific:

* {{ yandex-cloud }} API endpoint addresses:
    * [API endpoint addresses in the Russia region](https://yandex.cloud/ru/docs/api-design-guide/concepts/endpoints).
    * [API endpoint addresses in the Kazakhstan region](https://yandex.cloud/ru-kz/docs/api-design-guide/concepts/endpoints).
* {{ yandex-cloud }} CLI profile settings
    * [How to create a CLI profile in the Russia region](https://yandex.cloud/en/docs/cli/operations/profile/profile-create)
    * [How to create a CLI profile in the Kazakhstan region](https://yandex.cloud/ru-kz/docs/cli/operations/profile/profile-create)

User data is stored and available only within an individual region. For example, {{ objstorage-full-name }} buckets created in the Russia region are not available in the Kazakhstan region.

You can log in to the management console of each region. To start working in a new region, sign up and create a billing account there:
* [Quick start guide for the Russia region](https://yandex.cloud/en/docs/overview/quickstart)
* [Quick start guide for the Kazakhstan region](https://yandex.cloud/ru-kz/docs/overview/quickstart)

## Controlled organization in another region {#controlled-org}

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

A [controlled organization](../../organization/concepts/controlled-org.md) allows deploying your resources in a different region without registering a separate organization. Instead, you can [link](../../organization/operations/add-region.md) a region to the main organization to manage your resources in different regions from a single interface.

Resources in different regions are isolated from each other. The data used by the resources is stored in the same regions the resources reside in.
