# Частичное изменение объекта

В {{ objstorage-name }} реализован механизм _частичного изменения и дозаписи объектов_ в бакете.

{% include [patch-disclaimer](../../_includes/storage/patch-disclaimer.md) %}

С помощью частичного изменения вы можете хранить в бакете данные, например логи, в виде единого файла, периодически дописывая в него информацию.

Также упрощается работа с большими файлами. Например, чтобы изменить один байт информации в большом файле вы можете использовать:
* стандартные методы [get](../s3/api-ref/object/get.md) и [upload](../s3/api-ref/object/upload.md) S3 API, полностью скачав и загрузив объект обратно в хранилище;
* метод [patch](../s3/api-ref/object/patch.md), загрузив в хранилище только изменившуюся или новую часть файла.

Таким образом, частичная перезапись позволяет увеличить скорость работы с {{ objstorage-name }} и уменьшить стоимость.

На стороне сервера при частичном изменении будут перезаписаны:
* объект целиком, если он изначально был загружен с помощью метода [PUT](../s3/api-ref/object/upload.md).
* составные части объекта, попадающие в диапазон изменения, если объект изначально был [загружен по частям](multipart.md).

Указанная функциональность реализована в виде метода [patch](../s3/api-ref/object/patch.md) и поддержана в [GeeseFS](../tools/geesefs.md#patch).

GeeseFS является рекомендованным инструментом для частичного изменения объектов в бакете.

Также вы можете напрямую [отправлять запросы](../s3/index.md) patch к {{ objstorage-name }} API, либо расширить набор методов [AWS SDK](../tools/), воспользовавшись [спецификацией](#specification) метода patch.

## Одновременное изменение объектов {#concurrent-patch}

В {{ objstorage-name }} поддерживается одновременное частичное изменение объектов.

При частичном изменении каждый параллельный запрос выполняется на собственном снимке объекта, таким образом, разные запросы на изменение одного и того же объекта обрабатываются независимо.

Все изменения при параллельных запросах применяются атомарно.

## Разрешение конфликтов {#conflicts}

Для одновременного частичного изменения реализован механизм разрешения конфликтов.

При успешном разрешении конфликта применяется то изменение, которое было произведено позднее. 

Количество попыток перезаписи ограничено на стороне сервера. Если серверу не удается разрешить конфликты, пользователю возвращается ответ с ошибкой `ConcurrentUpdatesPatchConflict`. 

## Спецификация {#specification}

```json
"PatchObject":{
  "name":"PatchObject",
  "http":{
    "method":"PATCH",
    "requestUri":"/{Bucket}/{Key+}"
  },
  "input":{"shape":"PatchObjectRequest"},
  "output":{"shape":"PatchObjectOutput"},
  "httpChecksum":{
    "requestAlgorithmMember":"ChecksumAlgorithm",
    "requestChecksumRequired":false
  }
},
"PatchAppendPartSize":{"type": "integer"},
"PatchedObjectInfo":{
  "type":"structure",
  "members":{
    "ETag":{"shape":"ETag"},
    "LastModified":{"shape":"LastModified"}
  }
},
"PatchObjectOutput":{
  "type":"structure",
  "members":{
    "Object":{"shape":"PatchedObjectInfo"}
  }
},
"PatchObjectRequest":{
  "type":"structure",
  "required":[
    "Bucket",
    "Key",
    "ContentRange"
  ],
  "members":{
    "Body":{
      "shape":"Body",
      "streaming":true
    },
    "Bucket":{
      "shape":"BucketName",
      "location":"uri",
      "locationName":"Bucket"
    },
    "ContentLength":{
      "shape":"ContentLength",
      "location":"header",
      "locationName":"Content-Length"
    },
    "ContentMD5":{
      "shape":"ContentMD5",
      "location":"header",
      "locationName":"Content-MD5"
    },
    "ContentRange":{
      "shape":"ContentRange",
      "location":"header",
      "locationName":"Content-Range"
    },
    "IfMatch":{
      "shape":"IfMatch",
      "location":"header",
      "locationName":"If-Match"
    },
    "IfUnmodifiedSince":{
      "shape":"IfUnmodifiedSince",
      "location":"header",
      "locationName":"If-Unmodified-Since"
    },
    "Key":{
      "shape":"ObjectKey",
      "location":"uri",
      "locationName":"Key"
    },
    "PatchAppendPartSize":{
      "shape":"PatchAppendPartSize",
      "location":"header",
      "locationName":"X-Yc-S3-Patch-Append-Part-Size"
    }
  },
  "payload":"Body"
},
```
