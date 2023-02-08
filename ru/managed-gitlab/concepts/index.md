# Взаимосвязь ресурсов в {{ mgl-name }}

[{{ GL }}](https://about.gitlab.com/) — это веб-инструмент жизненного цикла {% if lang == "ru" %}[DevOps](/blog/posts/2022/03/what-is-devops){% else %}DevOps{% endif %} с открытым исходным кодом. Он представляет собой систему управления репозиториями кода для [Git](https://git-scm.com/) с системой отслеживания ошибок, [CI/CD]{% if lang == "ru" %}(/blog/posts/2022/10/ci-cd){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/CI/CD){% endif %} пайплайном, собственной Wiki и другими функциями.

{{ mgl-name }} позволяет настроить развертывание приложений на [виртуальных машинах](../../compute/concepts/vm.md) [{{ compute-full-name }}](../../compute/), а также поддерживает интеграцию с [{{ container-registry-full-name }}](../../container-registry/) и [{{ managed-k8s-full-name }}](../../managed-kubernetes/).

Схема работы {{ mgl-name }}:

![image]{% if lang == "ru" %}(../../_assets/managed-gitlab/gitlab_schema_ru.svg){% endif %}{% if lang == "en" %}(../../_assets/managed-gitlab/gitlab_schema_en.svg){% endif %}

## Инстанс {{ GL }} {#instance}

_Инстанс_ {{ GL }} — основная сущность, которой оперирует сервис. Это ВМ, размещенная в {{ yandex-cloud }}. {{ mgl-name }} берет на себя рутинные операции по техническому обслуживанию этой ВМ, например, обеспечение отказоустойчивости хранилища, установку обновлений безопасности, автоматизированное обновление до новых версий {{ GL }} и т. д.

## Конфигурация инстанса {#config}

При создании инстанса указываются:
* Тип инстанса — [количество ядер (vCPU) и объем памяти (RAM)](../../compute/concepts/vm-platforms.md).
* [Подсеть](../../vpc/concepts/network.md#subnet).

  {% include [GL CIDR Warning](../../_includes/managed-gitlab/cidr-note.md) %}

* Размер хранилища.
* Имя в домене `.gitlab.yandexcloud.net` — адрес вашего экземпляра {{ GL }} в интернете.
* Данные администратора:
  * Электронная почта.
  * Логин.