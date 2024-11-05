---
title: Как запустить, перезапустить и остановить рабочий стол {{ cloud-desktop-full-name }}
description: Из статьи вы узнаете, как запустить, перезапустить и остановить рабочий стол {{ cloud-desktop-name }}.
---

# Запустить, перезапустить и остановить рабочий стол

## Запустить {#start}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен рабочий стол.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Напротив рабочего стола, который нужно запустить, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.vdi.button_start }}**.
  1. Подтвердите запуск.

- Витрина пользовательских рабочих столов {#desktop-showcase}

  1. Откройте [Витрину пользовательских рабочих столов]({{ link-cloud-desktop-showcase }}).
  1. В карточке рабочего стола, который нужно запустить, нажмите ![image](../../../_assets/console-icons/play.svg).
  1. Подтвердите запуск.

{% endlist %}

## Перезапустить {#restart}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен рабочий стол.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Напротив рабочего стола, который нужно перезапустить, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.vdi.button_restart }}**.
  1. Подтвердите перезапуск.

- Витрина пользовательских рабочих столов {#desktop-showcase}

  1. Откройте [Витрину пользовательских рабочих столов]({{ link-cloud-desktop-showcase }}).
  1. В карточке рабочего стола, который нужно перезапустить, нажмите ![image](../../../_assets/console-icons/arrow-rotate-right.svg).
  1. Подтвердите перезапуск.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/index.yaml) для перезапуска [рабочего стола](../../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops desktop restart --help
      ```

  1. Получите список рабочих столов в каталоге по умолчанию:

      ```bash
      yc desktops desktop list
      ```

      Результат:

      ```bash
      +----------------------+------------------+--------+----------------------+---------------------+
      |          ID          |       NAME       | STATUS |   DESKTOP GROUP ID   |   CREATED (UTC-0)   |
      +----------------------+------------------+--------+----------------------+---------------------+
      | e3vmvhgbgac4******** | my-cloud-desktop | ACTIVE | e3v1rbln45tl******** | 2024-10-09 22:42:28 |
      | e3vio1bc5ppz******** | reserved-desktop | ACTIVE | e3v1rbln45tl******** | 2024-10-09 21:35:17 |
      +----------------------+------------------+--------+----------------------+---------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного рабочего стола, например `my-cloud-desktop`.
  1. Перезапустите рабочий стол:

      ```bash
      yc desktops desktop restart --name <имя_рабочего_стола>
      ```

      {% include [create-desktop-cli-result](../../../_includes/cloud-desktop/create-desktop-cli-result.md) %}

{% endlist %}

## Остановить {#stop}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен рабочий стол.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Напротив рабочего стола, который нужно остановить, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.vdi.button_stop }}**.
  1. Подтвердите остановку.

- Витрина пользовательских рабочих столов {#desktop-showcase}

  1. Откройте [Витрину пользовательских рабочих столов]({{ link-cloud-desktop-showcase }}).
  1. В карточке рабочего стола, который нужно остановить, нажмите ![image](../../../_assets/console-icons/power.svg).
  1. Подтвердите остановку.

{% endlist %}
