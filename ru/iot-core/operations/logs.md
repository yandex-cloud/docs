# Просмотр журнала подключений

Журнал содержит информацию о подключении и отключении устройств, а также о возникающих ошибках. Вы можете посмотреть журналы подключений [устройства](#device) и [реестра](#registry). 

## Посмотрите журнал подключений устройства {#device}

В журнале подключений устройства отображаются операции, которые проведены с сертификатом этого устройства.

Для обращения к [устройству](../concepts/index.md#device) используйте его идентификатор или имя. Как узнать идентификатор или имя устройства, читайте в разделе [{#T}](device/device-list.md).

{% list tabs %}

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Посмотрите журнал подключений устройства: 
  
  ```
  $ yc iot devices logs my-device
  
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

## Посмотрите журнал подключений реестра {#registry}

В журнале подключений реестра отображаются операции, которые проведены с сертификатом этого реестра. Операции устройств, принадлежащих этому реестру, не попадают в данный журнал.

Для обращения к [реестру](../concepts/index.md#registry) используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, читайте в разделе [{#T}](registry/registry-list.md).

{% list tabs %}

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Посмотрите журнал подключений реестра: 
  
  ```
  $ yc iot registry logs my-registry
  
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

