# Other


### How do I get the logs of my actions in the services? {#logs}

You can get {{ yandex-cloud }} service logs on your own by connecting to [{{ datalens-short-name }} Usage Analytics](../operations/connection/create-usage-tracking.md).

{% include [copy-folder](../../_qa/datalens/copy-folder.md) %}

### Can I install {{ datalens-short-name }} locally inside the company? {#datalens-local}

{{ datalens-short-name }} is offered only as a cloud service. We would also like to note:

* {{ datalens-short-name }} is a {{ yandex-cloud }} service, which is compliant with Federal Law No. 152 and industry security standards. For more information, see [{{ yandex-cloud }} security](/security).

* For {{ datalens-short-name }}, you can [set up identity federations](../../organization/quickstart.md).

### Why is the cloud with a {{ datalens-short-name }} instance blocked? {#datalens-suspended}

Your cloud may be blocked in the following cases:

* Outstanding charges for {{ yandex-cloud }} paid services that are in the same cloud as {{ datalens-short-name }}.
* Expiration of a trial period for {{ yandex-cloud }} paid services.
* Violation of the {{ yandex-cloud }} [Terms of Use](https://yandex.ru/legal/cloud_termsofuse/?lang=en).

When a cloud is suspended, your {{ datalens-short-name }} instance will be unavailable. You won't be able to use {{ datalens-short-name }} until access to the cloud is restored.

Learn more in [Automatic cloud suspension](../../overview/concepts/data-deletion.md#block).

{% include [object-id](../../_qa/datalens/object-id.md) %}

{% include [network-error](../../_qa/datalens/network-error.md) %}



{% include [main-page-error](../../_qa/datalens/main-page-error.md) %}