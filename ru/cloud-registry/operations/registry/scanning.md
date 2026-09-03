---
title: Сканирование реестра {{ cloud-registry-name }}
description: Из этой инструкции вы узнаете, как настроить сканирование реестра {{ cloud-registry-name }}.
---

# Сканирование реестра {{ cloud-registry-name }}

Сканирование реестров осуществляется с помощью [модуля управления уязвимостями (VM)](../../../security-deck/concepts/vulnerability-management.md). Вы можете настроить сканирование:
* в интерфейсе {{ sd-full-name }}. Для этого нажмите **{{ ui-key.yacloud.cloud-registry.scan-history-empty_button }}** и воспользуйтесь [инструкцией](../../../security-deck/operations/vulnerability-management/enable-vulnerability-management.md).
* в интерфейсе {{cloud-registry-name }}. Для этого воспользуйтесь данной инструкцией.

{% note info %}

Сканирование можно настроить только для локальных и удаленных Docker-реестров. В удаленных реестрах сканируются только Docker-образы, которые сохранены в кеше {{ cloud-registry-name }}.

{% endnote %}

{% note warning %}

Сканирование реестров тарифицируется. Подробнее в [правилах тарификации {{ sd-full-name }}](../../../security-deck/pricing.md#prices).

{% endnote %}

## Автоматическое сканирование {#auto}

Вы можете задать настройки, по которым артефакты в реестре будут сканироваться автоматически. Настройка автоматического сканирования также доступна при [создании реестра](create.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится реестр.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud.cloud-registry.title_registries }}**.
    1. Выберите реестр.
    1. Перейдите на вкладку **{{ ui-key.yacloud.cloud-registry.menu_scanner }}**.
    1. Нажмите **{{ ui-key.yacloud.cloud-registry.scanner-settings.action_configure-scanner }}**.
    1. (Опционально) В блоке **{{ ui-key.yacloud.cloud-registry.scanner-settings.label_scanning-language-packages }}** включите опцию **{{ ui-key.yacloud.cloud-registry.scan-policy-settings-form.row_scan-lang-packages }}**.
    1. (Опционально) Разверните блок **{{ ui-key.yacloud.cloud-registry.scan-policy-settings-form.section_on-push-title }}** и выберите:

        * `{{ ui-key.yacloud.cloud-registry.scan-policy-form-card.label_artifacts-to-scan_all }}`, чтобы сканировать все артефакты при добавлении в реестр.
        * `{{ ui-key.yacloud.cloud-registry.scan-policy-form-card.label_artifacts-to-scan_selected }}`, чтобы указать, какие артефакты сканировать при добавлении в реестр. Нажмите **{{ ui-key.yacloud.cloud-registry.scan-policy-form-card.button_add_artifacts }}**, выберите артефакты и нажмите **{{ ui-key.yacloud.cloud-registry.action_scan-artifacts-modal-add }}**.

    1. (Опционально) Разверните блок **{{ ui-key.yacloud.cloud-registry.scan-policy-settings-form.section_scheduled-title }}** и выберите:

        * `{{ ui-key.yacloud.cloud-registry.scan-policy-form-card.label_artifacts-to-scan_all }}`, чтобы сканировать все артефакты в реестре с заданной периодичностью.
        * `{{ ui-key.yacloud.cloud-registry.scan-policy-form-card.label_artifacts-to-scan_selected }}`, чтобы указать, какие артефакты сканировать с заданной периодичностью. Нажмите **{{ ui-key.yacloud.cloud-registry.scan-policy-form-card.button_add_artifacts }}**, выберите артефакты и нажмите **{{ ui-key.yacloud.cloud-registry.action_scan-artifacts-modal-add }}**.

        Укажите период сканирования артефактов.

    1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды CLI для создания политики автоматического сканирования:

        ```bash
        yc cloud-registry registry scan-policy create --help
        ```

    1. Подготовьте JSON-файл с правилами сканирования, например `scan-rules.json`:

        ```json
        {
          "pushRule": {
            "paths": ["*"],
            "disabled": false
          },
          "scheduleRules": [
            {
              "amount": "7",
              "intervalUnit": "DAYS",
              "paths": ["*"],
              "disabled": false
            }
          ]
        }
        ```

        Где:

        * `pushRule` — сканировать артефакты при добавлении в реестр:

            * `paths` — список путей до артефактов, которые нужно сканировать. Укажите `*`, чтобы сканировать все артефакты в реестре.
            * `disabled` — отключить сканирование.

        * `scheduleRules` — периодически сканировать артефакты в реестре:

            * `amount` — количество единиц времени в периоде сканирования.
            * `intervalUnit` — единица времени. Доступное значение: `DAYS`.
            * `paths` — список путей до артефактов, которые нужно сканировать. Укажите `*`, чтобы сканировать все артефакты в реестре.
            * `disabled` — отключить сканирование.

    1. Создайте политику автоматического сканирования:

        ```bash
        yc cloud-registry registry scan-policy create <имя_политики> \
          --registry-id <идентификатор_реестра> \
          --description <описание_политики> \
          --scan-lang-packages \
          --rules <путь_к_файлу_с_правилами>
        ```

        Где:

        * `<имя_политики>` — имя политики автоматического сканирования.
        * `--registry-id` — идентификатор реестра, для которого создается политика.
        * `--description` — описание политики. Необязательный параметр.
        * `--scan-lang-packages` — включить сканирование языковых пакетов. Необязательный параметр.
        * `--rules` — путь к JSON-файлу с правилами сканирования. Необязательный параметр.

- API {#api}

    Чтобы создать политику автоматического сканирования реестра, воспользуйтесь методом REST API [create](../../api-ref/ScanPolicy/create.md) для ресурса [ScanPolicy](../../api-ref/ScanPolicy/index.md) или вызовом gRPC API [ScanPolicyService/Create](../../api-ref/grpc/ScanPolicy/create.md).

{% endlist %}

## Ручное сканирование {#manual}

Вы можете запустить сканирование выбранных артефактов в реестре вручную.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится реестр.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud.cloud-registry.title_registries }}**.
    1. Выберите реестр.
    1. Перейдите на вкладку **{{ ui-key.yacloud.cloud-registry.menu_scanner }}**.
    1. Нажмите **{{ ui-key.yacloud.cloud-registry.scan-history-placeholder_action_new-scan }}**.
    1. Выберите артефакты, которые хотите сканировать, и нажмите **{{ ui-key.yacloud.cloud-registry.action_scan-artifacts-modal-add }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды CLI для сканирования артефакта:

        ```bash
        yc cloud-registry artifact scanner scan --help
        ```

    1. Получите список артефактов в реестре:

        ```bash
        yc cloud-registry registry list-artifacts <имя_или_идентификатор_реестра>
        ```

    1. Запустите сканирование артефакта:

        ```bash
        yc cloud-registry artifact scanner scan <идентификатор_артефакта>
        ```

- API {#api}

    Чтобы запустить сканирование артефакта, воспользуйтесь вызовом gRPC API [ScannerService/Scan](../../api-ref/grpc/Scanner/scan.md).

{% endlist %}



