* `--security-group-ids` — список идентификаторов [групп безопасности](../../../../managed-airflow/concepts/network.md#security-groups).
* `--webserver`, `--scheduler`, `--worker`, `--triggerer` — конфигурация [компонентов](../../../../managed-airflow/concepts/index.md#components) {{ maf-name }}:

    * `count` — количество экземпляров в кластере для веб-сервера, планировщика и Triggerer.
    * `min-count`, `max-count` — минимальное и максимальное количество экземпляров в кластере для воркера.
    * `resource-preset-id` — [идентификатор вычислительных ресурсов](../../../../managed-airflow/concepts/index.md#presets) веб-сервера, планировщика, воркера и службы Triggerer. Возможные значения:

        * `c1-m2` — 1 vCPU, 2 ГБ RAM.
        * `c1-m4` — 1 vCPU, 4 ГБ RAM.
        * `c2-m4` — 2 vCPU, 4 ГБ RAM.
        * `c2-m8` — 2 vCPU, 8 ГБ RAM.
        * `c4-m8` — 4 vCPU, 8 ГБ RAM.
        * `c4-m16` — 4 vCPU, 16 ГБ RAM.
        * `c8-m16` — 8 vCPU, 16 ГБ RAM.
        * `c8-m32` — 8 vCPU, 32 ГБ RAM.

* `--deb-packages`, `--pip-packages` — списки deb- и pip-пакетов, которые позволяют установить в кластер дополнительные библиотеки и приложения для запуска DAG-файлов.

    При необходимости задайте ограничения на версии устанавливаемых пакетов, например:

    ```hcl
    --pip-packages "pandas==2.0.2,scikit-learn>=1.0.0,clickhouse-driver~=0.2.0"
    ```

    Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.

* `--dags-bucket` — имя бакета, в котором будут храниться DAG-файлы.
* `--deletion-protection` — включает защиту кластера от непреднамеренного удаления.

    Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

* `--lockbox-secrets-backend` — включает использование секретов в сервисе [{{ lockbox-full-name }}](../../../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../../../../managed-airflow/concepts/impersonation.md#lockbox-integration) {{ AF }}.
* `--airflow-config` — [дополнительные свойства {{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html). Задаются в формате `<раздел_конфигурации>.<ключ>=<значение>`, например:

    ```bash
    --airflow-config core.load_examples=False
    ```

* Параметры логирования:

    * `--log-enabled` — включает логирование. Логи, сгенерированные компонентами {{ AF }}, будут отправляться в {{ cloud-logging-full-name }}.
    * `--log-folder-id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../../../logging/concepts/log-group.md) по умолчанию для этого каталога.
    * `--log-group-id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

        Укажите один из двух параметров: `--log-folder-id` либо `--log-group-id`.

    * `--log-min-level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO` (значение по умолчанию), `WARN`, `ERROR` и `FATAL`.
