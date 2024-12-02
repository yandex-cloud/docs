---
title: Изменить настройки сетевого балансировщика
description: Следуя данной инструкции, вы сможете изменить настройки сетевого балансировщика.
---

# Изменить настройки сетевого балансировщика

{% note info %}

{% include [type-update](../../_includes/network-load-balancer/type-update.md) %}

{% endnote %}

После создания сетевого балансировщика вы можете:

* [Изменить имя и описание балансировщика](#change-name-and-description).
* [Изменить метки балансировщика](#change-labels).
* [Изменить целевую группу или настройки проверки ее состояния](#change-target-group).
* [Подключить целевую группу](#add-target-group).
* [Добавить обработчик](#add-listener).

## Изменить имя и описание балансировщика {#change-name-and-description}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. Выберите сетевой балансировщик и нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в верхней части страницы.
    1. Задайте новые имя и описание балансировщика.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить имя и описание сетевого балансировщика:

    1. Узнайте имя или идентификатор балансировщика, получив [список сетевых балансировщиков в каталоге](load-balancer-list.md#list).

    1. Посмотрите текущие имя (`name`) и описание (`description`) балансировщика:

        ```bash
        yc load-balancer network-load-balancer get <имя_или_идентификатор_балансировщика>
        ```

    1. Посмотрите описание команды CLI для изменения конфигурации балансировщика:

        ```bash
        yc load-balancer network-load-balancer update --help
        ```

    1. Задайте новое имя и описание балансировщика:

        ```bash
        yc load-balancer network-load-balancer update <имя_или_идентификатор_балансировщика> \
           --new-name=<новое_имя_балансировщика> \
           --description=<новое_описание_балансировщика>
        ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](load-balancer-create.md).

        Полный список доступных для изменения полей конфигурации сетевого балансировщика см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

    1. Измените в описании сетевого балансировщика значение параметров `name` и `description`:

        ```hcl
        resource "yandex_lb_network_load_balancer" "foo" {
          name        = "<имя_балансировщика>"
          description = "<описание_балансировщика>"
          ...
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

    Воспользуйтесь методом API [update](../api-ref/NetworkLoadBalancer/update.md) и передайте в запросе:

    * Идентификатор балансировщика в параметре `networkLoadBalancerId`. Чтобы узнать идентификатор, [получите список сетевых балансировщиков в каталоге](load-balancer-list.md#list).
    * Новое имя в параметре `name`.
    * Новое описание в параметре `description`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `name`, `description`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить метки балансировщика {#change-labels}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. Выберите сетевой балансировщик и нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в верхней части страницы.
    1. Измените метки балансировщика.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить метки сетевого балансировщика:

    1. Посмотрите текущие метки и их значения (`labels`) балансировщика:

        ```bash
        yc load-balancer network-load-balancer get <имя_или_идентификатор_балансировщика>
        ```

        Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

    1. Посмотрите описание команды CLI для изменения конфигурации балансировщика:

        ```bash
        yc load-balancer network-load-balancer update --help
        ```

    1. Задайте новые значения для меток балансировщика:

        ```bash
        yc load-balancer network-load-balancer update <имя_или_идентификатор_балансировщика> \
           --labels <ключ_1>=<значение_1>,<ключ_2>=<значение_2>,...
        ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](load-balancer-create.md).

        Полный список доступных для изменения полей конфигурации сетевого балансировщика см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

    1. Измените в описании сетевого балансировщика значение параметров `name` и `description`:

        ```hcl
        resource "yandex_lb_network_load_balancer" "foo" {
          ...
          labels = {
            <ключ_1> = "<значение_1>"
            <ключ2_> = "<значение_2>"
            ...
          }
          ...
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

    Воспользуйтесь методом API [update](../api-ref/NetworkLoadBalancer/update.md) и передайте в запросе:

    * Идентификатор балансировщика в параметре `networkLoadBalancerId`. Чтобы узнать идентификатор, [получите список сетевых балансировщиков в каталоге](load-balancer-list.md#list).
    * Новые значения меток в параметре `labels`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `labels`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить целевую группу или настройки проверки ее состояния {#change-target-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. Выберите сетевой балансировщик и нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в верхней части страницы.
    1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}** выберите в выпадающем списке новую целевую группу или [создайте новую](target-group-create.md).
    1. Чтобы изменить настройки проверки состояния целевой группы:
        1. В блоке нужной целевой группы нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**.
        1. Укажите новые параметры проверки состояния целевой группы.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить целевую группу или настройки проверки ее состояния:

    1. Посмотрите описание команды CLI для изменения конфигурации балансировщика:

        ```bash
        yc load-balancer network-load-balancer update --help
        ```

    1. Задайте новый идентификатор целевой группы и настройки проверки ее состояния:

        ```bash
        yc load-balancer network-load-balancer update <имя_или_идентификатор_балансировщика> \
           --target-group target-group-id=<идентификатор_целевой_группы>,`
                         `healthcheck-name=<имя_проверки_состояния>,`
                         `healthcheck-interval=<интервал_выполнения_проверок>s,`
                         `healthcheck-timeout=<время_ожидания_ответа>s,`
                         `healthcheck-unhealthythreshold=<количество_проваленных_проверок_для_статуса_Unhealthy>,`
                         `healthcheck-healthythreshold=<количество_успешных_проверок_для_статуса_Healthy>,`
                         `healthcheck-tcp-port=<TCP-порт>,`
                         `healthcheck-http-port=<HTTP-порт>,`
                         `healthcheck-http-path=<адрес_URL>
        ```

        Где:

        {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

        Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](load-balancer-create.md).

        Полный список доступных для изменения полей конфигурации сетевого балансировщика см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

    1. Измените в описании сетевого балансировщика идентификатор целевой группы и настройки проверки ее состояния в блоке `attached_target_group`:

        ```hcl
        resource "yandex_lb_network_load_balancer" "foo" {
          name = "<имя_балансировщика>"
          ...
          attached_target_group {
            target_group_id = "<идентификатор_целевой_группы>"
            healthcheck {
              name = "<имя_проверки_состояния>"
              http_options {
                port = <номер_порта>
                path = "<адрес_URL>"
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

              {% include [get-target-group-id](../../_includes/network-load-balancer/get-target-group-id.md) %}

            * `healthcheck` — описание параметров проверки состояния. Укажите имя, порт из диапазона от `1` до `32767` и путь, по которому будут выполняться проверки.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

    Воспользуйтесь методом API [update](../api-ref/NetworkLoadBalancer/update.md) и передайте в запросе:

    * Идентификатор балансировщика в параметре `networkLoadBalancerId`. Чтобы узнать идентификатор, [получите список сетевых балансировщиков в каталоге](load-balancer-list.md#list).
    * Идентификатор целевой группы и настройки проверки ее состояния в параметре `attachedTargetGroups`.

      {% include [get-target-group-id](../../_includes/network-load-balancer/get-target-group-id.md) %}

    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `attachedTargetGroups`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Подключить целевую группу {#add-target-group}

Чтобы подключить целевую группу, воспользуйтесь [инструкцией](target-group-attach.md).

## Добавить обработчик {#add-listener}

Чтобы добавить обработчик, воспользуйтесь [инструкцией](listener-add.md).
