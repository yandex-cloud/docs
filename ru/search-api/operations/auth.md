# Аутентификация в {{ search-api-full-name }}

Для работы с {{ search-api-name }} необходимо отправлять запросы к API от имени сервисного аккаунта. {{ search-api-name }} поддерживает только аутентификацию с помощью [API-ключей](../../iam/concepts/authorization/api-key.md).

{% note warning %}

API-ключи не имеют срока действия. Если ваш ключ мог быть скомпрометирован, отзовите его и выпустите новый. 

{% endnote %}

1. [Получите идентификатор каталога](../../resource-manager/operations/folder/get-id.md) сервисного аккаунта.
1. [Получите API-ключ](../../iam/operations/api-key/create.md).
1. Полученные значения передавайте в каждом запросе. 
   
   * Для [POST-запросов](../concepts/post-request.md) передавайте значения идентификатора каталога и API-ключа в заголовке `Authorization` в следующем формате:

     ```curl
     Authorization: Api-Key <API-ключ>
     ```

   * Для [GET-запросов](../concepts/get-request.md) передавате значения идентификатора каталога и API-ключа в полях `folderid` и `apikey` запроса:
   
     ```curl
     curl 'https://yandex.ru/search/xml?folderid=<идентификатор_каталога>&apikey=<значение_API-ключа>&query=<текст_поискового_запроса>'
     ```