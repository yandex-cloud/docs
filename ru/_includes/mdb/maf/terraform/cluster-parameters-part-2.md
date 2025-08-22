* `security_group_ids` — список идентификаторов [групп безопасности](../../../../managed-airflow/concepts/network.md#security-groups).
* `webserver`, `scheduler`, `worker`, `triggerer` — конфигурация [компонентов](../../../../managed-airflow/concepts/index.md#components) {{ maf-name }}:

    * `count` — количество экземпляров в кластере для веб-сервера, планировщика и Triggerer.
    * `min_count`, `max_count` — минимальное и максимальное количество экземпляров в кластере для воркера.
    * `resource_preset_id` — идентификатор вычислительных ресурсов веб-сервера, планировщика, воркера и Triggerer. Возможные значения:

        * `c1-m2` — 1 vCPU, 2 ГБ RAM.
        * `c1-m4` — 1 vCPU, 4 ГБ RAM.
        * `c2-m4` — 2 vCPU, 4 ГБ RAM.
        * `c2-m8` — 2 vCPU, 8 ГБ RAM.
        * `c4-m8` — 4 vCPU, 8 ГБ RAM.
        * `c4-m16` — 4 vCPU, 16 ГБ RAM.
        * `c8-m16` — 8 vCPU, 16 ГБ RAM.
        * `c8-m32` — 8 vCPU, 32 ГБ RAM.

* `deb_packages`, `pip_packages` — списки deb- и pip-пакетов, которые позволяют установить в кластер дополнительные библиотеки и приложения для запуска DAG-файлов.

    При необходимости задайте ограничения на версии устанавливаемых пакетов, например:

    ```hcl
    pip_packages = ["pandas==2.0.2","scikit-learn>=1.0.0","clickhouse-driver~=0.2.0"]
    ```

    Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.

* `code_sync.s3.bucket` — имя бакета, в котором будут храниться DAG-файлы.

* `maintenance_window` — настройки времени [технического обслуживания](../../../../managed-airflow/concepts/maintenance.md) (в т. ч. для выключенных кластеров):

    * `type` — тип технического обслуживания. Принимает значения:
        * `ANYTIME` — в любое время.
        * `WEEKLY` — по расписанию.
    * `day` — день недели для типа `WEEKLY`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
    * `hour` — час дня по UTC для типа `WEEKLY`: от `1` до `24`.

* `deletion_protection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.

    Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

* `lockbox_secrets_backend.enabled` — включает использование секретов в сервисе [{{ lockbox-full-name }}](../../../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../../../../managed-airflow/concepts/impersonation.md#lockbox-integration) {{ AF }}. Возможные значения: `true` или `false`.
* `airflow_config` — [дополнительные свойства {{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html), например: раздел конфигурации — `core`, ключ — `load_examples`, значение — `False`.
* `logging` — параметры логирования:

    * `enabled` — позволяет включить логирование. Логи, сгенерированные компонентами {{ AF }}, будут отправляться в {{ cloud-logging-full-name }}. Возможные значения: `true` или `false`.
    * `folder_id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../../../logging/concepts/log-group.md) по умолчанию для этого каталога.
    * `log_group_id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

      Укажите один из двух параметров: `folder_id` либо `log_group_id`.

    * `min_level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO` (значение по умолчанию), `WARN`, `ERROR` и `FATAL`.