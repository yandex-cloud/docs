# Настройка SMTP-сервера для отправки уведомлений по электронной почте

Вы может настроить SMTP-сервер для отправки уведомлений по электронной почте с помощью [направленного ациклического графа (DAG)](../../managed-airflow/concepts/index.md#about-the-service). Данные для подключения к БД хранятся в {{ lockbox-name }} и автоматически подставляются в граф.

Чтобы реализовать настройку SMTP-сервера для отправки уведомлений по электронной почте:

1. [Подготовьте инфраструктуру](#create-infrastracture).
1. [Создайте секрет {{ lockbox-name }}](#create-lockbox-secret).
1. [Подготовьте DAG-файл и запустите граф](#dag).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру {#create-infrastracture}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) `airflow-sa` с ролями:
   * `{{ roles.maf.integrationProvider }}`;
   * `lockbox.payloadViewer`.

   {% note info }

   Роль `lockbox.payloadViewer` не обязательно выдавать на весь каталог. Достаточно [назначить ее на конкретный секрет {{ lockbox-name }}](../../lockbox/operations/secret-access.md) после его создания.

   {% endnote %}

1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md) с произвольными настройками.
1. {% include [aiflow-sa-bucket-acl](../../_includes/managed-airflow/aiflow-sa-bucket-acl.md) %}
1. [Создайте кластер {{ maf-name }}](../../managed-airflow/operations/cluster-create.md#create-cluster) с параметрами:
   * **Сервисный аккаунт** — `airflow-sa`;
   * **Имя бакета** — имя созданного бакета;
   * **{{ ui-key.yacloud.airflow.field_lockbox }}** — убедитесь, что эта опция включена.

   В блоке **{{ ui-key.yacloud.airflow.section_airflow-configuration }}** задайте [дополнительные свойства {{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html) для настройки SMTP-сервера:

   | Ключ | Значение |
   | ----- | ----- |
   | `smtp.smtp_host` | `smtp.yandex.ru` |
   | `smtp.smtp_port` | `465` |
   | `smtp.smtp_starttls` | `False` |
   | `smtp.smtp_ssl` | `True` |
   | `smtp.smtp_mail_from` | `user@yandex.ru` |

   Заполните поля вручную или загрузите конфигурацию из файла (см. [пример конфигурационного файла](https://{{ s3-storage-host }}/doc-files/managed-airflow/airflow.cfg)).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ maf-name }}: использование вычислительных ресурсов, выделенных хостам, и дискового пространства (см. [тарифы {{ maf-name }}](../../managed-airflow/pricing.md)).
* Плата за использование публичных IP-адресов, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Плата за бакет {{ objstorage-name }}: хранение данных и выполнение операций с ними (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).
* Плата за {{ lockbox-name }}: хранение секретов (см. [тарифы {{ lockbox-name }}](../../lockbox/pricing.md)).


## Создайте секрет {{ lockbox-full-name }} {#create-lockbox-secret}

[Создайте секрет {{ lockbox-name }}](../../lockbox/operations/secret-create.md) с именем `airflow/connections/smtp_default` и содержимым `json.dumps(conn)`, где `conn` — подключение к SMTP-серверу.

```json
conn = {
         "conn_type": "smtp",
         "login": "user@yandex.ru",
         "password": "<пароль_для_внешних_приложений>"
}
```

В секрете `airflow/connections/smtp_default` будут сохранены данные для подключения к SMTP-серверу.

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `test_smtp_notification.py` и скопируйте в него скрипт:

   ```python
   from airflow.decorators import dag, task

   default_args = {
    "email": ["user@yandex.ru"],
    "email_on_failure": True,
    "email_on_retry": True
   }


   @dag(schedule=None, default_args=default_args)
   def test_smtp_notification():
       @task
       def failing_task():
           raise RuntimeError("some test error")

       failing_task()


   test_smtp_notification()
   ```

1. Загрузите DAG-файл `test_smtp_notification.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе {{ AF }} автоматически.

1. [Откройте веб-интерфейс {{ AF }}](../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `test_smtp_notification`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе {{ AF }}:

1. В разделе **DAGs** откройте граф `test_smtp_notification`.
1. Перейдите в раздел **Graph**.
1. Выберите задание **failing_task**.
1. Перейдите в раздел **Logs**.
1. Убедитесь, что в логах отсутствует строка `some test error`. Это значит, что запрос выполнен успешно.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).
1. [Бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
1. [Кластер {{ maf-name }}](../../managed-airflow/operations/cluster-delete.md#delete).
1. [Секрет {{ lockbox-name }}](../../lockbox/operations/secret-delete.md).