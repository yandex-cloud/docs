# Получение IAM-токена для федеративного аккаунта

{% note info %}

Время жизни [IAM-токена](../../concepts/authorization/iam-token.md) — не больше 12 часов и ограничено временем жизни cookie у [федерации](../../../organization/concepts/add-federation.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Аутентифицируйтесь в CLI от имени федеративного пользователя](../../../cli/operations/authentication/federated-user.md).

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

## Примеры {#examples}

### Использование IAM-токена, полученного с помощью CLI {#use-cli}

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

#### Полезные ссылки {#see-also}

* [Отзыв IAM-токена](revoke-iam-token.md)