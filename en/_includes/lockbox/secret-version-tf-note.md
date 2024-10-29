{% note info %}

We recommend using `yandex_lockbox_secret_version_hashed`: it stores values in {{ TF }} state in hashed format. We continue supporting `yandex_lockbox_secret_version`.

For more information about `yandex_lockbox_secret_version_hashed`, see the [relevant provider documentation]({{ tf-provider-resources-link }}/lockbox_secret_version_hashed).

{% endnote %}