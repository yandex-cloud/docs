{% note info %}

Данные способы получения [IAM-токена](../../concepts/authorization/iam-token.md) предназначены для выполнения запросов от имени пользовательского [аккаунта на Яндексе](../../concepts/users/accounts.md#passport) и не рекомендуются для автоматизированных решений. Если вы хотите автоматизировать работу с API {{ yandex-cloud }} и получать IAM-токены программно, ознакомьтесь с разделом [{#T}](create-for-sa.md).

{% endnote %}

# Получение IAM-токена для аккаунта на Яндексе

IAM-токен для аккаунта на Яндексе можно получить [с помощью CLI](#via-cli). Для этого необходимо установить [YC CLI](../../../cli/index.md).

{% note info %}

[Время жизни](../../concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше {{ iam-token-lifetime }}, но рекомендуется запрашивать его чаще, например каждый час.

Для автоматического перевыпуска IAM-токена можно использовать скрипт `export IAM_TOKEN=$(yc iam create-token)`.

{% endnote %}


## Получить IAM-токен с помощью YC CLI {#via-cli}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

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

Полученный IAM-токен указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передайте IAM-токен в заголовке `Authorization` в следующем формате:

```yaml
Authorization: Bearer <IAM-токен>
```

Если вы записали IAM-токен в переменную, используйте ее:

```yaml
Authorization: Bearer ${IAM_TOKEN}
```


## Пример использования IAM-токена, полученного с помощью CLI {#use-cli}

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
       https://resource-manager.{{ api-host }}/resource-manager/v1/clouds
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
       https://resource-manager.{{ api-host }}/resource-manager/v1/clouds 
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


#### См. также {#see-also}

* [Использовать IAM-токен в Helm-чарте](../../../container-registry/operations/helm-chart/helm-chart-push.md)
* [Отозвать IAM-токен](revoke-iam-token.md)