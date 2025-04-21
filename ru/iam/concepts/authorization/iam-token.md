# IAM-токен

IAM-токен — уникальная последовательность символов, которая выдается пользователю после прохождения аутентификации. Получить IAM-токен можно только с помощью [CLI](../../../cli/) или [API](../../../overview/api.md).

## Использование токена {#use}

IAM-токены используются в сервисах {{ yandex-cloud }} для аутентификации. IAM-токен выдается для [аккаунтов на Яндексе](../../operations/iam-token/create.md), [сервисных аккаунтов](../../operations/iam-token/create-for-sa.md) и [федеративных аккаунтов](../../operations/iam-token/create-for-federation.md).

Также IAM-токены используются для аутентификации клиентов [Docker](../../../container-registry/operations/authentication.md) и [Helm](../../../container-registry/operations/helm-chart/helm-chart-push.md) в {{ container-registry-full-name }}.

Если вы работаете через консоль управления или интерфейс командной строки (CLI), то получение и использование токена будет незаметным.

Вы можете использовать IAM-токены для аутентификации при вызовах API к сервисам {{ yandex-cloud }}. Полученный IAM-токен указывайте при обращении к ресурсам {{ yandex-cloud }} через API в заголовке `Authorization` в следующем формате:

```yaml
Authorization: Bearer <IAM-токен>
```

Для работы с {{ TF }} [добавьте IAM-токен в переменные окружения](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) или укажите его в [конфигурационном файле с настройками провайдера](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider):

```hcl
provider "yandex" {
  token = "<IAM-токен>"
}
```

## Время жизни {#lifetime}

IAM-токен действует не больше {{ iam-token-lifetime }}. Время жизни токена содержится в ответе сервиса, который вернул токен, например, [сервис метаданных ВМ](../../../compute/operations/vm-connect/auth-inside-vm.md).

Чтобы не возникла ситуация, когда токен прекратил действовать, а новый вы еще не получили, запрашивайте токен заранее.

Если вы создадите новый {{ iam-short-name }}-токен, старый продолжит действовать, пока не закончится его время жизни или вы не [отзовете](../../operations/iam-token/revoke-iam-token.md) его.

Если токен создан с использованием cookie (например, при [аутентификации с помощью федерации](../../../cli/operations/authentication/federated-user.md)), то его время жизни ограничено временем жизни cookie. Если отозвать cookie (например, пользователь разлогинится), то все токены, которые были созданы для cookie, будут аннулированы.

API сервиса {{ iam-short-name }} может вернуть один и тот же токен на разные запросы, если его время жизни еще велико.

## Отзыв IAM-токена {#revoke}

В случае, если IAM-токен оказался [скомпрометирован](../../operations/compromised-credentials.md), или в целях безопасности вы хотите прекратить действие старого IAM-токена при выпуске нового, IAM-токен можно [отозвать](../../operations/iam-token/revoke-iam-token.md) до истечения срока его жизни.

Отозвать IAM-токен может любой аутентифицированный пользователь с помощью [CLI](../../../cli/quickstart.md) или [API](../../api-ref/authentication.md).

## Сервисы, поддерживающие этот способ аутентификации {#supported-services}

Этот способ аутентификации поддерживают все сервисы, кроме сервисов с AWS-совместимым API (в них IAM-токен нужен только для управления [ключами доступа](access-key.md) и [сервисными аккаунтами](../users/service-accounts.md)).

## Представление токена {#iam-token-format}

Следующее регулярное выражение описывает токен:

```javascript
t1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
```

С осторожностью используйте регулярное выражение, так как со временем сервис может обновить формат токена. В документации это изменение может отразиться с задержкой.

{% note tip %}

Если формат токена изменится, изменится префикс — станет не `t1.`.

{% endnote %}

Пример токена:

```text
t1.7euelSbPyceKx87JqpuRl1qZiY-Ryi3rnpWaksrKaZqUppnLncmDnpeajZvl8_dZNAFl-e8ENXMH_t3z9xljfmT57wQ1cwf-.-LErty1vRh4S__VEp-aDnM5huB5MEfm_Iu1u2IzNgyrn0emiWDYA6rSQXDvzjE0O3HBbUlqoDeCmXYYInzZ6Cg
```

#### См. также {#see-also}

* [{#T}](../../operations/iam-token/create.md)
* [{#T}](../../operations/iam-token/create-for-sa.md)
* [{#T}](../../operations/iam-token/create-for-federation.md)
* [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md)
* [{#T}](../../../functions/operations/function-sa.md)
* [{#T}](./index.md)
* [{#T}](../../operations/iam-token/revoke-iam-token.md)