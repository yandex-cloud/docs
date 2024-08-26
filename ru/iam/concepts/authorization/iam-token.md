# IAM-токен

IAM-токен — уникальная последовательность символов, которая выдается пользователю после прохождения аутентификации.

## Использование токена {#use}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

Для работы с {{ TF }} [добавьте IAM-токен в переменные окружения](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) или укажите его в [конфигурационном файле с настройками провайдера](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider):

```hcl
provider "yandex" {
  token = "<IAM-токен>"
}
```

Если пользователь работает через консоль управления или интерфейс командной строки (CLI), то процесс получения и использования токена незаметен для пользователя.

## Время жизни {#lifetime}

IAM-токен действует не больше {{ iam-token-lifetime }}. Время жизни токена содержится в ответе сервиса, который вернул токен, например, [сервис метаданных ВМ](../../../compute/operations/vm-connect/auth-inside-vm.md).

Чтобы не возникла ситуация, когда токен прекратил действовать, а новый вы еще не получили, запрашивайте токен заранее.

Если вы создадите новый {{ iam-short-name }}-токен, старый продолжит действовать, пока не закончится его время жизни.

Если токен создан с использованием cookie (например, при [аутентификации с помощью федерации](../../../cli/operations/authentication/federated-user.md)), то его время жизни ограничено временем жизни cookie. Если отозвать cookie (например, пользователь разлогинится), то все токены, которые были созданы для cookie, будут аннулированы.

API сервиса {{ iam-short-name }} может вернуть один и тот же токен на разные запросы, если его время жизни еще велико.

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
