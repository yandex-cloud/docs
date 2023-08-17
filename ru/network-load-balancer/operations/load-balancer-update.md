# Изменить настройки сетевого балансировщика

После создания сетевого балансировщика вы можете:

* [{#T}](#change-name-and-description).

* [{#T}](#change-labels).

* [{#T}](#change-target-group).

* [{#T}](#add-target-group).

* [{#T}](#add-listener).

## Изменить имя и описание балансировщика {#change-name-and-description}

{% list tabs %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ network-load-balancer-name }}**.
    1. Выберите сетевой балансировщик и нажмите кнопку **Редактировать** в верхней части страницы.
    1. Задайте новые имя и описание балансировщика.
    1. Нажмите кнопку **Редактировать**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить имя и описание сетевого балансировщика:

    1. Посмотрите текущие имя (`name`) и описание (`description`) балансировщика:

        ```bash
        yc load-balancer network-load-balancer get <идентификатор или имя балансировщика>
        ```

        Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

    1. Посмотрите описание команды CLI для изменения конфигурации балансировщика:

        ```bash
        yc load-balancer network-load-balancer update --help
        ```

    1. Задайте новое имя и описание балансировщика:

        ```bash
        yc load-balancer network-load-balancer update <идентификатор или имя балансировщика> \
           --new-name=<новое имя балансировщика> \
           --description=<новое описание балансировщика>
        ```

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](load-balancer-create.md).

        Полный список доступных для изменения полей конфигурации сетевого балансировщика см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

    1. Измените в описании сетевого балансировщика значение параметров `name` и `description`:

        ```hcl
        resource "yandex_lb_network_load_balancer" "foo" {
          name        = "<имя сетевого балансировщика>"
          description = "<описание сетевого балансировщика>"
          ...
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/NetworkLoadBalancer/update.md) и передайте в запросе:

    * Идентификатор балансировщика в параметре `networkLoadBalancerId`. Чтобы узнать идентификатор, [получите список сетевых балансировщиков в каталоге](load-balancer-list.md#list).
    * Новое имя в параметре `name`.
    * Новое описание в параметре `description`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `name`, `description`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить метки балансировщика {#change-labels}

{% list tabs %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ network-load-balancer-name }}**.
    1. Выберите сетевой балансировщик и нажмите кнопку **Редактировать** в верхней части страницы.
    1. Измените метки балансировщика.
    1. Нажмите кнопку **Редактировать**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить метки сетевого балансировщика:

    1. Посмотрите текущие метки и их значения (`labels`) балансировщика:

        ```bash
        yc load-balancer network-load-balancer get <идентификатор или имя балансировщика>
        ```

        Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

    1. Посмотрите описание команды CLI для изменения конфигурации балансировщика:

        ```bash
        yc load-balancer network-load-balancer update --help
        ```

    1. Задайте новые значения для меток балансировщика:

        ```bash
        yc load-balancer network-load-balancer update <идентификатор или имя балансировщика> \
           --labels <ключ1>=<значение1>,<ключ2>=<значение2>,...
        ```

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](load-balancer-create.md).

        Полный список доступных для изменения полей конфигурации сетевого балансировщика см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

    1. Измените в описании сетевого балансировщика значение параметров `name` и `description`:

        ```hcl
        resource "yandex_lb_network_load_balancer" "foo" {
          ...
          labels = {
            <ключ1> = "значение1"
            <ключ2> = "значение2"
            ...
          }
          ...
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/NetworkLoadBalancer/update.md) и передайте в запросе:

    * Идентификатор балансировщика в параметре `networkLoadBalancerId`. Чтобы узнать идентификатор, [получите список сетевых балансировщиков в каталоге](load-balancer-list.md#list).
    * Новые значения меток в параметре `labels`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `labels`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить целевую группу или настройки проверки ее состояния {#change-target-group}

{% list tabs %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ network-load-balancer-name }}**.
    1. Выберите сетевой балансировщик и нажмите кнопку **Редактировать** в верхней части страницы.
    1. В блоке **Целевые группы** выберите в выпадающем списке новую целевую группу или [создайте новую](target-group-create.md).
    1. Чтобы изменить настройки проверки состояния целевой группы:
        1. В блоке нужной целевой группы нажмите кнопку **Настроить**.
        1. Укажите новые параметры проверки состояния целевой группы.
        1. Нажмите кнопку **Применить**.
    1. Нажмите кнопку **Редактировать**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить целевую группу или настройки проверки ее состояния:

    1. Посмотрите описание команды CLI для изменения конфигурации балансировщика:

        ```bash
        yc load-balancer network-load-balancer update --help
        ```

    1. Задайте новый идентификатор целевой группы и настройки проверки ее состояния:

        ```bash
        yc load-balancer network-load-balancer update <идентификатор или имя балансировщика> \
           --target-group target-group-id=<идентификатор целевой группы>,`
                         `healthcheck-name=<имя проверки состояния>,`
                         `healthcheck-interval=<интервал выполнения проверок>s,`
                         `healthcheck-timeout=<время ожидания ответа>s,`
                         `healthcheck-unhealthythreshold=<количество проваленных проверок для статуса Unhealthy>,`
                         `healthcheck-healthythreshold=<количество успешных проверок для статуса Healthy>,`
                         `healthcheck-tcp-port=<TCP-порт>,`
                         `healthcheck-http-port=<HTTP-порт>,`
                         `healthcheck-http-path=<адрес URL, по которому будут выполняться проверки>
        ```

        Где:

        {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

        Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list), идентификатор целевой группы — со [списком целевых групп в каталоге](target-group-list.md#list).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](load-balancer-create.md).

        Полный список доступных для изменения полей конфигурации сетевого балансировщика см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

    1. Измените в описании сетевого балансировщика идентификатор целевой группы и настройки проверки ее состояния в блоке `attached_target_group`:

        ```hcl
        resource "yandex_lb_network_load_balancer" "foo" {
          name = "<имя сетевого балансировщика>"
          ...
          attached_target_group {
            target_group_id = "<идентификатор целевой группы>"
            healthcheck {
              name = "<имя проверки состояния>"
              http_options {
                port = <номер порта>
                path = "<адрес URL, по которому будут выполняться проверки>"
              }
            }
          }
          ...
        }
        ```

        Где:

        * `name` — имя сетевого балансировщика.
        * `attached_target_group` — описание параметров целевой группы для сетевого балансировщика:
            * `target_group_id` — идентификатор целевой группы.
            * `healthcheck` — описание параметров проверки состояния. Укажите имя, порт из диапазона от `1` до `32767` и путь, по которому будут выполняться проверки.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/NetworkLoadBalancer/update.md) и передайте в запросе:

    * Идентификатор балансировщика в параметре `networkLoadBalancerId`. Чтобы узнать идентификатор, [получите список сетевых балансировщиков в каталоге](load-balancer-list.md#list).
    * Идентификатор целевой группы и настройки проверки ее состояния в параметре `attachedTargetGroups`. Чтобы узнать идентификатор, [получите список целевых групп в каталоге](target-group-list.md#list).
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `attachedTargetGroups`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Подключить целевую группу {#add-target-group}

Чтобы подключить целевую группу, воспользуйтесь [инструкцией](target-group-attach.md).

## Добавить обработчик {#add-listener}

Чтобы добавить обработчик, воспользуйтесь [инструкцией](listener-add.md).
