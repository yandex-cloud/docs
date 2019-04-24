# Обновление версии ClickHouse

Вы можете обновить версию ClickHouse, которую использует кластер. Список доступных для обновления версий можно посмотреть на экране создания или изменения кластера в консоли управления.

> [!NOTE]
>
> Версию ClickHouse нельзя понижать.
> 

## Перед обновлением {#before-update}

Перед обновлением ClickHouse убедитесь, что изменение версии не нарушит работу ваших приложений, использующих базы из кластера:

1. Посмотрите [историю изменений](https://github.com/yandex/ClickHouse/blob/master/CHANGELOG_RU.md) ClickHouse и проверьте, какие из обновлений могут влиять на работу приложений.
1. Попробуйте обновить тестовый кластер. Можно создать новый кластер для тестов, использовать созданный заранее или развернуть тестовый кластер из резервной копии основного кластера. Обратите внимание, что при развертывании кластера из резервной копии восстановятся только таблицы на движке MergeTree.
1. [Создайте резервную копию](cluster-backups.md) основного кластера перед обновлением.

## Запуск обновления {#start-update}

Чтобы обновить версию ClickHouse:

---

**[!TAB Консоль управления]**

1. Откройте страницу сервиса **Managed Service for ClickHouse** в каталоге, где нужно обновить кластер.
1. В списке кластеров выберите тот, который нужно обновить.
1. Нажмите кнопку **Изменить кластер**.
1. В поле **Версия** выберите версию старше текущей.
1. Нажмите кнопку **Сохранить изменения**.

После запуска обновления кластер перейдет в статус `UPDATING`. Дождитесь окончания обновления и проверьте версию кластера.

**[!TAB CLI]**

1. Получите список ваших кластеров ClickHouse:

   ```
   $ yc managed-clickhouse cluster list
   +----------------------+---------------+---------------------+--------+---------+
   |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
   +----------------------+---------------+---------------------+--------+---------+
   | c9q8p8j2gaih8iti42mh | clickhouse691 | 2019-04-23 12:44:17 | ALIVE  | RUNNING |
   +----------------------+---------------+---------------------+--------+---------+
   ```

1. Получите информацию о нужном кластере и проверьте версию ClickHouse в вашем кластере, указанную в параметре `version`:

   ```
   $ yc managed-clickhouse cluster get c9q8p8j2gaih8iti42mh
   id: c9q8p8j2gaih8iti42mh
   folder_id: b1gqs1teo2q2a4vnmi2t
   created_at: "2019-04-23T12:44:17.929853Z"
   name: clickhouse691
   environment: PRODUCTION
   monitoring:
   - name: Console
     description: Console charts
     link: https://console.cloud.yandex.ru/folders/b1gqs1teo2q2a4vnmi2t/managed-clickhouse/cluster/c9q8p8j2gaih8iti42mh?section=monitoring
   config:
     version: "19.1"
     clickhouse:
       config:
         user_config: {}
       resources:
         resource_preset_id: s2.micro
         disk_size: "10737418240"
         disk_type_id: network-nvme
     zookeeper:
       resources: {}
   network_id: enp846vf5fus0nt3lu83
   health: ALIVE
   status: RUNNING
   ```

1. Запустите обновление кластера, указав версию старше имеющейся:

   ```
   $ yc managed-clickhouse cluster update --id c9q8p8j2gaih8iti42mh --version 19.4
   ```

   После запуска обновления кластер перейдет в статус `UPDATING`. Дождитесь окончания обновления и снова проверьте версию кластера.

**[!TAB API]**

Изменить версию ClickHouse для кластера можно с помощью метода API `update`: передайте в запросе нужное значение в параметре `configSpec.clickhouse.config.version`.

---