---
title: Как отправлять запросы на внешний API при срабатывании алерта в {{ monitoring-full-name }}
description: Следуя данной инструкции, вы сможете создать webhook с вызовом функции {{ sf-full-name }}.
---

# Webhook с использованием {{ sf-name }}

Для автоматической обработки инцидентов и других событий в вашем облаке вы можете вызывать в {{ monitoring-full-name }} функции {{ sf-name }}. В этом разделе приведен пример настройки webhook с отправкой POST-запросов при срабатывании алерта. Таким образом при срабатывании алерта вы можете вызывать методы внешнего API. Так же можно вызывать функции {{ sf-name }} в [эскалациях](create-escalation.md).

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

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с ресурсами, которые надо отслеживать в {{ monitoring-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта, например `sa-alert-webhook`.
  1. Добавьте роли `{{ roles-functions-invoker }}` и `{{ roles-functions-viewer }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Создание функции {#create-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Введите имя функции, например `alert-webhook`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Создайте [версию функции](../../../functions/concepts/function.md#version):
     1. Выберите среду выполнения **Python**, отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
     1. Выберите способ **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}**.
      1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}** и введите имя файла, например `index`.
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
                required_attributes = ["alertId", "status"] # массив с обязательными входными параметрами в формате JSON
                
                # если на вход функции не передан JSON или в нем отсутствуют нужные параметры, функция не выполняется
                if not alert or all(attr in required_attributes for attr in alert):
                    return
                
                result = None
                # если функция вызвана, когда алерт в статусе ALARM, отправляем запрос на адрес WEBHOOK_ALARM_URL
                # если функция вызвана, когда алерт в статусе OK, отправляем запрос на адрес WEBHOOK_OK_URL
                # при других статусах алерта ничего не вызываем
                if alert["status"] == "ALARM":
                    result = webhook(WEBHOOK_ALARM_URL, alert["alertId"])
                elif alert["status"] == "OK":
                    result = webhook(WEBHOOK_OK_URL, alert["alertId"])
                else:
                    pass
                
                if not result:
                    return

                # выводим в лог результат вызова
                if result["status"] == "OK":
                    print(f"Succesffully invoked {result['url']}. Response: {result['response']}")
                elif result["status"] == "ERROR":
                    print(f"ERROR invoking {result['url']}. Code {result['code']}, error message: {result['error']}")
                else:
                    print(f"{result['status']} when invoking {result['url']}. Error message: {result['error']}")
            ```
  
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** задайте параметры версии:
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
      * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `sa-alert-webhook`.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-additional-parameters }}** включите **{{ ui-key.yacloud.serverless-functions.item.editor.label_async }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Создание канала {#create-channel}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.channels.title }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.channel.button_new-channel }}**.
  1. Введите имя канала уведомлений, например `channel-function`.
  1. В списке **{{ ui-key.yacloud_monitoring.channel.field_method }}** выберите **{{ sf-name }}**.
  1. В списке **{{ ui-key.yacloud_monitoring.channel.field_service-account_title }}** выберите аккаунт, созданный при добавлении функции.
  1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

## Создание алерта {#create-alert}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В сервисе **{{ monitoring-name }}** выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Введите имя алерта, например `alert-function`.
  1. Введите [запрос](../../concepts/alerting/alert.md#queries), по которому будут выбираться метрики для отслеживания.
  1. Настройте [условия срабатывания](../../concepts/alerting/alert.md#condition).
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** нажмите **Редактировать** и затем кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Выберите канал `channel-function`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Проверка вызова функции {#test-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `alert-webhook`.
  1. Выберите вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. В качестве входных данных введите:

      ```json
      {
        "alertId": "<идентификатор_алерта>",
        "alertName": "alert-function",
        "folderId": "<идентификатор_каталога>",
        "status": "OK"
      }
      ```

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
  1. В логах вызова функции на вкладке **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** или **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** посмотрите, что запрос был отправлен на URL `https://my.url/route/for/ok`.

{% endlist %}