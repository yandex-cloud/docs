# Шаги установки

{% note info %}

В примерах описан случай с IPv4, но также возможно использование IPv6.

{% endnote %}

## Шаг 1. Генерация секретов {#step-1}

Выполните шаг на [установочном хосте](environment-preparation.md#installation-host).

1. Выполните команду, указав имя подкаталога в `stands`:

    ```bash
    ./generate_secrets.sh <имя_подкаталога>
    ```

    В указанном подкаталоге будет создан файл `secrets.sls`. Его необходимо изменить только в том случае, если нужно задать сертификаты для S3-API и веб-консоли на этапе установки. Если их не задавать, установка будет выполнена с самоподписанными сертификатами. Их позже можно будет заменить — см. [Обновление сертификатов](../operations/update-certificates.md).

1. Задайте сертификаты, используя поля:

    * `onprem_goose_cert` и `onprem_goose_private_key` для S3-сервиса.
    * `onprem_console_cert` и `onprem_console_private_key` для консоли.


## Шаг 2. Установка Salt {#step-2}

Выполните шаг на [установочном хосте](environment-preparation.md#installation-host).

Выполните команду, указав имя подкаталога в `stands`:

```bash
./setup_hosts.sh my-onprem
```

Скрипт установит и настроит Salt-мастер и Salt-минионов согласно данным, указанным в `env`.


## Шаг 3. Настройка хостов через Salt {#step-3}

Выполните шаг на всех хостах.

1. На каждом хосте выполните команду:

    ```bash
    salt-call -l critical \
      --retcode-passthrough \
      --output-diff \
      --force-color state.highstate queue=True
    ```

    Дождитесь завершения команды.

1. Перезагрузите все хосты стенда.


## Шаг 4. Разметка дисков {#step-4}

Выполните шаг на всех хостах.

1. Создайте логический том `topolvm` на отведенном под метаданные хранилища разделе NVME-диска, выполнив команды:

    ```bash
    pvcreate <раздел>
    vgcreate topolvm <раздел>
    lvcreate -n topolvm topolvm
    ```

1. Подготовьте диски для данных, выполнив команду:

    ```bash
    mds_autosetup -Fs
    ```


## Шаг 5. Загрузка образов в локальный OCI registry {#step-5}

Выполните шаг на master-хосте.

1. Загрузите архив `yc-storage-<версия>.tar.gz`, включенный в поставку, на master-хост OCI Registry. `<версия>` здесь — поставляемая версия `yc-storage-operator`.

1. На том же master-хосте выполните команду:

    ```bash
    /opt/kubernetes/extract-images.sh <путь_к_архиву>
    ```


## Шаг 6. Установка Kubernetes {#step-6}

1. Выполните команду на первом из списка master-хостов Kubernetes:

    ```bash
    cd /opt/kubernetes
    make new-cluster
    ```

    Дождитесь завершения команды.

1. Выполните команду на остальных master-хостах:

    ```bash
    cd /opt/kubernetes
    make new-master
    ```

1. Выполните команду на worker-хостах:

    ```bash
    cd /opt/kubernetes
    make new-node
    ```

1. Проверьте статус с помощью команды:

    ```bash
    cd /opt/kubernetes
    kubectl get nodes
    ```

    Дождитесь, когда все ноды перейдут в состояние `ready`.


## Шаг 7. Установка ArgoCD {#step-7}

Выполните шаг на первом master-хосте Kubernetes.

1. Выполните команду:

    ```bash
    cd /opt/kubernetes
    make argocd
    ```

1. Проверьте статус подов с помощью команды:

    ```bash
    kubectl get pods -n argocd
    ```

    Дождитесь, когда все поды ArgoCD перейдут в статус `Running`.


## Шаг 8. Установка yc-storage-operator {#step-8}

Выполните шаг на первом master-хосте Kubernetes.

1. Выполните команду:

    ```bash
    cd /opt/kubernetes
    make yc-storage-operator
    ```

1. Проверьте статус подов с помощью команды:

    ```bash
    kubectl get pods -n yc-storage-operator
    ```

    Дождитесь, когда все поды оператора перейдут в статус `Running`.


## Шаг 9. Установка On-premises Yandex Object Storage {#step-9}

Выполните шаг на первом master-хосте Kubernetes.


1. Выполните команду:

    ```bash
    cd /opt/kubernetes
    make bootstrap
    ```

    В результате выполнения команды `yc-storage-operator` начнет самостоятельную установку.

1. Проверьте статус установки с помощью команды:

    ```bash
    make show-status
    ```

    Дождитесь завершения установки:

    * `Instance` должен перейти в статус `Ready`.
    * Все `UpdateRequest` должны перейти в статус `Done`.


## Шаг 10. Создание DNS-записей {#step-10}

Выполните шаг в инфраструктуре заказчика.

На [этапе конфигурации](setup-install-params.md) Object Storage были заданы несколько доменов и IP-адресов. Добавьте соответствующие DNS-записи для разрешения имен:

* **S3 API**
    * Список доменов задан в `s3.domains`.
    * IP-адреса заданы в `s3.ips`.
    * В примере предполагается, что записи для первого домена S3 API содержат все IP-адреса для DNS-балансировки, а остальные домены соответствуют отдельным IP-адресам.

* **Веб-консоль**
    * Домен задан в `console.ui.domain`.
    * IP-адрес задан в `console.ui.ip`.

* **gRPC API для CLI**
    * Домен должен быть равен `api-{{ .console.ui.domain }}`
    * IP-адрес задан в `console.grpc.ip`.

* **Grafana и федеративный эндпоинт Prometheus**
    * Можно использовать любые домены.
    * IP-адреса заданы в `metrics`.

#### См. также {#see-also}

* [Устранение неисправностей при установке](../troubleshooting/installation-errors.md)