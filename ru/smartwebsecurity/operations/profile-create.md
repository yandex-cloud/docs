---
title: "Как создать профиль безопасности {{ sws-full-name }}"
description: "Следуя данной инструкции, вы сможете создать профиль безопасности {{ sws-full-name }}."
---

# Создать профиль безопасности

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать [профиль безопасности](../concepts/profiles.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.action_empty }}**.
  1. Выберите один из вариантов создания:
      * **{{ ui-key.yacloud.smart-web-security.title_default-template }}** (рекомендуется). Преднастроенный профиль содержит:

        * [базовое правило](../concepts/rules.md#base-rules) по умолчанию, включенное для всего трафика с [типом действия](../concepts/rules.md#rule-action) — `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}`;
        * [правило Smart Protection](../concepts/rules.md#smart-protection-rules), включенное для всего трафика, с типом действия — `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`.
      * **{{ ui-key.yacloud.smart-web-security.title_no-template }}**. Профиль содержит только базовое правило по умолчанию, включенное для всего трафика.

  1. Введите имя профиля.
  1. (опционально) Введите описание.
  1. (опционально) Добавьте профилю [метки](../../resource-manager/concepts/labels.md).
  1. В поле **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** выберите, что делать с трафиком, который не попал под условия других правил: `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` или `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
  1. Выберите или создайте [профиль ARL](../operations/arl-profile-create.md), чтобы установить лимиты на количество запросов.
  1. Выберите или создайте капчу [{{ captcha-full-name }}](../../smartcaptcha/) для проверки подозрительных запросов:

        {% include [captcha-integration](../../_includes/smartwebsecurity/captcha-integration.md) %}

  1. Нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. В окне создания правила:

      {% include [add-rule](../../_includes/smartwebsecurity/add-rule.md) %}

  1. Последовательно добавьте все правила, которые вы хотите задействовать в профиле.

      В блоке **{{ ui-key.yacloud.smart-web-security.form.section_security-rules }}** в таблице появятся созданные вами правила.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/quickstart.md) для создания [профиля безопасности](../concepts/profiles.md):

     ```bash
     yc smartwebsecurity security-profile create --help
     ```

  1. Чтобы создать профиль безопасности, выполните команду:

     ```bash
     yc smartwebsecurity security-profile create \
        --name <имя_профиля_безопасности> \
        --description "<описание_профиля>" \
        --labels <ключ_метки_1>=<значение_метки_1>,<ключ_метки_2>=<значение_метки_2>,...,<ключ_метки_n>=<значение_метки_n> \
        --default-action <действие> \
        --captcha-id <идентификатор_капчи> \
        --security-rules-file <путь_к_файлу_с_правилами>
     ```

     Где:

     * `--name` — имя профиля безопасности. Обязательный параметр. Если задать только имя профиля без дополнительных параметров, в профиле безопасности будет создано одно [базовое правило](../concepts/rules.md#base-rules).
     * `--description` — текстовое описание профиля безопасности. Необязательный параметр.
     * `--labels` — список [меток](../../resource-manager/concepts/labels.md) для добавления в профиль в формате `КЛЮЧ=ЗНАЧЕНИЕ`. Необязательный параметр. Например: `--labels foo=baz,bar=baz'`.
     * `--default-action` — действие, которое следует выполнить для трафика, который не попал под условия других правил. Необязательный параметр. По умолчанию установлено значение `allow`, разрешающее все запросы к сервису. Чтобы запретить запросы, установите значение `deny`.
     * `--captcha-id` — идентификатор капчи [{{ captcha-full-name }}](../../smartcaptcha/) для проверки подозрительных запросов. Необязательный параметр.
      * `--security-rules-file` — путь к файлу с описанием правил безопасности в формате [YAML](https://ru.wikipedia.org/wiki/YAML). Необязательный параметр. Например:

          {% include [profile-create-yaml-example](../../_includes/smartwebsecurity/profile-create-yaml-example.md) %}

     Результат:

     ```bash
     id: fev6q4qqnn2q********
     folder_id: b1g07hj5r6i********
     cloud_id: b1gia87mbaom********
     name: my-sample-profile
     description: "my description"
     labels: label1=value1,label2=value2
     default_action: DENY
     created_at: "2024-07-25T19:21:05.039610Z"
     ```

  Подробнее о команде `yc smartwebsecurity security-profile create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/smartwebsecurity/security-profile/create.md).

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/SecurityProfile/create.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/) или вызовом gRPC API [SecurityProfileService/Create](../api-ref/grpc/security_profile_service.md#Create).

{% endlist %}

### См. также {#see-also}

* [{#T}](host-connect.md)
* [{#T}](profile-update.md)
* [{#T}](profile-delete.md)