# Обзор API {{ yandex-cloud }} для {{ ydb-name }}

Вы можете управлять ресурсами {{ ydb-name }} с помощью [API {{ yandex-cloud }}](../../api-design-guide/).

API {{ yandex-cloud }} позволяет:

* управлять базами данных;
* управлять резервными копиями БД;
* получать информацию о зонах доступности, вычислительных ресурсах и типах дисков групп хранения для Dedicated БД;
* просматривать статус и отменять асинхронные операции {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %}.

С помощью API {{ yandex-cloud }} и [{{ TF }}](https://www.terraform.io/) можно автоматизировать управление ресурсами {{ ydb-name }}.
Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs).
