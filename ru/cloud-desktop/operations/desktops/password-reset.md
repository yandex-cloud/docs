---
title: Инструкция по сбросу пароля пользователя для рабочего стола в {{ cloud-desktop-full-name }}
description: Из статьи вы узнаете, как сбросить пароль пользователя для рабочего стола в {{ cloud-desktop-full-name }}.
---

# Сбросить пароль пользователя для рабочего стола

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится рабочий стол.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Выберите рабочий стол, к которому хотите подключиться.
  1. В блоке **{{ ui-key.yacloud.vdi.section_access }}** напротив пользовательского аккаунта нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.vdi.button_reset-password }}**.
  1. Подтвердите сброс пароля.
  1. Сохраните новый пароль из всплывающего окна и закройте его.

- Витрина пользовательских рабочих столов {#desktop-showcase}

  {% include [password-reset-desktop-showcase](../../../_includes/cloud-desktop/password-reset-desktop-showcase.md) %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/index.yaml) для сброса пароля [рабочего стола](../../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops desktop reset-password --help
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

  1. Выберите идентификатор (`ID`) нужного рабочего стола.
  1. {% include [cli-reset-password](../../../_includes/cloud-desktop/cli-reset-password.md) %}

- API {#api}

  Воспользуйтесь методом REST API [resetPassword](../../api-ref/Desktop/resetPassword.md) для ресурса [Desktop](../../api-ref/Desktop/index.md) или вызовом gRPC API [DesktopService/ResetPassword](../../api-ref/grpc/Desktop/resetPassword.md).

{% endlist %}