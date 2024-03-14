# Примеры работы с gRPC API

Примеры использования написаны с помощью утилиты `grpcurl`.

Чтобы воспользоваться примерами, [аутентифицируйтесь](../../api-ref/authentication.md) в API и клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi).

## Примеры запросов {#sample-requests}

### List {#list}

Получить список дашбордов в каталоге. В поле `folder_id` укажите идентификатор каталога, список дашбордов в котором хотите получить.

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
   -d '{"folder_id": "<идентификатор_каталога>"}' \
   -import-path ~/cloudapi/ \
   -import-path ~/cloudapi/third_party/googleapis/ \
   -proto ~/cloudapi/yandex/cloud/monitoring/v3/dashboard_service.proto \
monitoring.{{ api-host }}:443 yandex.cloud.monitoring.v3.DashboardService.List
```

### Get {#get}

Получить информацию о дашборде. В поле `dashboard_id` укажите идентификатор дашборда, информацию о котором хотите получить.

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
   -d '{"dashboard_id": "<идентификатор_дашборда>"}' \
   -import-path ~/cloudapi/ \
   -import-path ~/cloudapi/third_party/googleapis/ \
   -proto ~/cloudapi/yandex/cloud/monitoring/v3/dashboard_service.proto \
monitoring.{{ api-host }}:443 yandex.cloud.monitoring.v3.DashboardService.Get
```

### Create {#create}

Создать дашборд.

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
   -d @ \
   -import-path ~/cloudapi/ \
   -import-path ~/cloudapi/third_party/googleapis/ \
   -proto ~/cloudapi/yandex/cloud/monitoring/v3/dashboard_service.proto \
monitoring.{{ api-host }}:443 yandex.cloud.monitoring.v3.DashboardService.Create <payload.json
```

**Пример payload.json**

В поле `folderId` укажите идентификатор каталога, в котором хотите создать дашборд.

```json
{
  "folderId": "<идентификатор_каталога>",
  "name": "dashboard-local",
  "description": "Описание дашборда",
  "title": "Example title",
  "labels": {
    "label1": "value1"
  },
  "widgets": [
    {
      "position": {
        "y": "8",
        "w": "36",
        "h": "8"
      },
      "chart": {
        "id": "61jjd****",
        "queries": {
          "targets": [
            {
              "query": "disk_flush_ops_failed{folderId=<идентификатор_каталога>, service=compute}"
            }
          ],
          "downsampling": {

          }
        },
        "visualizationSettings": {
          "interpolate": "INTERPOLATE_LINEAR",
          "colorSchemeSettings": {
            "automatic": {

            }
          },
          "yaxisSettings": {
            "left": {
              "type": "YAXIS_TYPE_LINEAR",
              "min": "0",
              "max": "5",
              "unitFormat": "UNIT_NONE",
              "precision": "0"
            },
            "right": {
              "type": "YAXIS_TYPE_LINEAR",
              "unitFormat": "UNIT_NONE",
              "precision": "0"
            }
          }
        },
        "seriesOverrides": [
          {
            "targetIndex": "0",
            "settings": {
              "yaxisPosition": "YAXIS_POSITION_LEFT"
            }
          }
        ],
        "nameHidingSettings": {

        },
        "title": "Example"
      }
    }
  ],
  "parametrization": {

  }
}
```
**Пример ответа**

```json
{
  "id": "21526195-7cf4-45ce-895b-3fbf********",
  "description": "Operation synchronous",
  "createdAt": "2022-12-13T12:38:48.239Z",
  "modifiedAt": "2022-12-13T12:38:48.239Z",
  "done": true,
  "response": {"@type":"type.googleapis.com/yandex.cloud.monitoring.v3.Dashboard","createdAt":"2022-12-13T12:38:48.151Z","createdBy":"aje2kcbb10f2********","description":"Описание дашборда","etag":"0","folderId":"b1gc1t4cb638********","id":"fbee8i4vn87s********","labels":{"label1":"value1"},"modifiedAt":"2022-12-13T12:38:48.151Z","modifiedBy":"aje2kcbb10f2********","name":"dashboard-local","parametrization":{},"title":"Example title","widgets":[{"position":{"y":"8","w":"36","h":"8"},"chart":{"id":"61jjd238n","queries":{"targets":[{"query":"disk_flush_ops_failed{folderId=b1gc1t4cb638********, service=compute}"}],"downsampling":{}},"visualizationSettings":{"interpolate":"INTERPOLATE_LINEAR","colorSchemeSettings":{"automatic":{}},"yaxisSettings":{"left":{"type":"YAXIS_TYPE_LINEAR","min":"0","max":"5","unitFormat":"UNIT_NONE","precision":"0"},"right":{"type":"YAXIS_TYPE_LINEAR","unitFormat":"UNIT_NONE","precision":"0"}}},"seriesOverrides":[{"targetIndex":"0","settings":{"yaxisPosition":"YAXIS_POSITION_LEFT"}}],"nameHidingSettings":{},"title":"Example"}}]}
}
```

### Update {#update}

Обновить дашборд.

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
   -d @ \
   -import-path ~/cloudapi/ \
   -import-path ~/cloudapi/third_party/googleapis/ \
   -proto ~/cloudapi/yandex/cloud/monitoring/v3/dashboard_service.proto \
monitoring.{{ api-host }}:443 yandex.cloud.monitoring.v3.DashboardService.Update <payload.json
```

**Пример payload.json**

В поле `dashboard_id` укажите идентификатор дашборда, который хотите обновить. В поле `folderId` укажите идентификатор каталога, в котором находится дашборд.

```json
{
  "dashboard_id" : "<идентификатор_дашборда>",
  "name": "dashboard-local",
  "description": "Новое описание дашборда",
  "title": "Example title",
  "labels": {
    "label1": "value2"
  },
  "widgets": [
    {
      "position": {
        "y": "8",
        "w": "36",
        "h": "8"
      },
      "chart": {
        "id": "61jjd****",
        "queries": {
          "targets": [
            {
              "query": "disk_flush_ops_failed{folderId=<идентификатор_каталога>, service=compute}"
            }
          ],
          "downsampling": {

          }
        },
        "visualizationSettings": {
          "interpolate": "INTERPOLATE_LINEAR",
          "colorSchemeSettings": {
            "automatic": {

            }
          },
          "yaxisSettings": {
            "left": {
              "type": "YAXIS_TYPE_LINEAR",
              "min": "0",
              "max": "5",
              "unitFormat": "UNIT_NONE",
              "precision": "0"
            },
            "right": {
              "type": "YAXIS_TYPE_LINEAR",
              "unitFormat": "UNIT_NONE",
              "precision": "0"
            }
          }
        },
        "seriesOverrides": [
          {
            "targetIndex": "0",
            "settings": {
              "yaxisPosition": "YAXIS_POSITION_LEFT"
            }
          }
        ],
        "nameHidingSettings": {

        },
        "title": "Example"
      }
    }
  ],
  "parametrization": {

  }
}
```
**Пример ответа**

```json
{
  "id": "7cc53fff-8a4c-4a5c-b11e-326b********",
  "description": "Operation synchronous",
  "createdAt": "2022-12-13T12:42:39.444Z",
  "modifiedAt": "2022-12-13T12:42:39.444Z",
  "done": true,
  "response": {"@type":"type.googleapis.com/yandex.cloud.monitoring.v3.Dashboard","createdAt":"2022-12-13T12:38:48.151Z","createdBy":"aje2kcbb10f2********","description":"Новое описание дашборда","etag":"1","folderId":"b1gc1t4cb638********","id":"fbee8i4vn87s********","labels":{"label1":"value2"},"modifiedAt":"2022-12-13T12:42:39.293Z","modifiedBy":"aje2kcbb10f2********","name":"dashboard-local","parametrization":{},"title":"Example title","widgets":[{"position":{"y":"8","w":"36","h":"8"},"chart":{"id":"61jjd238n","queries":{"targets":[{"query":"disk_flush_ops_failed{folderId=b1gc1t4cb638********, service=compute}"}],"downsampling":{}},"visualizationSettings":{"interpolate":"INTERPOLATE_LINEAR","colorSchemeSettings":{"automatic":{}},"yaxisSettings":{"left":{"type":"YAXIS_TYPE_LINEAR","min":"0","max":"5","unitFormat":"UNIT_NONE","precision":"0"},"right":{"type":"YAXIS_TYPE_LINEAR","unitFormat":"UNIT_NONE","precision":"0"}}},"seriesOverrides":[{"targetIndex":"0","settings":{"yaxisPosition":"YAXIS_POSITION_LEFT"}}],"nameHidingSettings":{},"title":"Example"}}]}
}
```

### Delete {#delete}

Удалить дашборд. В поле `dashboard_id` укажите идентификатор дашборда, который хотите удалить.

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM-токен>" \
    -d '{"dashboard_id": "<идентификатор_дашборда>", "etag": "1"}' \
   -import-path ~/cloudapi/ \
   -import-path ~/cloudapi/third_party/googleapis/ \
   -proto ~/cloudapi/yandex/cloud/monitoring/v3/dashboard_service.proto \
monitoring.{{ api-host }}:443 yandex.cloud.monitoring.v3.DashboardService.Delete
```

**Пример ответа с ошибкой**

```json
{
    "id": "836b0169-b8c7-46bc-9bbd-2c7d********",
    "description": "Operation synchronous",
    "createdAt": "1970-06-21T01:39:24.338616078Z",
    "modifiedAt": "1970-06-21T01:39:24.338637614Z",
    "done": true,
    "error": {
        "code": 6,
        "message": "ALREADY_EXISTS: dashboard 'monr2knetn2d********' with etag '1' is out of date"
    }
}

```
**Пример успешного ответа**

```json
{
    "id": "b0c14ed1-a11f-4791-8444-9018********",
    "description": "Operation synchronous",
    "createdAt": "1971-04-10T09:43:35.513978582Z",
    "modifiedAt": "1971-04-10T09:43:35.513983176Z",
    "done": true,
    "response": {
        "@type": "type.googleapis.com/google.protobuf.Empty",
        "value": {

        }
    }
}
```
