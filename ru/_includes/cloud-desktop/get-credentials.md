{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится рабочий стол.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Выберите рабочий стол, к которому хотите подключиться.
  1. В блоке **{{ ui-key.yacloud.vdi.section_access }}** напротив пользовательского аккаунта нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.vdi.button_reset-password }}**.
  1. Подтвердите сброс пароля.
  1. Сохраните новый пароль из всплывающего окна и закройте его.
  1. Справа сверху нажмите ![image](../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.vdi.button_download-rdp }}**.

- Витрина пользовательских рабочих столов {#desktop-showcase}

  {% include [get-credentials-desktop-showcase](get-credentials-desktop-showcase.md) %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/index.yaml) для получения данных RDP-файла:

      ```bash
      yc desktops desktop get-rdp-file --help
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
  1. [Сбросьте](../../cloud-desktop/operations/desktops/password-reset.md) пароль пользователя для рабочего стола.


  1. Запросите данные:

      ```bash
      yc desktops desktop get-rdp-file --name <имя_рабочего_стола>
      ```

      Результат:

      ```text
      full address:s:my-cloud-desktop
      gatewayhostname:s:rdg.vdi.cloud.yandex.net:3839
      gatewaycredentialssource:i:5
      gatewayusagemethod:i:1
      gatewayprofileusagemethod:i:1
      gatewayaccesstoken:s:ver=1;desktopUserToken=0174a9f2-...V6DQ
      networkautodetect:i:0
      bandwidthautodetect:i:1
      connection type:i:6
      username:s:.\alice-little
      domain:s:
      bitmapcachesize:i:32000
      smart sizing:i:1
      audiocapturemode:i:1
      audiomode:i:0
      authentication level:i:0
      ```

  1. Сохраните полученные данные в файле с расширением `.rdp`.

- API {#api}

  Воспользуйтесь методом REST API [getRdpFile](../../cloud-desktop/api-ref/Desktop/getRdpFile.md) для ресурса [Desktop](../../cloud-desktop/api-ref/Desktop/index.md) или вызовом gRPC API [DesktopService/GetRdpFile](../../cloud-desktop/api-ref/grpc/Desktop/getRdpFile.md).

  Чтобы сбросить пароль, воспользуйтесь методом REST API [resetPassword](../../cloud-desktop/api-ref/Desktop/resetPassword.md) для ресурса [Desktop](../../cloud-desktop/api-ref/Desktop/index.md) или вызовом gRPC API [DesktopService/ResetPassword](../../cloud-desktop/api-ref/grpc/Desktop/resetPassword.md).

{% endlist %}
