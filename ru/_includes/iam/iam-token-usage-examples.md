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