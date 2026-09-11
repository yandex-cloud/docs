# Управление квотами rate-лимитера

## Подключение к поду yarl {#connect-yarl}

Чтобы управлять квотами, подключитесь к поду `yarl`:

1. Получите список подов в пространстве имен `yarl`:

    ```bash
    kubectl get pods -n yarl
    ```

    Результат:

    ```text
    NAME     READY   STATUS    RESTARTS   AGE
    yarl-0   2/2     Running   0          51m
    yarl-1   2/2     Running   0          51m
    yarl-2   2/2     Running   0          51m
    ```

1. Подключитесь к одному из подов `yarl`:

    ```bash
    kubectl exec -it -n yarl <имя_пода> -- /usr/bin/bash
    ```

    Результат:

    ```text
    Defaulted container "yarl" out of: yarl, yarl-ui, migrate-db (init)
    groups: cannot find name for group ID 1000
    I have no name!@yarl-0:/$ 
    ```

## Создание родительской квоты тенанта {#create-parent-quota}

Чтобы создать родительскую квоту тенанта:

1. [Подключитесь](#connect-yarl) к поду `yarl`.
1. Создайте квоту для тенанта:

    ```bash
    yarl-cli \
      --endpoint localhost:14589 quotas create \
      --space-name s3 \
      --name "<имя_квоты>" \
      --limit <лимит> \
      --low-burst <нижний_порог> \
      --high-burst <верхний_порог> \
      --metered
    ```

    Где:

    * `--space-name` — имя пространства квот (всегда `s3`).
    * `--name` — имя квоты в формате `<тенант>:<тип>:<операция>`, где

        * `<тенант>` — идентификатор тенанта.
        * `<тип>` — тип ограничения:
            * `r` — количество запросов в секунду.
            * `t` — трафик, КБ/с.
        * `<операция>` — тип операции:
            * `read` — операции чтения (GET, HEAD, LIST).
            * `write` — операции записи (PUT, POST, DELETE).

    * `--limit` — основной лимит.
    * `--low-burst` — нижний порог всплеска. Обычно равен `limit`.
    * `--high-burst` — верхний порог всплеска. Обычно равен `limit × 100`.
    * `--metered` — флаг для включения учета потребления.


    Результат:

    ```text
    Epoch: 146
    HierarchicalName: tenant1234_r_read
    HighBurst: 100000
    Id: 26
    Limit: 1000
    LowBurst: 1000
    Metered: true
    MinMeteredUsagePercent: 0
    Name: tenant1234_r_read
    OutflowInterval: 1
    ParentID: 0
    SpaceID: 1
    Status: REGULAR
    Tags:
      tags: {}
    UseDynamicParent: false
    ```

    Сохраните идентификатор родительской квоты (`Id`) из результата команды — он потребуется для прикрепления дочерних квот для бакетов.


## Просмотр квот {#view-quotas}

Чтобы просмотреть квоты:

1. [Подключитесь](#connect-yarl) к поду `yarl`.
1. Выполните команду для просмотра квот:

    ```bash
    yarl-cli monitor quotas --all
    ```

    Результат:

    ```text
    self:
      ID : PARENT ID : STATUS  :                   QUOTA NAME                   : SPACE NAME : EPOCH :   LIMIT    : LOW BURST  :  HIGH BURST   
    -----+-----------+---------+------------------------------------------------+------------+-------+------------+------------+---------------
      27 :        26 : REGULAR :          s3_p:r_b:my-bucket_nginx-control:read :         s3 :   147 :        500 :        500 :        50000
      26 :         0 : REGULAR :                              tenant1234_r_read :         s3 :   146 :       1000 :       1000 :       100000
    ```


## Создание дочерней квоты бакета {#create-child-quota}

Чтобы создать дочернюю квоту бакета:

1. [Подключитесь](#connect-yarl) к поду `yarl`.
1. Создайте квоту для бакета:

    ```bash
    yarl-cli \
      --endpoint localhost:14589 quotas create \
      --parent-id <идентификатор_родительской_квоты> \
      --space-name s3 \
      --name "<имя_квоты>" \
      --limit <лимит> \
      --low-burst <нижний_порог> \
      --high-burst <верхний_порог> \
      --metered
    ```

    Где:

    * `--parent-id` — идентификатор родительской квоты тенанта.
    * `--space-name` — имя пространства квот (всегда `s3`).
    * `--name` — имя квоты в формате `s3_p:<тип>_b:<бакет>_nginx-control:<операция>`, где:

        * `s3_p` — префикс, указывающий на пространство квот S3.
        * `<тип>` — тип ограничения:
            * `r` — количество запросов в секунду.
            * `t` — трафик, КБ/с.
        * `<бакет>` — имя бакета, к которому применяется квота.
        * `nginx-control` — компонент системы, применяющий квоту.
        * `<операция>` — тип операции:
            * `read` — операции чтения (GET, HEAD, LIST).
            * `write` — операции записи (PUT, POST, DELETE).

    * `--limit` — основной лимит.
    * `--low-burst` — нижний порог всплеска. Обычно равен `limit`.
    * `--high-burst` — верхний порог всплеска. Обычно равен `limit × 100`.
    * `--metered` — флаг для включения учета потребления.


## Изменить квоту {#update-quota}

Чтобы изменить существующую квоту:

1. [Подключитесь](#connect-yarl) к поду `yarl`.
1. Измените квоту:

    ```bash
    yarl-cli --endpoint localhost:14589 quotas update \
      --space-name s3 \
      --name "<имя_квоты>" \
      --limit <лимит> \
      --low-burst <нижний_порог> \
      --high-burst <верхний_порог> \
      --metered
    ```

    Где:

    * `--space-name` — имя пространства квот (всегда `s3`).
    * `--name` — имя квоты.
    * `--limit` — основной лимит.
    * `--low-burst` — нижний порог всплеска. Обычно равен `limit`.
    * `--high-burst` — верхний порог всплеска. Обычно равен `limit × 100`.
    * `--metered` — флаг для включения учета потребления.


## Удалить квоту {#delete-quota}

{% note info %}

Чтобы удалить родительскую квоту тенанта, сначала удалите все дочерние квоты бакетов, относящихся к этому тенанту.

{% endnote %}

Чтобы удалить квоту:

1. [Подключитесь](#connect-yarl) к поду `yarl`.
1. Удалите квоту:

    ```bash
    yarl-cli \
      --endpoint localhost:14589 quotas delete \
      --space-name s3 \
      --name "<имя_квоты>"
    ```

    Где:

    * `--space-name` — имя пространства квот (всегда `s3`).
    * `--name` — имя квоты.

    В результате статус квоты изменится на `DELETED` и она перестанет применяться к запросам.