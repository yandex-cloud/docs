# Настройка SMTP-сервера для отправки уведомлений по электронной почте

Вы можете настроить SMTP-сервер для отправки уведомлений по электронной почте с помощью [направленного ациклического графа (DAG)](../../managed-airflow/concepts/index.md#about-the-service). При этом параметры SMTP-сервера хранятся в конфигурации {{ AF }}, а учетные данные отправителя — в [секрете {{ lockbox-full-name }}](../../lockbox/concepts/secret.md#secret).

В руководстве в качестве SMTP-сервера используется Яндекс Почта (`smtp.yandex.ru`). Для проверки отправки уведомлений используется DAG-файл, в котором задача намеренно завершается ошибкой. При возникновении ошибки отправляется уведомление на указанный в DAG-файле адрес электронной почты.

Перед отправкой уведомлений подготовьте почтовый ящик отправителя:

* разрешите доступ к почтовому ящику для почтовых клиентов;
* создайте пароль для внешних приложений.

Чтобы настроить SMTP-сервер для отправки уведомлений по электронной почте:

1. [Подготовьте инфраструктуру](#create-infrastructure).
1. [Создайте секрет {{ lockbox-name }}](#create-lockbox-secret).
1. [Подготовьте DAG-файл и запустите граф](#dag).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ maf-name }}: вычислительные ресурсы компонентов кластера ([тарифы {{ maf-name }}](../../managed-airflow/pricing.md)).
* Бакет {{ objstorage-full-name }}: использование хранилища и выполнение операций с данными ([тарифы {{ objstorage-name }}](../../storage/pricing.md)).
* Секрет {{ lockbox-name }}: количество хранимых версий секрета и запросы к ним ([тарифы {{ lockbox-name }}](../../lockbox/pricing.md)).


## Подготовьте инфраструктуру {#create-infrastructure}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) `airflow-sa` с ролями:
   * `{{ roles.maf.integrationProvider }}`;
   * `lockbox.payloadViewer`.

   {% note info %}

   Роль `lockbox.payloadViewer` не обязательно выдавать на весь каталог. Достаточно [назначить ее на конкретный секрет {{ lockbox-name }}](../../lockbox/operations/secret-access.md) после его создания.

   {% endnote %}

1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md) с произвольными настройками.
1. {% include [aiflow-sa-bucket-acl](../../_includes/managed-airflow/aiflow-sa-bucket-acl.md) %}
1. [Создайте кластер {{ maf-name }}](../../managed-airflow/operations/cluster-create.md#create-cluster) с параметрами:
   * **Сервисный аккаунт** — `airflow-sa`;
   * **Имя бакета** — имя созданного бакета;
   * **{{ ui-key.yacloud.airflow.field_lockbox }}** — убедитесь, что эта опция включена.

   В блоке **{{ ui-key.yacloud.airflow.section_airflow-configuration }}** задайте дополнительные свойства {{ AF }} для настройки SMTP-сервера:

   | Ключ | Значение |
   | ----- | ----- |
   | `smtp.smtp_host` | `smtp.yandex.ru` |
   | `smtp.smtp_port` | `465` |
   | `smtp.smtp_starttls` | `False` |
   | `smtp.smtp_ssl` | `True` |
   | `smtp.smtp_mail_from` | `<адрес_почты_отправителя>` |

   Заполните поля вручную или загрузите конфигурацию из файла. Чтобы загрузить конфигурацию из файла, нажмите кнопку **{{ ui-key.yacloud.airflow.action_button-load-config-from-file }}** и выберите способ загрузки **{{ ui-key.yacloud.component.file-content-dialog.value_manual }}**. В поле **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** скопируйте следующую конфигурацию:
   
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

   Подробнее о параметрах для настройки SMTP-сервера читайте в [документации {{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html#smtp).

1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсетей кластера {{ maf-name }}.

## Создайте секрет {{ lockbox-name }} {#create-lockbox-secret}

[Создайте секрет {{ lockbox-name }}](../../lockbox/operations/secret-create.md) со следующими настройками:

* **{{ ui-key.yacloud.common.name }}** — `airflow/connections/smtp_default`.
* **{{ ui-key.yacloud.lockbox.SecretInfoSection.title_secret-type }}** — `Пользовательский`.
* **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}** — `conn`.
* **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_value }}** — выберите **{{ ui-key.yacloud.lockbox.SecretVersionsInputs.value_payload-entry-value-type-text }}** и укажите следующее содержимое:

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

1. Загрузите DAG-файл `test_smtp_notification.py` в созданный ранее бакет. В результате одноименный граф появится в веб-интерфейсе {{ AF }} автоматически.

1. [Откройте веб-интерфейс {{ AF }}](../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Убедитесь, что в разделе **DAGs** появился новый граф `test_smtp_notification`.

   Загрузка DAG-файла из бакета может занять несколько минут.

1. Чтобы запустить граф, в строке с его именем нажмите кнопку ![image](../../_assets/managed-airflow/trigger-dag.png =18x).
1. Дождитесь, когда задача завершится ошибкой. При этом на указанный адрес электронной почты отправится уведомление.

    {% note warning %}

    Если параметры SMTP-сервера, указанные в конфигурации {{ AF }}, заданы неверно, уведомления отправляться не будут.

    {% endnote %}

## Проверьте результат {#check-result}

Чтобы проверить результат в веб-интерфейсе {{ AF }} версии `2.11`:

1. В разделе **DAGs** откройте граф `test_smtp_notification`.
1. Выберите задачу `failing_task`.
1. На диаграмме **Task Instance Duration** выберите нужный запуск задачи.
1. Перейдите на вкладку **Logs**.
1. Убедитесь, что в логах присутствует строка `Sent an alert email to ['<адрес_почты_получателя>']`.

Чтобы проверить результат в веб-интерфейсе {{ AF }} версии `3.1`:

1. В разделе **DAGs** откройте граф `test_smtp_notification`.
1. Перейдите на вкладку **Tasks** и выберите задачу `failing_task`.
1. Перейдите на вкладку **Task Instances** и выберите нужный запуск задачи.
1. Перейдите на вкладку **Logs**.
1. Убедитесь, что в логах присутствует строка `Sent an alert email to ['<адрес_почты_получателя>']`.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).
1. [Бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
1. [Кластер {{ maf-name }}](../../managed-airflow/operations/cluster-delete.md#delete).
1. [Секрет {{ lockbox-name }}](../../lockbox/operations/secret-delete.md).
