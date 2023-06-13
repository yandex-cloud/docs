# Другое



### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить записи о том, что происходило с вашими ресурсами, из логов сервисов {{ yandex-cloud }}. Подробнее читайте в разделе [{#T}](../../support/request.md).

{% include [copy-folder](../../_qa/datalens/copy-folder.md) %}

### Можно ли установить {{ datalens-short-name }} внутри компании? {#datalens-local}

{{ datalens-short-name }} представлен только в виде облачного сервиса. Также хотим отметить:

* {{ datalens-short-name }} — это сервис {{ yandex-cloud }}, который соответствует ФЗ-152 и индустриальным стандартам безопасности. Подробнее в разделе [Безопасность {{ yandex-cloud }}](/security).

* Для {{ datalens-short-name }} можно [настроить федерацию учетных записей](../../organization/quick-start.md).

### Почему заблокировано облако с экземпляром {{ datalens-short-name }}? {#datalens-suspended}

Ваше облако может быть заблокировано в следующих случаях:

* Наличие задолженности за использование платных сервисов {{ yandex-cloud }}, которые находятся в том же облаке, что и {{ datalens-short-name }}.
* Пробный период за использование платных сервисов {{ yandex-cloud }} завершен.
* При нарушении [условий использования](https://yandex.ru/legal/cloud_termsofuse/?lang=ru) {{ yandex-cloud }}.

После блокировки облака ваш экземпляр {{ datalens-short-name }} будет недоступен. Работа с {{ datalens-short-name }} будет невозможна до восстановления облака.

Подробнее о блокировке можно прочитать в разделе [Автоматическая блокировка облака](../../overview/concepts/data-deletion.md#block).

{% include [object-id](../../_qa/datalens/object-id.md) %}

{% include [network-error](../../_qa/datalens/network-error.md) %}



