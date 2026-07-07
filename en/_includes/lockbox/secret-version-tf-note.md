{% note info %}

We recommend using `yandex_lockbox_secret_version_hashed`: it stores values in {{ TF }} state in hashed format. We continue supporting `yandex_lockbox_secret_version`.

For more information about the `yandex_lockbox_secret_version_hashed` resource, see [this provider guide]({{ tf-provider-resources-link }}/lockbox_secret_version_hashed).

{% endnote %}