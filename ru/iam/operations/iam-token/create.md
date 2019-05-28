# Получить IAM-токен для своей учетной записи

Для выполнения операций в Яндекс.Облаке через API необходим [IAM-токен](../../concepts/authorization/iam-token.md).

> [!NOTE]
>
> [!INCLUDE [iam-token-lifetime](../../../_includes/iam-token-lifetime.md)]

---

**[!TAB CLI]**

Получите IAM-токен:

```
$ yc iam create-token
```

**[!TAB API]**

[!INCLUDE [owner-warning](../../../_includes/iam/owner-warning.md)]

[!INCLUDE [create-iam-token-api-steps](../../../_includes/iam/create-iam-token-api-steps.md)]

---

[!INCLUDE [iam-token-usage](../../../_includes/iam-token-usage.md)]

## Примеры

Запишите IAM-токен в переменную с помощью CLI и используйте токен в других запросах из командной строки:

---

**[!TAB Bash]**

```bash
$ export IAM_TOKEN=`yc iam create-token`
$ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
    https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
```

**[!TAB PowerShell]**

```
$IAM_TOKEN=yc iam create-token
curl.exe -H "Authorization: Bearer $IAM_TOKEN" https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
```

---