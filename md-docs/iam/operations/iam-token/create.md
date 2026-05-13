{% note info %}

Данные способы получения [IAM-токена](../../concepts/authorization/iam-token.md) предназначены для выполнения запросов от имени пользовательского [аккаунта на Яндексе](../../concepts/users/accounts.md#passport) и не рекомендуются для автоматизированных решений. Если вы хотите автоматизировать работу с API Yandex Cloud и получать IAM-токены программно, ознакомьтесь с разделом [Получение IAM-токена для сервисного аккаунта](create-for-sa.md).

{% endnote %}

# Получение IAM-токена для аккаунта на Яндексе

IAM-токен для аккаунта на Яндексе можно получить двумя способами:

* [С помощью CLI](#via-cli) (рекомендуется) — наиболее безопасный способ. Для получения IAM-токена необходимо установить [YC CLI](../../../cli/index.md).
* [С помощью OAuth-токена](#exchange-token) — наиболее простой способ. Получите [OAuth-токен](../../concepts/authorization/oauth-token.md), который есть у каждого аккаунта на Яндексе, и обменяйте его на IAM-токен, используя любой удобный HTTP-клиент, например cURL или PowerShell.

{% note info %}

[Время жизни](../../concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше 12 часов, но рекомендуется запрашивать его чаще, например каждый час.

{% endnote %}


## Получить IAM-токен с помощью YC CLI {#via-cli}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Аутентифицируйтесь в CLI от имени пользователя](../../../cli/operations/authentication/user.md).
  1. Получите IAM-токен:

      ```bash
      yc iam create-token
      ```

      Результат:

      ```text
      t1.9euelZrLop7Uz8up********
      ```

      Полученное значение — это IAM-токен. Вы можете скопировать и сохранить его в файле или записать в переменную:

      ```bash
      export IAM_TOKEN=`<IAM-токен>`
      ```

{% endlist %}

Полученный IAM-токен указывайте при обращении к ресурсам Yandex Cloud через API. Передайте IAM-токен в заголовке `Authorization` в следующем формате:

```yaml
Authorization: Bearer <IAM-токен>
```

Если вы записали IAM-токен в переменную, используйте ее:

```yaml
Authorization: Bearer ${IAM_TOKEN}
```


### Пример использования IAM-токена, полученного с помощью CLI {#use-cli}

Выполнение запроса на получение списка облаков с помощью IAM-токена:

{% list tabs group=programming_language %}
   
- Bash {#bash}

  1. Получите и запишите IAM-токен в переменную:

     ```bash
     export IAM_TOKEN=`yc iam create-token`
     ```

  1. Выполните запрос на получение списка облаков:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
     ```

  1. Результат:
   
     ```bash
     {
     "clouds": [
       {
       "id": "b1gia87mbaom********",
       "createdAt": "2019-08-19T06:15:54Z",
       "name": "my-cloud-1",
       "organizationId": "my-organization"
       },
       {
       "id": "b1gue7m154kt********",
       "createdAt": "2022-08-29T13:27:03Z",
       "name": "my-cloud-2",
       "organizationId": "my-organization"
       }
     ]
     }
     ```

- PowerShell {#powershell}

  1. Получите и запишите IAM-токен в переменную:

     ```powershell
     $IAM_TOKEN=yc iam create-token
     ```

  1. Выполните запрос на получение списка облаков:

     ```powershell
     curl.exe ` 
       --request GET ` 
       --header "Authorization: Bearer $IAM_TOKEN" ` 
       https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds 
     ```

  1. Результат:

     ```powershell
     {
     "clouds": [
       {
       "id": "b1gia87mbaom********",
       "createdAt": "2019-08-19T06:15:54Z",
       "name": "my-cloud-1",
       "organizationId": "my-organization"
       },
       {
       "id": "b1gue7m154kt********",
       "createdAt": "2022-08-29T13:27:03Z",
       "name": "my-cloud-2",
       "organizationId": "my-organization"
       }
     ]
     }
     ``` 
   
{% endlist %}


## Получить и обменять OAuth-токен на IAM-токен {#exchange-token}

{% note alert %}

Если вы владелец облака и работаете через API со своего аккаунта, помните — владелец облака может выполнять любые операции с ресурсами в облаке.

Рекомендуем выполнять операции от имени сервисного аккаунта, которому вы можете назначить только необходимые для работы роли.

{% endnote %}

1. [Войдите](https://passport.yandex.ru/auth) в ваш аккаунт на Яндексе.
1. Получите [OAuth-токен](../../concepts/authorization/oauth-token.md) в сервисе Яндекс.OAuth. Для этого перейдите по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb), нажмите **Разрешить** и скопируйте полученный OAuth-токен.
1. Обменяйте OAuth-токен на [IAM-токен](../../concepts/authorization/iam-token.md):

   {% list tabs group=programming_language %}
   
    - Bash {#bash}

      ```bash
      curl \
        --request POST \
        --data '{"yandexPassportOauthToken":"<OAuth-токен>"}' \
        https://iam.api.cloud.yandex.net/iam/v1/tokens
      ```

    - PowerShell {#powershell}

      ```powershell
      $yandexPassportOauthToken = "<OAuth-токен>"
      $Body = @{ yandexPassportOauthToken = "$yandexPassportOauthToken" } | ConvertTo-Json -Compress
      Invoke-RestMethod -Method 'POST' -Uri 'https://iam.api.cloud.yandex.net/iam/v1/tokens' -Body $Body -ContentType 'Application/json' | Select-Object -ExpandProperty iamToken
      ```

   {% endlist %}

Полученный IAM-токен указывайте при обращении к ресурсам Yandex Cloud через API. Передайте IAM-токен в заголовке `Authorization` в следующем формате:

```yaml
Authorization: Bearer <IAM-токен>
```

Если вы записали IAM-токен в переменную, используйте ее:

```yaml
Authorization: Bearer ${IAM_TOKEN}
```


#### См. также {#see-also}

* [Использовать IAM-токен в Helm-чарте](../../../container-registry/operations/helm-chart/helm-chart-push.md)
* [Отозвать IAM-токен](revoke-iam-token.md)