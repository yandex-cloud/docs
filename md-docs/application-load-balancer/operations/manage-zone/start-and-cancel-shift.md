[Документация Yandex Cloud](../../../index.md) > [Yandex Application Load Balancer](../../index.md) > [Пошаговые инструкции](../index.md) > L7-балансировщики > Управление зоной доступности > Отключить и включить зону доступности

# Отключить и включить зону доступности


Когда в одной из [зон доступности](../../../overview/concepts/geo-scope.md) проводится обслуживание или возникают неполадки, специалисты Yandex Cloud могут временно [отключить эту зону](allow-and-deny-shift.md).

Вы также можете отключить одну или несколько зон доступности для решения следующих задач:

* Снижение нагрузки на зону доступности при локальных проблемах. Например, при неудачном релизе приложения на бэкенде или инциденте с вашими ресурсами из-за высокой нагрузки или ошибках в конфигурации. Это позволяет избежать прерывания работы или быстро восстановить функциональность приложения для пользователей.

* Тестирование отказоустойчивости балансировщика и механизма перенаправления трафика. Это помогает выявить потенциальные проблемы, внести исправления и заранее оптимизировать настройки балансировщика.

## Отключить зону доступности {#disable-zones}

{% note warning %}

Если вы используете сетевой или L7-балансировщик в связке с группой ВМ с [автоматическим масштабированием](../../../compute/concepts/instance-groups/scale.md#auto-scale), перед выключением зоны в балансировщике сначала [выключите](../../../compute/operations/instance-groups/disable-enable-zone.md#disable) эту зону для группы ВМ. Если этого не сделать, группа ВМ продолжит создавать ВМ в зоне, в которую не будет поступать трафик.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [L7-балансировщик](../../concepts/application-load-balancer.md).
  1. Перейдите в сервис **Application Load Balancer**.
  1. Выберите L7-балансировщик.
  1. На странице **Обзор** в блоке **Размещение** нажмите кнопку **Настроить блокировку зон**.
  1. Включите блокировку для одной или нескольких зон.
  1. (Опционально) Чтобы задать время автоматического отключения блокировки, активируйте опцию **Отключить блокировку через** и укажите время от `1m` до `72h`. Если время не указано, зона останется заблокированной до ручного включения.

  1. Нажмите кнопку **Сохранить**.

    Балансировщик начнет перенос трафика из заблокированных зон доступности в незаблокированные.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды:

      ```bash
      yc application-load-balancer load-balancer disable-zones --help
      ```

  1. Чтобы начать перераспределение трафика, отключите зону и укажите время блокировки:

      ```bash
      yc application-load-balancer load-balancer disable-zones \
        <имя_или_идентификатор_балансировщика> \
        --zones <зоны_доступности>
        --duration <время_отключения>
      ```

      Где:

      * `<имя_или_идентификатор_балансировщика>` — имя или идентификатор балансировщика.
      * `--zones` — зоны доступности через запятую, которые нужно отключить.
      * `--duration` — время от `1m` до `72h`, на которое будет отключена зона.
      
         По истечении указанного времени зона автоматически восстановится. Если параметр не указан, зона будет отключена до ручного [включения зоны](#enable-zones).
  
      Пример:

      ```bash
      yc application-load-balancer load-balancer disable-zones \
        my-balancer \
        --zones ru-central1-a \
        --duration 1h
      ```

      Результат:

      ```text
      id: ds70q425egoe********
      name: my-balancer
      ...
      allocation_policy:
        locations:
          - zone_id: ru-central1-a
            subnet_id: e2lptlobccu6********
            zonal_shift_active: true
            zonal_traffic_disabled: true
          - zone_id: ru-central1-b
            subnet_id: e9bo5ir5prfi********
      ...
      ```

- API {#api}

  Чтобы отключить зону доступности, воспользуйтесь методом REST API [DisableZones](../../api-ref/LoadBalancer/disableZones.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/DisableZones](../../api-ref/grpc/LoadBalancer/disableZones.md).

{% endlist %}

## Посмотреть время включения зоны доступности {#view-zone-status}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится балансировщик.
  1. Перейдите в сервис **Application Load Balancer** и выберите нужный балансировщик.
  1. В блоке **Размещение** напротив зоны доступности посмотрите ее статус.

      Если была задана длительность блокировки, рядом с зоной будет указано время, до которого она заблокирована.

{% endlist %}

## Включить зону доступности {#enable-zones}

{% note warning %}

Если вы используете сетевой или L7-балансировщик в связке с группой ВМ с [автоматическим масштабированием](../../../compute/concepts/instance-groups/scale.md#auto-scale), перед включением зоны в балансировщике сначала [включите](../../../compute/operations/instance-groups/disable-enable-zone.md#enable) эту зону для группы ВМ, чтобы количество ВМ распределилось по зонам.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [L7-балансировщик](../../concepts/application-load-balancer.md).
  1. Перейдите в сервис **Application Load Balancer**.
  1. Выберите L7-балансировщик.
  1. На странице **Обзор** в блоке **Размещение** нажмите кнопку **Настроить блокировку зон**.
  1. Отключите блокировку зон доступности.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды для включения зоны доступности:

      ```bash
      yc application-load-balancer load-balancer enable-zones --help
      ```

  1. Включите зону доступности:

      ```bash
      yc application-load-balancer load-balancer enable-zones \
        <имя_или_идентификатор_балансировщика> \
        --zones <зоны_доступности>
      ```

      Пример:

      ```bash
      yc application-load-balancer load-balancer enable-zones \
        my-balancer \
        --zones ru-central1-a
      ```
      
      Результат:

      ```text
      id: ds70q425egoe********
      name: my-balancer
      ...
      allocation_policy:
        locations:
          - zone_id: ru-central1-a
            subnet_id: e9bo5ir5prfi********
          - zone_id: ru-central1-b
            subnet_id: e2lptlobccu6******** 
      ...
      ```

- API {#api}

  Чтобы включить зону доступности, воспользуйтесь методом REST API [EnableZones](../../api-ref/LoadBalancer/enableZones.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/EnableZones](../../api-ref/grpc/LoadBalancer/enableZones.md).

{% endlist %}

{% note info %}

Ранее для включения и отключения зоны доступности использовались команды CLI `start-zonal-shift`, `cancel-zonal-shift` и методы API `StartZonalShift`, `CancelZonalShift`. Сейчас они устарели и будут удалены в ближайшее время.

{% endnote %}

#### Полезные ссылки {#see-also}

* [Отключить и включить зоны доступности для группы ВМ Yandex Compute Cloud](../../../compute/operations/instance-groups/disable-enable-zone.md)
* [Отключить и включить зоны доступности в Yandex Network Load Balancer](../../../network-load-balancer/operations/manage-zone/disable-enable-zone.md)