---
title: Other
description: This page covers FAQ about {{ datalens-name }}.
---

# Other


### How do I get the logs of my activity in the services? {#logs}

You can get {{ yandex-cloud }} service logs on your own by connecting to [{{ datalens-short-name }} Usage Analytics](../operations/connection/create-usage-tracking.md).

{% include [copy-folder](../../_qa/datalens/copy-folder.md) %}

### Can I install {{ datalens-short-name }} locally inside the company? {#datalens-local}

{{ datalens-short-name }} offers the following deployment options:

* {{ datalens-short-name }} Enterprise can be deployed within the customer’s on-premise infrastructure for team collaboration. [Submit request]({{ link-datalens-main }}/#enterpise).
* {{ datalens-full-name }} as a cloud service. Please, note:

  * {{ datalens-full-name }} is a {{ yandex-cloud }} service compliant with Federal Law No. 152 and industry security standards. For more information, see [{{ yandex-cloud }} security](/security).
  * For {{ datalens-full-name }}, you can [set up an identity federation](../../organization/quickstart.md).

* [{{ datalens-short-name }} Open Source]({{ link-datalens-main }}/opensource/) can be deployed locally for trial use with limited functionality.

### Why is the cloud with a {{ datalens-short-name }} instance blocked? {#datalens-suspended}

Your cloud may be blocked in the following cases:

* Outstanding charges for {{ yandex-cloud }} paid services that are in the same cloud as {{ datalens-short-name }}.
* Expiration of a trial period for {{ yandex-cloud }} paid services.
* Violation of the {{ yandex-cloud }} [terms of use](https://yandex.ru/legal/cloud_termsofuse/?lang=en).

When a cloud is suspended, your {{ datalens-short-name }} instance will be unavailable. You won't be able to use {{ datalens-short-name }} until access to the cloud is restored.

Learn more in [Automatic cloud suspension](../../overview/concepts/data-deletion.md#block).

{% include [object-id](../../_qa/datalens/object-id.md) %}

{% include [related-objects](../../_qa/datalens/related-objects.md) %}

{% include [network-error](../../_qa/datalens/network-error.md) %}



{% include [main-page-error](../../_qa/datalens/main-page-error.md) %}

### What browser versions are supported by {{ datalens-short-name }}? {#browser-versions}


{{ datalens-short-name }} supports the two latest major browser versions. For more information, see the [list of versions](https://browsersl.ist/#q=last+2+major+versions+and+last+2+years+and+fully+supports+es6+and+%3E+0.05%25%0Anot+dead%0Anot+op_mini+all%0Anot+and_qq+%3E+0%0Anot+and_uc+%3E+0%0AFirefox+ESR%0AChrome+%3E+0+and+last+2+years+and+%3E+0.05%25%0ASafari+%3E+0+and+last+2+years+and+%3E+0.05%25%0AFirefox+%3E+0+and+last+2+years+and+%3E+0.01%25).
