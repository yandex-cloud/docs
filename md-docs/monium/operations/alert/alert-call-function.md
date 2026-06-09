# Webhook с использованием Cloud Functions

Для автоматической обработки инцидентов и других событий в вашем облаке вы можете вызывать в Monium Metrics функции Cloud Functions. В этом разделе приведен пример настройки webhook с отправкой POST-запросов при срабатывании алерта. Таким образом при срабатывании алерта вы можете вызывать методы внешнего API. Так же можно вызывать функции Cloud Functions в [эскалациях](create-escalation.md).

Чтобы отправлять POST-запросы при срабатывании алерта:

1. Разверните сервис для обработки POST-запросов со следующими атрибутами:

   * `https://my.url/route/for/alarm` — URL для обработки запроса, когда алерт переходит в статус `Alarm`;
   * `https://my.url/route/for/ok` — URL для обработки запроса, когда алерт переходит в статус `Ok`;
   * `my_secret_token` — токен или файл с токеном для авторизации вызовов.

    Вы можете проверить работу функции без развертывания сервиса обработки POST-запросов. В этом случае при отправке запроса в логах вызова функции вы увидите сообщение, что указанный URL недоступен.

1. [Создайте сервисный аккаунт](#reate-sa) для вызова функции.
1. [Создайте функцию](#create-function), которая отправляет POST-запросы при переходе алерта в статус `Alarm` и `Ok`.
1. [Создайте канал](#create-alert), который будет вызывать функцию.
1. [Создайте алерт](#create-alert), который будет отправлять уведомления в канал с функцией.
1. [Проверьте работу функции](#test-function).

## Создание сервисного аккаунта {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог с ресурсами, которые надо отслеживать в Monium Metrics.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта, например `sa-alert-webhook`.
  1. Добавьте роли `functions.functionInvoker` и `functions.viewer`.
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Создание функции {#create-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Cloud Functions**.
  1. Нажмите кнопку **Создать функцию**.
  1. Введите имя функции, например `alert-webhook`.
  1. Нажмите кнопку **Создать**.
  1. Создайте [версию функции](../../../functions/concepts/function.md#version):
     1. Выберите среду выполнения **Python**, отключите опцию **Добавить файлы с примерами кода** и нажмите кнопку **Продолжить**.
     1. Выберите способ **Редактор кода**.
      1. Нажмите **Создать файл** и введите имя файла, например `index`.
      1. Введите код функции, указав URL для обработки POST-запросов и токен:
    
            ```python
            import json
            import requests

            WEBHOOK_ALARM_URL = "https://my.url/route/for/alarm"
            WEBHOOK_OK_URL = "https://my.url/route/for/ok"
            WEBHOOK_AUTH_TOKEN = "my_secret_token"

            def webhook(url, alert_id):
                headers_ = {
                    "Authorization": f"OAuth {WEBHOOK_AUTH_TOKEN}",
                    "Content-type": "application/json"
                }
                try:
                    response = requests.post(url, headers = headers_, json = { "alert_id" : alert_id })
                    if response.ok:
                        return { "status": "OK", "url": url, "response": json.dumps(response.json)}
                    else:
                        return { "status": "ERROR", "url": url, "code": response.status_code, "error": response.text}
                except Exception as e:
                    return { "status": "EXCEPTION", "url": url, "error": e}
                

            def handler(event, context):
                alert = event # сохраним event в переменную alert для удобства
                required_attributes = ["alertId", "alertStatus"] # массив с обязательными входными параметрами в формате JSON
                
                # если на вход функции не передан JSON или в нем отсутствуют нужные параметры, функция не выполняется
                if not alert or not all(attr in alert for attr in required_attributes):
                    return
                
                result = None
                # если функция вызвана, когда алерт в статусе ALARM, отправляем запрос на адрес WEBHOOK_ALARM_URL
                # если функция вызвана, когда алерт в статусе OK, отправляем запрос на адрес WEBHOOK_OK_URL
                # при других статусах алерта ничего не вызываем
                if alert["alertStatus"] == "ALARM":
                    result = webhook(WEBHOOK_ALARM_URL, alert["alertId"])
                elif alert["alertStatus"] == "OK":
                    result = webhook(WEBHOOK_OK_URL, alert["alertId"])
                else:
                    pass
                
                if not result:
                    return

                # выводим в лог результат вызова
                if result["status"] == "OK":
                    print(f"Successfully invoked {result['url']}. Response: {result['response']}")
                elif result["status"] == "ERROR":
                    print(f"ERROR invoking {result['url']}. Code {result['code']}, error message: {result['error']}")
                else:
                    print(f"{result['status']} when invoking {result['url']}. Error message: {result['error']}")
            ```
  
  1. В блоке **Параметры** задайте параметры версии:
      * **Точка входа**: `index.handler`.
      * **Сервисный аккаунт**: `sa-alert-webhook`.
  1. В блоке **Дополнительные настройки**:
      1. Включите **Асинхронный вызов**.
      1. Выберите **Сервисный аккаунт** `sa-alert-webhook`.
  1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}

## Создание канала {#create-channel}

{% list tabs group=instructions %}

- Интерфейс Monium {#console}

  1. Перейдите в **Monium** и слева выберите раздел **Способы уведомления**.
  1. Вверху справа нажмите **Создать** → **Канал уведомления**.
  1. Введите имя канала уведомлений, например `channel-function`.
  1. В списке **Метод** выберите ![image](../../../_assets/console-icons/code.svg)  **Cloud Functions**.
  1. В списке **Облачная функция** выберите функцию `alert-webhook`.
  1. В списке **Сервисный аккаунт** выберите аккаунт `sa-alert-webhook`.
  1. Нажмите **Создать**.

{% endlist %}

## Создание алерта {#create-alert}

{% list tabs group=instructions %}

- Интерфейс Monium {#console}

  1. В **Monium** выберите раздел **Алерты**.
  1. Нажмите кнопку **Создать**.
  1. Введите имя алерта, например `alert-function`.
  1. Введите [запрос](../../concepts/alerting/alert.md#queries), по которому будут выбираться метрики для отслеживания.
  1. Настройте [условия срабатывания](../../concepts/alerting/alert.md#condition).
  1. В блоке **Уведомления** нажмите **Редактировать** и затем кнопку **Добавить**.
  1. Выберите канал `channel-function`.
  1. Нажмите кнопку **Добавить**.
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Проверка вызова функции {#test-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Cloud Functions**.
  1. Выберите функцию `alert-webhook`.
  1. Выберите вкладку **Тестирование**.
  1. В качестве входных данных введите:

      ```json
      {
        "alertId": "<идентификатор_алерта>",
        "alertName": "alert-function",
        "folderId": "<идентификатор_каталога>",
        "alertStatus": "OK"
      }
      ```

  1. Нажмите кнопку **Запустить тест**.
  1. В логах вызова функции на вкладке **Тестирование** или **Логи** посмотрите, что запрос был отправлен на URL `https://my.url/route/for/ok`.

{% endlist %}