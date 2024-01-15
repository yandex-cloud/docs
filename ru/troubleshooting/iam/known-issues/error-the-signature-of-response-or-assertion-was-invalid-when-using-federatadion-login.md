# Устранение ошибки The signature of response or assertion was invalid при аутентификации через федеративный аккаунт

## Описание проблемы {#issue-descriprtion}
При попытке использовать федеративную учетную запись для входа в облако отображается сообщение об ошибке:
```
    "title": "The signature of response or assertion was invalid.\n",
    "status": 400,
    "instance": "/federations/bpf...",
    "request-id": "1a0d23..."
```
## Решение {#issue-resolution}
Возможно, сертификат, использующийся для подписи запросов на стороне IdP-провайдера, был обновлен или изменен.
При изменении сертификата на стороне IdP-провайдера, понадобится заменить его и на стороне облачной федерации.

В качестве примера вы можете использовать инструкцию по ручному добавлению в федерацию сертификата из AD FS.
Этот процесс описан на странице [«Аутентификация с помощью Active Directory»](../../../organization/tutorials/federations/integration-adfs.md#add-certificate) в нашей документации.

Также вы можете автоматизировать процесс обновления сертификата с помощью [метода `create`](../../../organization/api-ref/Certificate/create.md) для ресурса `Certificate` либо [средствами YC CLI](../../../cli/quickstart.md#install). 

Для обновления сертификата на стороне федерации средствами YC CLI выполните команду 
```
yc organization-manager federation saml certificate create --federation-name <ИМЯ_ФЕДЕРАЦИИ> \
  --name "my-certificate" \
  --certificate-file test.pem
```

На этой основе можно создать PowerShell-скрипт для автоматизации добавления сертификата в федерацию.
