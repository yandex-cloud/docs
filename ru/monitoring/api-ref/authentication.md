---
title: "Аутентификация в API {{ monitoring-full-name }}"
description: "Для выполнения операций через API {{ monitoring-full-name }} необходимо получить IAM-токен для своего аккаунта. Полученный IAM-токен указывайте при обращении к ресурсам {{ yandex-cloud }} через API в формате — Authorization: Bearer <IAM-TOKEN>"
---

# Аутентификация в API {{ monitoring-name }}

{% if audience == "external" %}

{% include notitle [auth](../../_includes/authentication.md) %}

{% endif %}

{% if audience == "internal" %}

Доступ к API разрешается только после успешной аутентификации. На данный момент поддерживается аутентификация при помощи [OAuth-токенов](https://wiki.yandex-team.ru/oauth/), IAM-токенов Яндекс.Облака и [TVM-тикетов](https://wiki.yandex-team.ru/passport/tvm2/).


## OAuth

{% note info %}

Аутентификация по OAuth-токенам поддерживается только в инсталляциях Solomon [в «большом» Яндексе](../overview/clusters.md#yandex-clusters) и не поддерживается в инстялляциях в Яндекс.Облаке.

{% endnote %}

Чтобы получить персональный OAuth-токен перейдите [по ссылке](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=1c0c37b3488143ff8ce570adb66b9dfa) или зарегистрируйте в [oauth.yandex-team.ru](https://oauth.yandex-team.ru) собственное приложение с правами доступа до Solomon. Подробнее про регистрацию клиентских приложений и получение OAuth-токенов можно прочитать в [документации OAuth](https://yandex.ru/dev/oauth/doc/dg/concepts/about-docpage/).

OAuth-токен следует передавать в заголовке `Authorization` с каждым HTTP-запросом. Например так:

```bash
curl -H 'Authorization: OAuth ${OAUTH_TOKEN}' http://solomon.yandex.net/api/v2/...
```

## IAM

{% note info %}

Аутентификация по IAM-токенам поддерживается только в инстялляциях Solomon [в Яндексе.Облаке](../overview/clusters.md#yandex-cloud-clusters) и не поддерживается в инстялляциях в «большом» Яндексе.

{% endnote %}


Чтобы получить персональный IAM-токен, выполните следующие шаги:
1. Установите утилиту `yc` (не путать с утилитой `yc-cli`) [по инструкции с сайта Яндекс.Облака](https://cloud.yandex.ru/docs/cli/quickstart).
1. Выполните следующую команду, чтобы получить токен для соответствующего окружения Яндекс.Облака:

    {% list tabs %}

    - Prod

      ```bash
      yc init
      ```

    - Preprod

      ```bash
      yc init --endpoint api.cloud-preprod.yandex.net:443
      ```

    {% endlist %}

    {% note info %}

    Если выполнение комады `yc init` возвращает ошибку вида `"ERROR: Unable to list clouds: iam token create failed: rpc error: code = Unauthenticated desc = User does not registered in Yandex.cloud"`, то авторизуйтесь на [cloud.yandex.ru](https://cloud.yandex.ru) почтой, привязанной к рабочему аккаунту на Стаффе, после чего попробуйте снова.

    {% endnote %}

1. Получите токен, выполнив команду `export IAM_TOKEN=$(yc iam create-token)`. Токен будет записан в переменную окружения `IAM_TOKEN`.

IAM-токен следует передавать в заголовке `Authorization` с каждым HTTP-запросом. Например так:

```bash
curl -H 'Authorization: Bearer ${IAM_TOKEN}' http://solomon.yandex.net/api/v2/...
```

## TVM

{% note info %}

Аутентификация по TVM-тикетам поддерживается только в инстялляциях Solomon [в «большом» Яндексе](../overview/clusters.md#yandex-clusters) и не поддерживается в инстялляциях в Яндекс.Облаке.

{% endnote %}


Номера TVM-приложений Solomon перечислены в Таблице 1 или в [ABC](https://abc.yandex-team.ru/services/passp/resources/?search=solomon&state=requested&state=approved&state=granted&view=supplying).

<small>Таблица 1 — Идентификаторы и названия TVM-приложений Solomon.</small>

Кластер Solomon | Название приложения | Идентификатор приложения<br/>(TVM client id)
-------|---------|------------
Solomon Production | solomon | 2010242
Solomon Prestable | solomon-prestable  | 2010240
Solomon Testing | solomon-test | 2010238


### User-ticket

Пользовательский TVM-тикет следует передавать в заголовке `X-Ya-User-Ticket`. Получить такой тикет можно только в BlackBox в обмен на sessionid. Подробнее о получении пользовательских тикетов можно прочитать в [документации TVM](https://wiki.yandex-team.ru/passport/tvm2/user-ticket/#2-vypisyvaemuser-tikety).

```bash
curl -H 'X-Ya-User-Ticket: <ticket>' http://solomon.yandex.net/api/v2/...
```

### Service-ticket

Cервисный TVM-тикет следует передавать в заголовке `X-Ya-Service-Ticket`. Подробнее о получении сервисных тикетов можно прочитать в [документации TVM](https://wiki.yandex-team.ru/passport/tvm2/stbrief/#kakmozhnovypisattiket).

```bash
curl -H 'X-Ya-Service-Ticket: <ticket>' http://solomon.yandex.net/api/v2/...
```


### Авторизация при использовании TVM

В случае использования TVM-тикетов права на доступ в проект должны выдаваться следующим образом:
  * **User-ticket** — пользователю, от имени которого сервис обращается в API Solomon;
  * **Service-ticket** — фиктивному пользователю `tvm-not_var{{your_tvm_client_id}}` (например: `tvm-2010238`).


### Аутентификация в gRPC

Для аутентификации в gRPC API необходимо передавать gRPC заголовок такой же как и в REST API.

{% endif %}
