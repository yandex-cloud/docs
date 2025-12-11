---
title: Другое
description: На странице представлены вопросы и ответы про работу сервиса {{ datalens-name }}.
---

# Другое



### Я могу получить логи моей работы в сервисах? {#logs}

Вы можете самостоятельно получить логи сервисов {{ yandex-cloud }} с помощью подключения к [{{ datalens-short-name }} Usage Analytics](../operations/connection/create-usage-tracking.md).

{% include [copy-folder](../../_qa/datalens/copy-folder.md) %}

### Можно ли установить {{ datalens-short-name }} внутри компании? {#datalens-local}

{{ datalens-short-name }} доступен в следующих вариантах поставки:

* {{ datalens-short-name }} Enterprise можно развернуть внутри локальной инфраструктуры клиента для командной работы. [Оставить заявку]({{ link-datalens-main }}/#enterpise)
* {{ datalens-full-name }} в виде облачного сервиса. Хотим также отметить:

  * {{ datalens-full-name }} — это сервис {{ yandex-cloud }}, который соответствует ФЗ-152 и индустриальным стандартам безопасности. Подробнее в разделе [Безопасность {{ yandex-cloud }}](/security).
  * Для {{ datalens-full-name }} можно [настроить федерацию учетных записей](../../organization/quickstart.md).

* [{{ datalens-short-name }} Open Source]({{ link-datalens-main }}/opensource/) можно развернуть локально для ознакомления, возможности сервиса ограничены.

### Почему заблокировано облако с экземпляром {{ datalens-short-name }}? {#datalens-suspended}

Ваше облако может быть заблокировано в следующих случаях:

* Наличие задолженности за использование платных сервисов {{ yandex-cloud }}, которые находятся в том же облаке, что и {{ datalens-short-name }}.
* Пробный период за использование платных сервисов {{ yandex-cloud }} завершен.
* При нарушении [условий использования](https://yandex.ru/legal/cloud_termsofuse/?lang=ru) {{ yandex-cloud }}.

После блокировки облака ваш экземпляр {{ datalens-short-name }} будет недоступен. Работа с {{ datalens-short-name }} будет невозможна до восстановления облака.

Подробнее о блокировке можно прочитать в разделе [Автоматическая блокировка облака](../../overview/concepts/data-deletion.md#block).

{% include [object-id](../../_qa/datalens/object-id.md) %}

{% include [related-objects](../../_qa/datalens/related-objects.md) %}

{% include [network-error](../../_qa/datalens/network-error.md) %}




{% include [main-page-error](../../_qa/datalens/main-page-error.md) %}

### Какие версии браузеров поддерживает {{ datalens-short-name }}? {#browser-versions}


{{ datalens-short-name }} поддерживает последние две выпущенные мажорные версии браузера. Подробнее см. [список версий](https://browsersl.ist/#q=last+2+major+versions+and+last+2+years+and+fully+supports+es6+and+%3E+0.05%25%0Anot+dead%0Anot+op_mini+all%0Anot+and_qq+%3E+0%0Anot+and_uc+%3E+0%0AFirefox+ESR%0AChrome+%3E+0+and+last+2+years+and+%3E+0.05%25%0ASafari+%3E+0+and+last+2+years+and+%3E+0.05%25%0AFirefox+%3E+0+and+last+2+years+and+%3E+0.01%25).
