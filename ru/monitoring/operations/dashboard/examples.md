# Использование дашбордов при помощи gRPC API

## Пререквизиты {#prerequisites}
Примеры использования написаны при помощи *grpcurl* утилиты.

Чтобы воспользоваться примерами в этом разделе, необходимо сохранить [OAuth-токен](../../api-ref/authentication.md#oauth) к API в переменную окружения `SOLOMON_TOKEN`.

Для запуска примеры необходимы следующие протобафы:
- API google proto можно найти по [ссылке](https://bb.yandex-team.ru/projects/CLOUD/repos/cloud-go/browse/public-api/third_party/googleapis);
- API yandex proto можно найти по [ссылке](https://a.yandex-team.ru/arc/trunk/arcadia);
- [Сервис дашбордов](https://a.yandex-team.ru/arc_vcs/solomon/protos/api/v3/dashboard_service.proto).

## Примеры запросов {#sample-requests}

### List {#sample-list}
Получает список дашбордов проекта. Можно использовать для поиска дашборда по `name`.

```bash
grpcurl -rpc-header "Authorization: OAuth ${SOLOMON_TOKEN}" \
-d '{"project_id": "monitoring-examples"}' \
-import-path ~/go/src/bb.yandex-team.ru/cloud/cloud-go/public-api/third_party/googleapis/ \
-import-path ~/arcadia/ \
-proto ~/arcadia/solomon/protos/api/v3/dashboard_service.proto \
solomon.yandex.net:443 yandex.monitoring.api.v3.DashboardService.List
```

### Get {#sample-get}
Получает дашборд по идентификатору.

```bash
grpcurl -rpc-header "Authorization: OAuth ${SOLOMON_TOKEN}" \
-d '{"dashboard_id": "monr2knetn2d9fmgrhie"}' \
-import-path ~/go/src/bb.yandex-team.ru/cloud/cloud-go/public-api/third_party/googleapis/ \
-import-path ~/arcadia/ \
-proto ~/arcadia/solomon/protos/api/v3/dashboard_service.proto \
solomon.yandex.net:443 yandex.monitoring.api.v3.DashboardService.Get
```

### Create {#sample-create}
Создает указанный дашборд.

```bash
grpcurl -rpc-header "Authorization: OAuth ${SOLOMON_TOKEN}" \
-d @ \
-import-path ~/go/src/bb.yandex-team.ru/cloud/cloud-go/public-api/third_party/googleapis/ \
-import-path ~/arcadia/ \
-proto ~/arcadia/solomon/protos/api/v3/dashboard_service.proto \
solomon.yandex.net:443 yandex.monitoring.api.v3.DashboardService.Create <payload.json
```

**Пример запроса, payload.json:**
```json
{
    "projectId": "alextrushkin_test",
    "name": "dashboard-local-id-in-project",
    "description": "Описание дашборда",
    "title": "Сумма метрик по хостам",
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
                "id": "ew0xwnqrc",
                "queries": {
                    "targets": [
                        {
                            "query": "alias(series_sum({project=\"monitoring-examples\", cluster=\"helper\", service=\"helper\", example=\"lines_ones\", name=\"line1\", host=\"*\"}), \"Сумма метрик по хостам\")"
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
                "title": "Сумма метрик по хостам"
            }
        }
    ],
    "parametrization": {

    }
}
```
**Пример ответа:**
```json
{
  "id": "994080a5-c3ad-43f6-8000-0b44fd3a2da4",
  "description": "Operation synchronous",
  "createdAt": "1970-06-21T01:26:44.916939395Z",
  "modifiedAt": "1970-06-21T01:26:44.916961872Z",
  "done": true,
  "response": {"@type":"type.googleapis.com/yandex.monitoring.api.v3.Dashboard","createdAt":"2022-01-23T16:20:00.028Z","createdBy":"alextrushkin","description":"Описание дашборда","etag":"0","id":"monr2knetn2d9fmgrhie","labels":{"label1":"value1"},"modifiedAt":"2022-01-23T16:20:00.028Z","modifiedBy":"alextrushkin","name":"dashboard-local-id-in-project","parametrization":{},"projectId":"alextrushkin_test","title":"Сумма метрик по хостам","widgets":[{"position":{"y":"8","w":"36","h":"8"},"chart":{"id":"ew0xwnqrc","queries":{"targets":[{"query":"alias(series_sum({project=\"monitoring-examples\", cluster=\"helper\", service=\"helper\", example=\"lines_ones\", name=\"line1\", host=\"*\"}), \"Сумма метрик по хостам\")"}],"downsampling":{}},"visualizationSettings":{"interpolate":"INTERPOLATE_LINEAR","colorSchemeSettings":{"automatic":{}},"yaxisSettings":{"left":{"type":"YAXIS_TYPE_LINEAR","min":"0","max":"5","unitFormat":"UNIT_NONE","precision":"0"},"right":{"type":"YAXIS_TYPE_LINEAR","unitFormat":"UNIT_NONE","precision":"0"}}},"seriesOverrides":[{"targetIndex":"0","settings":{"yaxisPosition":"YAXIS_POSITION_LEFT"}}],"nameHidingSettings":{},"title":"Сумма метрик по хостам"}}]}
}
```

### Update {#sample-update}
Обновляет указанный дашборд.

```bash
grpcurl -rpc-header "Authorization: OAuth ${SOLOMON_TOKEN}" \
-d @ \
-import-path ~/go/src/bb.yandex-team.ru/cloud/cloud-go/public-api/third_party/googleapis/ \
-import-path ~/arcadia/ \
-proto ~/arcadia/solomon/protos/api/v3/dashboard_service.proto \
solomon.yandex.net:443 yandex.monitoring.api.v3.DashboardService.Update <payload.json
```

**Пример запроса, payload.json:**
```json
{
    "dashboard_id": "monr2knetn2d9fmgrhie",
    "name": "dashboard-local-id-in-project",
    "description": "Описание дашборда новое",
    "labels": {
        "label1": "value1"
    },
    "title": "Сумма метрик по хостам",
    "widgets": [
        {
            "position": {
                "y": "8",
                "w": "36",
                "h": "8"
            },
            "chart": {
                "id": "ew0xwnqrc",
                "queries": {
                    "targets": [
                        {
                            "query": "alias(series_sum({project=\"monitoring-examples\", cluster=\"helper\", service=\"helper\", example=\"lines_ones\", name=\"line1\", host=\"*\"}), \"Сумма метрик по хостам\")"
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
                "title": "Сумма метрик по хостам"
            }
        }
    ],
    "parametrization": {

    },
    "etag": "0"
}
```
**Пример ответа:**
```json
{
    "id": "4ffd190f-4bd4-4dd3-88dd-ef28e2fc8c13",
    "description": "Operation synchronous",
    "createdAt": "1970-06-21T01:36:11.790989361Z",
    "modifiedAt": "1970-06-21T01:36:11.791003386Z",
    "done": true,
    "response": {"@type":"type.googleapis.com/yandex.monitoring.api.v3.Dashboard","createdAt":"2022-01-23T16:20:00.028Z","createdBy":"alextrushkin","description":"Описание дашборда новое","etag":"1","id":"monr2knetn2d9fmgrhie","labels":{"label1":"value1"},"modifiedAt":"2022-01-23T16:29:26.964Z","modifiedBy":"alextrushkin","name":"dashboard-local-id-in-project","parametrization":{},"projectId":"alextrushkin_test","title":"Сумма метрик по хостам (новое)","widgets":[{"position":{"y":"8","w":"36","h":"8"},"chart":{"id":"ew0xwnqrc","queries":{"targets":[{"query":"alias(series_sum({project=\"monitoring-examples\", cluster=\"helper\", service=\"helper\", example=\"lines_ones\", name=\"line1\", host=\"*\"}), \"Сумма метрик по хостам\")"}],"downsampling":{}},"visualizationSettings":{"interpolate":"INTERPOLATE_LINEAR","colorSchemeSettings":{"automatic":{}},"yaxisSettings":{"left":{"type":"YAXIS_TYPE_LINEAR","min":"0","max":"5","unitFormat":"UNIT_NONE","precision":"0"},"right":{"type":"YAXIS_TYPE_LINEAR","unitFormat":"UNIT_NONE","precision":"0"}}},"seriesOverrides":[{"targetIndex":"0","settings":{"yaxisPosition":"YAXIS_POSITION_LEFT"}}],"nameHidingSettings":{},"title":"Сумма метрик по хостам"}}]}
}
```

### Delete {#sample-delete}
Удаляет указанный дашборд.

```bash
grpcurl -rpc-header "Authorization: OAuth ${SOLOMON_TOKEN}" \
-d '{"dashboard_id": "monr2knetn2d9fmgrhie", "etag": "1"}' \
-import-path ~/go/src/bb.yandex-team.ru/cloud/cloud-go/public-api/third_party/googleapis/ \
-import-path ~/arcadia/ \
-proto ~/arcadia/solomon/protos/api/v3/dashboard_service.proto \
solomon.yandex.net:443 yandex.monitoring.api.v3.DashboardService.Delete
```

**Пример ответа с ошибкой:**
```json
{
    "id": "836b0169-b8c7-46bc-9bbd-2c7dfbd242d9",
    "description": "Operation synchronous",
    "createdAt": "1970-06-21T01:39:24.338616078Z",
    "modifiedAt": "1970-06-21T01:39:24.338637614Z",
    "done": true,
    "error": {
        "code": 6,
        "message": "ALREADY_EXISTS: dashboard 'monr2knetn2d9fmgrhie' with etag '1' is out of date"
    }
}

```
**Пример успешного ответа:**
```json
{
    "id": "b0c14ed1-a11f-4791-8444-90187c5805fa",
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
