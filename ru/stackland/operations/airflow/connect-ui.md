---
title: Открыть веб-интерфейс {{ AF }}
description: Как подключиться к веб-интерфейсу кластера {{ AF }}
---

# Открыть веб-интерфейс {{ AF }}

Для входа потребуются [учетные данные администратора](get-admin-credentials.md). Публичный HTTPS-доступ включен по умолчанию через `spec.publicAccess: true`.

## Публичный доступ {#public-access}

1. Дождитесь состояния `Ready` и получите адрес:

    ```bash
    kubectl get airflowcluster <имя_кластера> \
      -n <пространство_имен> \
      -o jsonpath='{.status.apiServerURL}'
    ```

1. Откройте полученный HTTPS-адрес в браузере.

1. Введите имя пользователя и пароль, полученные по инструкции [Получить учетные данные администратора](get-admin-credentials.md).

Если поле `status.apiServerURL` пустое, проверьте состояние кластера по инструкции [Устранение неполадок](troubleshooting.md#public-access).

## Внутренний доступ {#private-access}

Если `spec.publicAccess: false`, подключитесь к веб-интерфейсу через перенаправление порта:

1. Получите UID нужного кластера:

    ```bash
    kubectl get airflowcluster <имя_кластера> \
      -n <пространство_имен> \
      -o jsonpath='{.metadata.uid}'
    ```

1. Найдите сервис этого кластера, подставив полученный UID:

    ```bash
    kubectl get service \
      -n <пространство_имен> \
      -l 'tier=airflow,component=api-server,airflow.stackland.yandex.cloud/owner-uid=<UID_кластера>'
    ```

1. Перенаправьте локальный порт на найденный сервис:

    ```bash
    kubectl port-forward \
      -n <пространство_имен> \
      service/<имя_сервиса> 8080:8080
    ```

1. Откройте `http://127.0.0.1:8080` и войдите с учетными данными администратора.

Команда работает, пока запущен процесс `kubectl port-forward`.
