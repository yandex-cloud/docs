# Настройка SMTP-сервера для отправки уведомлений по электронной почте

# Настройка SMTP-сервера для отправки уведомлений по электронной почте

{% note warning %}

Руководство тестировалось на кластерах с версией Apache Airflow™ ниже 3.0.

{% endnote %}

Вы может настроить SMTP-сервер для отправки уведомлений по электронной почте с помощью [направленного ациклического графа (DAG)](../concepts/index.md#about-the-service). Данные для подключения к БД хранятся в Yandex Lockbox и автоматически подставляются в граф.

Чтобы реализовать настройку SMTP-сервера для отправки уведомлений по электронной почте:

1. [Подготовьте инфраструктуру](#create-infrastracture).
1. [Создайте секрет Yandex Lockbox](#create-lockbox-secret).
1. [Подготовьте DAG-файл и запустите граф](#dag).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for Apache Airflow™: вычислительные ресурсы компонентов кластера ([тарифы Managed Service for Apache Airflow™](../../managed-airflow/pricing.md)).
* Бакет Yandex Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* Секрет Yandex Lockbox: количество хранимых версий секрета и запросы к ним ([тарифы Yandex Lockbox](../../lockbox/pricing.md)).


## Подготовьте инфраструктуру {#create-infrastracture}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) `airflow-sa` с ролями:
   * `managed-airflow.integrationProvider`;
   * `lockbox.payloadViewer`.

   {% note info }

   Роль `lockbox.payloadViewer` не обязательно выдавать на весь каталог. Достаточно [назначить ее на конкретный секрет Yandex Lockbox](../../lockbox/operations/secret-access.md) после его создания.

   {% endnote %}

1. [Создайте бакет Object Storage](../../storage/operations/buckets/create.md) с произвольными настройками.
1. [Отредактируйте ACL](../../storage/operations/buckets/edit-acl.md) созданного бакета так, чтобы у сервисного аккаунта `airflow-sa` было разрешение `READ`.
1. [Создайте кластер Managed Service for Apache Airflow™](../operations/cluster-create.md#create-cluster) с параметрами:
   * **Сервисный аккаунт** — `airflow-sa`;
   * **Имя бакета** — имя созданного бакета;
   * **Использовать Lockbox Secret Backend** — убедитесь, что эта опция включена.

   В блоке **Конфигурация Airflow** задайте [дополнительные свойства Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html) для настройки SMTP-сервера:

   | Ключ | Значение |
   | ----- | ----- |
   | `smtp.smtp_host` | `smtp.yandex.ru` |
   | `smtp.smtp_port` | `465` |
   | `smtp.smtp_starttls` | `False` |
   | `smtp.smtp_ssl` | `True` |
   | `smtp.smtp_mail_from` | `user@yandex.ru` |

   Заполните поля вручную или загрузите конфигурацию из файла ([пример конфигурационного файла](https://storage.yandexcloud.net/doc-files/managed-airflow/airflow.cfg)).

## Создайте секрет Yandex Lockbox {#create-lockbox-secret}

[Создайте секрет Yandex Lockbox](../../lockbox/operations/secret-create.md) с именем `airflow/connections/smtp_default` и содержимым `json.dumps(conn)`, где `conn` — подключение к SMTP-серверу.

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

1. Загрузите DAG-файл `test_smtp_notification.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе Apache Airflow™ автоматически.

1. [Откройте веб-интерфейс Apache Airflow™](../operations/af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `test_smtp_notification`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе Apache Airflow™:

1. В разделе **DAGs** откройте граф `test_smtp_notification`.
1. Перейдите в раздел **Graph**.
1. Выберите задание **failing_task**.
1. Перейдите в раздел **Logs**.
1. Убедитесь, что в логах отсутствует строка `some test error`. Это значит, что запрос выполнен успешно.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).
1. [Бакет Object Storage](../../storage/operations/buckets/delete.md).
1. [Кластер Managed Service for Apache Airflow™](../operations/cluster-delete.md#delete).
1. [Секрет Yandex Lockbox](../../lockbox/operations/secret-delete.md).