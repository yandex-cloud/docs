[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Оркестрация данных > Managed Service for Apache Airflow™ > Получить учетные данные администратора Apache Airflow™

# Получить учетные данные администратора Apache Airflow™

Учетные данные администратора хранятся в Secret в пространстве имен `AirflowCluster`.

## Найти Secret {#find-secret}

Чтобы найти Secret с учетными данными нужного кластера:

1. Получите UID кластера:

    ```bash
    kubectl get airflowcluster <имя_кластера> \
      -n <пространство_имен> \
      -o jsonpath='{.metadata.uid}'
    ```

1. Найдите Secret, созданные для этого UID:

    ```bash
    kubectl get secret -n <пространство_имен> \
      -l 'airflow.stackland.yandex.cloud/owner-uid=<UID_кластера>'
    ```

1. Используйте имя Secret с суффиксом `-admin` вместо `<имя_секрета>` в следующих командах.

## Получить имя пользователя {#get-username}

```bash
kubectl get secret <имя_секрета> \
  -n <пространство_имен> \
  -o jsonpath='{.data.username}' | base64 --decode
```

По умолчанию имя пользователя — `admin`.

## Получить пароль {#get-password}

```bash
kubectl get secret <имя_секрета> \
  -n <пространство_имен> \
  -o jsonpath='{.data.password}' | base64 --decode
```

{% note warning %}

Пароль предоставляет административный доступ к кластеру Apache Airflow™. Храните его в защищенном месте и не передавайте через журналы, сообщения или систему контроля версий.

{% endnote %}

## Ротация пароля {#rotate-password}

Чтобы сменить пароль администратора, измените ключ `password` в его Secret. Оператор отслеживает изменения Secret и повторно запускает настройку учетной записи. Ключ `username` изменять нельзя.

{% note warning %}

В текущей поставке новый пароль существующего пользователя может не примениться автоматически. Состояние `Ready` само по себе не подтверждает смену пароля: обязательно проверьте вход с новым значением. Если войти не удалось, воспользуйтесь [инструкцией по восстановлению доступа](troubleshooting.md#admin-password).

{% endnote %}

1. Если кластер приостановлен, [возобновите его](pause-resume.md#resume).

1. Обновите только ключ `password` в [найденном Secret](#find-secret):

    ```bash
    kubectl patch secret <имя_секрета> \
      -n <пространство_имен> \
      --type=merge \
      -p '{"stringData":{"password":"<новый_пароль>"}}'
    ```

1. Дождитесь обработки изменения и возвращения кластера в состояние `Ready`:

    ```bash
    kubectl get airflowcluster <имя_кластера> \
      -n <пространство_имен> \
      -w
    ```

    Если кластер не переходит в `Ready`, проверьте `status.conditions` командой `kubectl describe airflowcluster <имя_кластера> -n <пространство_имен>`. Условие `InitialUserReady` показывает результат настройки учетной записи.

1. Выйдите из веб-интерфейса, затем войдите снова с новым паролем.