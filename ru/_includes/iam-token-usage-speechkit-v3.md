При обращении к {{ speechkit-name }} через API в каждом запросе передавайте полученные параметры: 

* Для API v1 и API v2:

   Указывайте IAM-токен в заголовке `Authorization` в следующем формате:

   ```
   Authorization: Bearer <IAM-токен>
   ```
  
   Идентификатор каталога указывайте в теле запроса в параметре `folderId`.

* Для API v3:

   * в заголовке `Authorization` указывайте IAM-токен;
   * в заголовке `x-folder-id` указывайте идентификатор каталога.

   ```
   Authorization: Bearer <IAM-токен> 
   x-folder-id: <идентификатор_каталога>
   ```