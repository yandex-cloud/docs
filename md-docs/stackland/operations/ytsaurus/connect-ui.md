[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных > YTsaurus > Открыть веб-интерфейс

# Открыть веб-интерфейс YTsaurus

После [включения компонента](enable.md) с параметрами `spec.cluster.ui.enabled: true` и `spec.cluster.ui.ingressEnabled: true` доступен веб-интерфейс YTsaurus.

## Получить адрес веб-интерфейса {#get-url}

Веб-интерфейс публикуется по адресу `https://ytsaurus.<домен_системы>`. Чтобы получить полный адрес, выполните команду:

```bash
kubectl -n stackland-ytsaurus get ingress yt-ui -o jsonpath='{.spec.rules[0].host}'
```

## Войти в веб-интерфейс {#login}

Поддерживаются два способа входа:

* **Локальный администратор** — логин `admin` и пароль из Secret `ytadminsec`. См. инструкцию [Получить пароль и токен администратора](get-admin-credentials.md).
* **Вход через Identity and Access Management** — OAuth-аутентификация через Identity and Access Management. Пользователь должен существовать в Identity and Access Management и иметь доступ к платформе.

Шаги входа:

1. Откройте адрес веб-интерфейса в браузере.
1. На странице входа выберите способ аутентификации:

    * Чтобы войти как локальный администратор, введите логин `admin` и пароль из Secret `ytadminsec`.
    * Чтобы войти через Identity and Access Management, нажмите соответствующую кнопку — браузер перенаправит на страницу авторизации Identity and Access Management.

1. После успешного входа откроется главная страница кластера YTsaurus с именем, заданным в `spec.clusterName`.

## Что дальше {#what-is-next}

* [Подключиться к HTTP-прокси YTsaurus](connect-api.md) — для запросов через YTsaurus CLI и SDK.
* [Документация YTsaurus по веб-интерфейсу](https://ytsaurus.tech/docs/ru/user-guide/storage/web-interface).