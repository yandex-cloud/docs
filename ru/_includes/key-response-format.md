```
{
    "key": {
        "createdAt": "2018-10-30T15:55:00+00:00",
        "description": "",
        "id": "b1gvmob03goohplcf641",
        "keyAlgorithm": "RSA_2048",
        "publicKey": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
        "serviceAccountId": "ajepg0mjt06siua65usm"
    },
    "privateKey": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
}
```

Создать JWT можно с помощью разных инструментов, например [jwt.io](https://jwt.io), но обратите внимание на то, что IAM API возвращает ключи с `\n` вместо переносов строк.