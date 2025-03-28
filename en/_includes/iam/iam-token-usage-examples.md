Sending a request to get a list of clouds using an IAM token:

{% list tabs group=programming_language %}
   
- Bash {#bash}

  1. Get an IAM token and write it to the variable:

     ```bash
     export IAM_TOKEN=`yc iam create-token`
     ```

  1. Send a request to get a list of clouds:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       https://resource-manager.{{ api-host }}/resource-manager/v1/clouds
     ```

  1. Result:
   
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

  1. Get an IAM token and write it to the variable:

     ```powershell
     $IAM_TOKEN=yc iam create-token
     ```

  1. Send a request to get a list of clouds:

     ```powershell
     curl.exe ` 
       --request GET ` 
       --header "Authorization: Bearer $IAM_TOKEN" ` 
       https://resource-manager.{{ api-host }}/resource-manager/v1/clouds 
     ```

  1. Result:

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