[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных > YTsaurus > Получить пароль и токен администратора

# Получить пароль и токен администратора YTsaurus

После [включения компонента](enable.md) учетные данные администратора кластера YTsaurus сохраняются в Secret `ytadminsec` в пространстве имен `stackland-ytsaurus`.

Секрет содержит три ключа:

* `login` — логин администратора, всегда `admin`.
* `password` — пароль администратора для входа в [веб-интерфейс YTsaurus](connect-ui.md).
* `token` — токен для доступа к [HTTP-прокси YTsaurus](connect-api.md) через `yt` CLI, SDK и сторонние клиенты.

## Получить логин администратора {#get-login}

```bash
kubectl -n stackland-ytsaurus get secret ytadminsec -o jsonpath='{.data.login}' | base64 -d
```

## Получить пароль администратора {#get-password}

```bash
kubectl -n stackland-ytsaurus get secret ytadminsec -o jsonpath='{.data.password}' | base64 -d
```

## Получить токен администратора {#get-token}

```bash
kubectl -n stackland-ytsaurus get secret ytadminsec -o jsonpath='{.data.token}' | base64 -d
```

{% note warning %}

Токен дает полный административный доступ к кластеру YTsaurus. Храните токен в защищенном месте и не публикуйте его в системах контроля версий, журналах и сообщениях.

{% endnote %}

## Получить все значения сразу {#get-all}

Команда выводит все три ключа Secret в декодированном виде:

```bash
for KEY in login password token; do
  printf '%s: ' "$KEY"
  kubectl -n stackland-ytsaurus get secret ytadminsec -o jsonpath="{.data.$KEY}" | base64 -d
  printf '\n'
done
```