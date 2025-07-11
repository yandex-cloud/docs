---
title: Как создать инстанс {{ mgl-full-name }}
description: Из статьи вы узнаете, как создать инстанс {{ mgl-name }}.
---

# Создание и активация инстанса {{ mgl-name }}

## Создать инстанс {{ GL }} {#create}

Для создания инстанса {{ mgl-name }} нужна роль [{{ roles-vpc-user }}](../../../vpc/security/index.md#vpc-user) и роль [{{ roles.gitlab.editor }} или выше](../../security/index.md#roles-list). О том, как назначить роль, см. [документацию {{ iam-name }}](../../../iam/operations/roles/grant.md).

{% include [warn-subnet](../../../_includes/managed-gitlab/warn-subnet.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [instance-create-console](../../../_includes/managed-gitlab/instance-create-console.md) %}

- CLI {#cli}

  {% include [instance-create-cli](../../../_includes/managed-gitlab/instance-create-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы создать инстанс {{ GL }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_gitlab_instance" "my_gitlab_instance" {
       name                      = "<имя_инстанса>"
       resource_preset_id        = "<класс_хостов>"
       disk_size                 = <размер_диска_ГБ>
       admin_login               = "<логин_администратора>"
       admin_email               = "<электронная_почта_администратора>"
       domain                    = "<доменное_имя_инстанса>"
       subnet_id                 = "<идентификатор_подсети>"
       approval_rules_id         = "<конфигурация_правил_ревью_кода>"
       backup_retain_period_days = <срок_хранения_копий>
       deletion_protection       = <true_или_false>
     }
     ```

     Где:
     * `name` — имя инстанса, уникальное в рамках {{ yandex-cloud }}. Требования к имени:

        {% include [name-format](../../../_includes/name-format.md) %}

     * `resource_preset_id` — класс хостов. Он определяет технические характеристики виртуальной машины, на которой будет развернут инстанс {{ GL }}. Возможные значения:
        * `s2.micro` — 2 vCPU, 8 ГБ RAM.
        * `s2.small` — 4 vCPU, 16 ГБ RAM.
        * `s2.medium` — 8 vCPU, 32 ГБ RAM.
        * `s2.large` — 16 vCPU, 64 ГБ RAM.
     * `disk_size` — размер диска в ГБ.
     * `admin_login` — логин администратора инстанса {{ GL }}.
     * `admin_email` — адрес электронной почты администратора. На этот адрес придет письмо со ссылкой для создания пароля.
     * `domain` — [доменное имя инстанса](../../../compute/concepts/network.md#hostname). Для него будут автоматически созданы нужные DNS-записи в домене `.gitlab.yandexcloud.net`.

        {% include [domain-name-format](../../../_includes/managed-gitlab/domain-name-format.md) %}

     * `subnet_id` — идентификатор выбранной подсети.
     * `approval_rules_id` — конфигурация [правил ревью кода](../../concepts/approval-rules.md). Возможные значения:
        * `BASIC` — базовая.
        * `STANDARD` — стандартная.
        * `ADVANCED` — продвинутая.

        {% include [note-approval-rules-pricing](../../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

     * `backup_retain_period_days` — срок хранения автоматических резервных копий (в днях).
     * `deletion_protection` — защита инстанса от случайного удаления пользователем. Возможные значения: `true` или `false`.

     Более подробную информацию о параметрах ресурса `yandex_gitlab_instance` см. в [документации провайдера]({{ tf-provider-resources-link }}/gitlab_instance).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     {{ yc-mdb-gl }} instance list
     ```

- API {#api}

  Воспользуйтесь методом REST API [Create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md).

{% endlist %}

{% include [HTTPS info](../../../_includes/managed-gitlab/note-https.md) %}

## Активировать инстанс {{ GL }} {#activate}

После того как статус инстанса принял значение **Running**, активируйте инстанс:

1. Перейдите по ссылке, полученной на электронную почту администратора после создания инстанса.

   Если по ссылке не открывается веб-интерфейс {{ GL }}, создайте отдельную группу безопасности и [настройте ее](../configure-security-group.md) так, чтобы правила разрешали входящий трафик с нужных портов и IP-адресов.

1. Измените пароль администратора.
1. Авторизуйтесь с помощью логина и пароля администратора.

В дальнейшем, чтобы открыть веб-интерфейс {{ GL }}, [получите детальную информацию об инстансе](instance-list.md#get) и перейдите по ссылке в поле **{{ ui-key.yacloud.gitlab.field_domain }}**.
