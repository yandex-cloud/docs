{% note tip %}

В {{ TF }} есть следующие типы ресурсов для назначения ролей, например, на каталог:

* [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member) — одна роль одному субъекту.
* [yandex_resourcemanager_folder_iam_binding]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_binding) — все субъекты для одной роли, список которых заменяется при обновлении.
* [yandex_resourcemanager_folder_iam_policy]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_policy) — все назначенные роли на ресурс с заменой текущих.

Рекомендуется использовать `iam_member`. Этот способ позволяет назначить одну роль одному субъекту, не меняя остальные назначенные роли. Не комбинируйте разные типы ресурсов для управления одними и теми же ролями и субъектами.

{% endnote %}
