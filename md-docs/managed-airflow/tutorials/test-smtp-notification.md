[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Airflow™](../index.md) > [Практические руководства](index.md) > Другие руководства > Настройка SMTP-сервера для отправки уведомлений по электронной почте

# Настройка SMTP-сервера для отправки уведомлений по электронной почте

# Настройка SMTP-сервера для отправки уведомлений по электронной почте

Вы можете настроить SMTP-сервер для отправки уведомлений по электронной почте с помощью [направленного ациклического графа (DAG)](../concepts/index.md#about-the-service). При этом параметры SMTP-сервера хранятся в конфигурации Apache Airflow™, а учетные данные отправителя — в [секрете Yandex Lockbox](../../lockbox/concepts/secret.md#secret).

В руководстве в качестве SMTP-сервера используется Яндекс Почта (`smtp.yandex.ru`). Для проверки отправки уведомлений используется DAG-файл, в котором задача намеренно завершается ошибкой. При возникновении ошибки отправляется уведомление на указанный в DAG-файле адрес электронной почты.

Перед отправкой уведомлений подготовьте почтовый ящик отправителя:

* разрешите доступ к почтовому ящику для почтовых клиентов;
* создайте пароль для внешних приложений.

Чтобы настроить SMTP-сервер для отправки уведомлений по электронной почте:

1. [Подготовьте инфраструктуру](#create-infrastructure).
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

* Кластер Managed Service for Apache Airflow™: вычислительные ресурсы компонентов кластера ([тарифы Managed Service for Apache Airflow™](../pricing.md)).
* Бакет Yandex Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* Секрет Yandex Lockbox: количество хранимых версий секрета и запросы к ним ([тарифы Yandex Lockbox](../../lockbox/pricing.md)).


## Подготовьте инфраструктуру {#create-infrastructure}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) `airflow-sa` с ролями:
   * `managed-airflow.integrationProvider`;
   * `lockbox.payloadViewer`.

   {% note info %}

   Роль `lockbox.payloadViewer` не обязательно выдавать на весь каталог. Достаточно [назначить ее на конкретный секрет Yandex Lockbox](../../lockbox/operations/secret-access.md) после его создания.

   {% endnote %}

1. [Создайте бакет Object Storage](../../storage/operations/buckets/create.md) с произвольными настройками.
1. [Отредактируйте ACL](../../storage/operations/buckets/edit-acl.md) созданного бакета так, чтобы у сервисного аккаунта `airflow-sa` было разрешение `READ`.
1. [Создайте кластер Managed Service for Apache Airflow™](../operations/cluster-create.md#create-cluster) с параметрами:
   * **Сервисный аккаунт** — `airflow-sa`;
   * **Имя бакета** — имя созданного бакета;
   * **Использовать Lockbox Secret Backend** — убедитесь, что эта опция включена.

   В блоке **Конфигурация Airflow** задайте дополнительные свойства Apache Airflow™ для настройки SMTP-сервера:

   | Ключ | Значение |
   | ----- | ----- |
   | `smtp.smtp_host` | `smtp.yandex.ru` |
   | `smtp.smtp_port` | `465` |
   | `smtp.smtp_starttls` | `False` |
   | `smtp.smtp_ssl` | `True` |
   | `smtp.smtp_mail_from` | `<адрес_почты_отправителя>` |

   Заполните поля вручную или загрузите конфигурацию из файла. Чтобы загрузить конфигурацию из файла, нажмите кнопку **Загрузить из файла** и выберите способ загрузки **Текст**. В поле **Содержимое** скопируйте следующую конфигурацию:
   
   {% cut "Конфигурация SMTP-сервера" %}

   ```text
   [smtp]
   smtp_host = smtp.yandex.ru
   smtp_port = 465
   smtp_starttls = False
   smtp_ssl = True
   smtp_mail_from = <адрес_почты_отправителя>
   ```

   {% endcut %}

   Подробнее о параметрах для настройки SMTP-сервера читайте в [документации Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html#smtp).

1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсетей кластера Managed Service for Apache Airflow™.

## Создайте секрет Yandex Lockbox {#create-lockbox-secret}

[Создайте секрет Yandex Lockbox](../../lockbox/operations/secret-create.md) со следующими настройками:

* **Имя** — `airflow/connections/smtp_default`.
* **Тип секрета** — `Пользовательский`.
* **Ключ** — `conn`.
* **Значение** — выберите **Текст** и укажите следующее содержимое:

  ```json
  {
    "conn_type": "smtp",
    "login": "<адрес_почты_отправителя>",
    "password": "<пароль_для_внешних_приложений>"
  }
  ```

## Подготовьте DAG-файл и запустите граф {#dag}

1. Создайте локально файл с именем `test_smtp_notification.py` и скопируйте в него скрипт:

   ```python
   from airflow.decorators import dag, task

   default_args = {
    "email": ["<адрес_почты_получателя>"],
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
1. Дождитесь, когда задача завершится ошибкой. При этом на указанный адрес электронной почты отправится уведомление.

    {% note warning %}

    Если параметры SMTP-сервера, указанные в конфигурации Apache Airflow™, заданы неверно, уведомления отправляться не будут.

    {% endnote %}

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе Apache Airflow™ версии `2.11`:

1. В разделе **DAGs** откройте граф `test_smtp_notification`.
1. Выберите задачу `failing_task`.
1. На диаграмме **Task Instance Duration** выберите нужный запуск задачи.
1. Перейдите на вкладку **Logs**.
1. Убедитесь, что в логах присутствует строка `Sent an alert email to ['<адрес_почты_получателя>']`.

Чтобы проверить результат в веб-интерфейсе Apache Airflow™ версии `3.1`:

1. В разделе **DAGs** откройте граф `test_smtp_notification`.
1. Перейдите на вкладку **Tasks** и выберите задачу `failing_task`.
1. Перейдите на вкладку **Task Instances** и выберите нужный запуск задачи.
1. Перейдите на вкладку **Logs**.
1. Убедитесь, что в логах присутствует строка `Sent an alert email to ['<адрес_почты_получателя>']`.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).
1. [Бакет Object Storage](../../storage/operations/buckets/delete.md).
1. [Кластер Managed Service for Apache Airflow™](../operations/cluster-delete.md#delete).
1. [Секрет Yandex Lockbox](../../lockbox/operations/secret-delete.md).