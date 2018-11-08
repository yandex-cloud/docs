# Метод listAccessBindings
Возвращает список привязок прав доступа к указанному облаку.
 

 
## HTTP-запрос {#https-request}
```
GET https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/{resourceId}:listAccessBindings
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
resourceId | Обязательное поле. ID of the resource to list access bindings for.  To get the resource ID, use a corresponding List request. For example, use the [list](/docs/resource-manager/api-ref/Cloud/list) request to get the Cloud resource ID.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than pageSize, the service returns a nextPageToken that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.  Максимальное значение — 1000.
pageToken | Page token. Set pageToken to the nextPageToken returned by a previous list request to get the next page of results.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
accessBindings | **object**<br><p>List of access bindings for the specified resource.</p> 
accessBindings.<br>roleId | **string**<br><p>ID of the <a href="/docs/iam/api-ref/Role#representation">Role</a> that is assigned to the subject.</p> <p>Максимальная длина строки в символах — 50.</p> 
accessBindings.<br>subject | **object**<br><p>Обязательное поле. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier.</p> <p>It can contain one of the following sets of parameters:</p> <ul> <li><code>type = system, id = allUsers</code>.</li> <li><code>type = system, id = allAuthenticatedUsers</code>.</li> <li><code>type = userAccount, id = &lt;cloud generated id&gt;</code>.</li> <li><code>type = serviceAccount, id = &lt;cloud generated id&gt;</code>.</li> </ul> 
accessBindings.<br>subject.<br>id | **string**<br><p>ID of the subject.</p> <p>It can contain one of the following values:</p> <ul> <li> <p><code>allUsers</code>: A special system identifier that represents anyone. It can be used only if the type is <code>system</code>.</p> </li> <li> <p><code>allAuthenticatedUsers</code>: A special system identifier that represents anyone who is authenticated. It can be used only if the type is <code>system</code>.</p> </li> <li> <p><code>&lt;cloud generated id&gt;</code>: An identifier that represents a user account. It can be used only if the type is <code>userAccount</code> or <code>serviceAccount</code>.</p> </li> </ul> <p>Максимальная длина строки в символах — 50.</p> 
accessBindings.<br>subject.<br>type | **string**<br><p>Type of the subject.</p> <p>It can contain one of the following values:</p> <ul> <li> <p><code>system</code>: System type. It represents several accounts with a common system identifier.</p> </li> <li> <p><code>userAccount</code>: A user account. For more information, see <a href="/docs/iam/concepts/users/users">Users</a>.</p> </li> <li> <p><code>serviceAccount</code>: A service account. For more information, see <a href="/docs/iam/concepts/users/service-accounts">Service accounts</a>.</p> </li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than pageSize, use the nextPageToken as the value for the pageToken query parameter in the next list request. Each subsequent list request will have its own nextPageToken to continue paging through the results.</p> 