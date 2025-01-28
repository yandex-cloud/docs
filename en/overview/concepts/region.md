# Regions

A region is a geographic area that combines [availability zones](geo-scope.md). Each region has its own infrastructure and [services](services.md).

Your region depends on the management console in which you signed up for an account. In the management console, the user sees only the services and resources of the selected region.

Regions available in {{ yandex-cloud }}:

Region | Russia | Kazakhstan
--- | --- | ---
Availability zones | `{{ region-id }}-a`<br/>`{{ region-id }}-b`<br/>`{{ region-id }}-d` | `kz1-a`
Management console | [https://console.yandex.cloud](https://console.yandex.cloud) | [https://kz.console.yandex.cloud](https://kz.console.yandex.cloud)
Paying for resources | [Plans for the Russia region](https://yandex.cloud/ru/prices) | [Plans for the Kazakhstan region](https://yandex.cloud/ru-kz/prices)
Service {{ billing-name }} | [https://billing.yandex.cloud](https://billing.yandex.cloud) | [https://kz.billing.yandex.cloud](https://kz.billing.yandex.cloud)
{{ objstorage-full-name }} endpoint | https://storage.yandexcloud.net | https://storage.yandexcloud.kz

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

