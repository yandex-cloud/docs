# Алгоритмы решения проблем

В этом разделе описаны алгоритмы диагностики и устранения типичных проблем, возникающих при работе с системой.

## Проверка состояния кластера Kubernetes {#k8s-status}

Goose развернут в Kubernetes. При возникновении ошибок, связанных с внутренним функционированием Goose, а не с действиями пользователя, начинайте диагностику с проверки статуса всех нод и подов в кластере. Отсутствие неработающих подов или нод сужает область поиска проблемы.

Команды для проверки:

```bash
kubectl get nodes
kubectl get pods -A
kubectl get pods -n <пространство_имен> -o wide
```

## Анализ логов в Grafana {#grafana-logs}

1. Перейдите на вкладку **Explore**.
1. В **Datasource** выберите **loki-internal**.
1. Установите **Label** `container=goose-proxy`. В случае, если запрос не доходит до Goose, выберите `container=goose-proxy-nginx`.
1. Нажмите **Run query**.

    Логи поступают с задержкой, поэтому несколько раз нажмите **Run query**, пока не получите нужные данные.

1. На основе сообщений в логах определите причину возникновения ошибок.


## Мониторинг дашбордов {#dashboard-monitoring}

В Grafana существует дашборд, на котором отображаются ошибки в кластере: **Dashboards** → **Cluster monitor**.


## Мониторинг Control plane {#control-plane}

1. Получите список подов Control plane:

    ```bash
    kubectl get pods -n mastermind-migrator
    ```

    Результат:

    ```text
    NAME                           READY   STATUS      RESTARTS   AGE
    mastermind-migrate-job-*****   0/1     Completed   0          17d
    migrator-59468d6***-*****      1/1     Running     0          2d7h
    ```

1. Проверьте состояние нужного пода:

    ```bash
    kubectl exec -it <имя_пода> -n mastermind-migrator  --monrun
    ```

    Результат:

    ```text
    long_jobs 2;Jobs older than 7 days: ['mega_couples_build_job: 1-78ca795d9e3646e2b5d32f1c********']
    future_backends 0;OK
    mastermind-lock-old-jobs 0;Cleaning finished. Locks were served: total 0, bad 0, deleted 0, failed 0
    mastermind-locks-lost 0;Cleaning finished. Locks were served: total 112, bad 0, deleted 0, failed 0
    mm-namespace-space 0;all:OK
    dc_space 0;OK
    couple_broken 0;OK
    couple_bad 0;OK
    couple_lrc_state_bad 0;OK
    bad_groups 0;OK
    couples_diff 1; Created file
    groupset_unavailable_check 0;OK
    bad_data_unavailable 0;OK
    couple_lost 0;OK
    ns-settings-correct 0; Testing
    mandatory_dcs 0;OK
    backend_config_diff 0;OK
    ```


## Диагностика и решение проблем {#errors}

### HTTP 500 Internal Server Error {#http-500}

Ошибка `HTTP 500 Internal Server Error` указывает на внутреннюю ошибку сервера.

**Диагностика**

1. [Проверьте](#k8s-status) статус подов и нод в Kubernetes.
1. [Проверьте](#grafana-logs) логи в Grafana.
1. [Проверьте](#dashboard-monitoring) дашборд **Cluster monitor** в Grafana.
1. Проверьте PostgreSQL:

    ```sql
    SELECT count(*) FROM pg_stat_activity WHERE state = 'active';
    ```

**Решение**

В зависимости от типа ошибки выполните соответствующие действия:

* `ErrNetworkError` — проверьте сетевую связность и настройки подключения.
* `ErrTooManyActiveClients` — увеличьте `max_connections` или проверьте утечки соединений.
* `BucketInTransit` — дождитесь завершения переноса.


### HTTP 429 Too Many Requests {#http-429}

Ошибка `HTTP 429 Too Many Requests` появляется, когда клиент превышает квоту на количество запросов — отправляет слишком много запросов за короткий промежуток времени.

**Диагностика**

Изучите сообщение об ошибке:

```text
Limit exceeded. Request was limited by one of the following quotas: <имя_квоты>
```

Имя квоты тенанта имеет формат `<тенант>:<тип>:<операция>`, где

* `<тенант>` — идентификатор тенанта.
* `<тип>` — тип ограничения:
    * `r` — количество запросов в секунду.
    * `t` — трафик, КБ/с.
* `<операция>` — тип операции:
    * `read` — операции чтения (GET, HEAD, LIST).
    * `write` — операции записи (PUT, POST, DELETE).

Имя квоты бакета имеет формат `s3_p:<тип>_b:<бакет>_nginx-control:<операция>`, где:

* `s3_p` — префикс, указывающий на пространство квот S3.
* `<тип>` — тип ограничения:
    * `r` — количество запросов в секунду.
    * `t` — трафик, КБ/с.
* `<бакет>` — имя бакета, к которому применяется квота.
* `nginx-control` — компонент системы, применяющий квоту.
* `<операция>` — тип операции:
    * `read` — операции чтения (GET, HEAD, LIST).
    * `write` — операции записи (PUT, POST, DELETE).

**Решение**

[Увеличьте](../operations/manage-quotas-rate-limiter.md#update-quota) соответствующую квоту.


### Lock Timeout (55P03) {#lock-timeout}

Ошибка `Lock Timeout (55P03)` возникает при превышении времени ожидания блокировки.

**Диагностика**

1. [Проверьте](#k8s-status) статус подов и нод в Kubernetes.
1. [Проверьте](#grafana-logs) логи в Grafana.
1. Найдите блокирующие запросы через SQL-запрос к `pg_locks` и `pg_stat_activity`.

**Решение**

Используйте `pg_terminate_backend()` для зависших процессов.


### Serialization Failure (40001) {#serialization-failure}

Ошибка `Serialization Failure (40001)` возникает при конфликте сериализации транзакций.

**Диагностика**

1. [Проверьте](#k8s-status) статус подов и нод в Kubernetes.
1. [Проверьте](#grafana-logs) логи в Grafana.
1. Проверьте уровень изоляции транзакций: `SHOW transaction_isolation;`.

**Решение**

* Реализуйте retry с exponential backoff (3–5 попыток).
* Повторите транзакцию.


### Connection Errors (08P01, 57P01, 57P03) {#connection-errors}

Ошибки подключения к базе данных.

**Диагностика**

1. [Проверьте](#k8s-status) статус подов и нод в Kubernetes.
1. [Проверьте](#grafana-logs) логи в Grafana.
1. Проверьте статус кластера, выполнив команду:

    ```bash
    kubectl cnpg -n cnpg-system status <имя_БД>
    ```

    Где `<имя_БД>` — имя вашей базы данных.

**Решение**

* `08P01` — проверьте сетевую связность и настройки подключения.
* `57P01` — проверьте административные операции и логи PostgreSQL.
* `57P03` — проверьте статус кластера, выполните failover на реплику.


### Access Denied (S3A01, S3B03) {#access-denied}

Ошибки доступа к ресурсам S3.

**Диагностика**

1. [Проверьте](#k8s-status) статус подов и нод в Kubernetes.
1. [Проверьте](#grafana-logs) логи в Grafana.
1. Проверьте работу компонентов авторизации и аутентификации.
1. Проверьте политику бакета (bucket policy).
1. Проверьте списки контроля доступа (ACL).

**Решение**

* Убедитесь в корректности учетных данных (credentials).
* Проверьте права доступа к бакету.
* Проверьте политику бакета на наличие правил `Deny`.