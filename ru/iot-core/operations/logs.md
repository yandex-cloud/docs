# Просмотр журнала подключений

Журнал содержит информацию о подключении и отключении устройств, а также о возникающих ошибках. Вы можете посмотреть журналы подключений [реестра](#registry) и [устройства](#device). Время указано по [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).

## Посмотрите журнал подключений реестра {#registry}

В журнале подключений реестра отображаются операции, которые проведены с сертификатом этого реестра. Операции устройств, принадлежащих этому реестру, не попадают в данный журнал.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите посмотреть журнал подключений реестра.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
    1. Выберите в списке реестр с нужным устройством.
    1. В левой части окна выберите раздел **{{ ui-key.yacloud.common.logs }}**.
   
- CLI {#cli}

  {% include [timeslot](../../_includes/functions/timeslot.md) %}

  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. [Получите](registry/registry-list.md##registry-list) список реестров в каталоге.

  1. Посмотрите журнал подключений реестра:
  
        ```
        yc iot registry logs my-registry
        ```
		
        Результат:
        ```
        2019-09-19 18:51:02     connected, cert: "94ea0421199ec70f1f3d359a1c167a81de4cf6ec", address: "77.88.15.128:53171", clientID: "YCCmdLine"
        2019-09-19 18:51:02     some of subscriptions failed: not allowed to subscribe: ["$device/areqjd6un3afc3cefcvm/events"]
        2019-09-19 18:52:30     disconnected: client disconnected
        2019-09-19 18:52:36     connected, cert: "94ea0421199ec70f1f3d359a1c167a81de4cf6ec", address: "77.88.15.128:53198", clientID: "YCCmdLine"
        2019-09-19 18:52:36     some of subscriptions failed: not allowed to subscribe: ["$device/areqjd6un3afc3cefcvm/events"]
        2019-09-19 18:52:54     disconnected: client disconnected
        2019-09-19 18:52:58     connected, cert: "94ea0421199ec70f1f3d359a1c167a81de4cf6ec", address: "77.88.15.128:53209", clientID: "YCCmdLine"
        2019-09-19 18:53:32     disconnected: client disconnected
        ```
  
{% endlist %}

## Посмотрите журнал подключений устройства {#device}

В журнале подключений устройства отображаются операции, которые проведены с сертификатом этого устройства.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите посмотреть журнал подключений устройства.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
    1. Выберите в списке реестр с нужным устройством.
    1. В левой части окна выберите раздел **{{ ui-key.yacloud.iot.label_devices }}**.
    1. Выберите в списке нужное устройство.
    1. В левой части окна выберите раздел **{{ ui-key.yacloud.common.logs }}**.

- CLI {#cli}

    {% include [timeslot](../../_includes/functions/timeslot.md) %}

    {% include [cli-install](../../_includes/cli-install.md) %}
  
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. [Получите](device/device-list.md##device-list) список устройств в реестре.

    2. Посмотрите журнал подключений устройства:

        ```
        yc iot devices logs my-device
        ```

        Результат:
        ```
        2019-09-19 18:52:03     connected, cert: "ea7bd563e2352ad87e2aca529cfe3d0c3255281c", address: "77.88.15.128:53189", clientID: "YCCmdLine"
        2019-09-19 18:52:03     disconnected: publish to topic "$device/areqjd6un3afc3cefcvm/events" not allowed
        2019-09-19 18:52:38     connected, cert: "ea7bd563e2352ad87e2aca529cfe3d0c3255281c", address: "77.88.15.128:53201", clientID: "YCCmdLine"
        2019-09-19 18:52:38     disconnected: publish to topic "$device/areqjd6un3afc3cefcvm/events" not allowed
        2019-09-19 18:52:51     connected, cert: "ea7bd563e2352ad87e2aca529cfe3d0c3255281c", address: "77.88.15.128:53206", clientID: "YCCmdLine"
        2019-09-19 18:52:51     disconnected: client disconnected
        2019-09-19 18:53:01     connected, cert: "ea7bd563e2352ad87e2aca529cfe3d0c3255281c", address: "77.88.15.128:53213", clientID: "YCCmdLine"
        2019-09-19 18:53:01     disconnected: client disconnected
        2019-09-19 18:53:03     connected, cert: "ea7bd563e2352ad87e2aca529cfe3d0c3255281c", address: "77.88.15.128:53217", clientID: "YCCmdLine"
        2019-09-19 18:53:03     disconnected: client disconnected
        2019-09-19 18:53:04     connected, cert: "ea7bd563e2352ad87e2aca529cfe3d0c3255281c", address: "77.88.15.128:53220", clientID: "YCCmdLine"
        2019-09-19 18:53:04     disconnected: client disconnected
        ```
  
{% endlist %}