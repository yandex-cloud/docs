# Examples of working with the gRPC API

The examples below use `grpcurl`.

To use the examples, [authenticate](../../api-ref/authentication.md) with the API and clone the [cloudapi](https://github.com/yandex-cloud/cloudapi) repository.

## Request examples {#sample-requests}

### List {#list}

Getting a list of dashboards in a folder. In the `folder_id` field, specify the ID of the folder you want to get a list of dashboards for.

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
   -d '{"folder_id": "<folder_ID>"}' \
   -import-path ~/cloudapi/ \
   -import-path ~/cloudapi/third_party/googleapis/ \
   -proto ~/cloudapi/yandex/cloud/monitoring/v3/dashboard_service.proto \
monitoring.{{ api-host }}:443 yandex.cloud.monitoring.v3.DashboardService.List
```

### Get {#get}

Getting information about a dashboard. In the `dashboard_id` field, specify the ID of the dashboard you want to get information about.

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
   -d '{"dashboard_id": "<dashboard_ID>"}' \
   -import-path ~/cloudapi/ \
   -import-path ~/cloudapi/third_party/googleapis/ \
   -proto ~/cloudapi/yandex/cloud/monitoring/v3/dashboard_service.proto \
monitoring.{{ api-host }}:443 yandex.cloud.monitoring.v3.DashboardService.Get
```

### Create {#create}

Creating a dashboard:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
   -d @ \
   -import-path ~/cloudapi/ \
   -import-path ~/cloudapi/third_party/googleapis/ \
   -proto ~/cloudapi/yandex/cloud/monitoring/v3/dashboard_service.proto \
monitoring.{{ api-host }}:443 yandex.cloud.monitoring.v3.DashboardService.Create <payload.json
```

**Example of payload.json**

In the `folderId` field, specify the ID of the folder where you want to create a dashboard.

```json
{
  "folderId": "<folder_ID>",
  "name": "dashboard-local",
  "description": "Dashboard description",
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
              "query": "disk_flush_ops_failed{folderId=<folder_ID>, service=compute}"
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
**Response example**

```json
{
  "id": "21526195-7cf4-45ce-895b-3fbf********",
  "description": "Operation synchronous",
  "createdAt": "2022-12-13T12:38:48.239Z",
  "modifiedAt": "2022-12-13T12:38:48.239Z",
  "done": true,
  "response": {"@type":"type.googleapis.com/yandex.cloud.monitoring.v3.Dashboard","createdAt":"2022-12-13T12:38:48.151Z","createdBy":"aje2kcbb10f2********","description":"Dashboard description","etag":"0","folderId":"b1gc1t4cb638********","id":"fbee8i4vn87s********","labels":{"label1":"value1"},"modifiedAt":"2022-12-13T12:38:48.151Z","modifiedBy":"aje2kcbb10f2********","name":"dashboard-local","parametrization":{},"title":"Example title","widgets":[{"position":{"y":"8","w":"36","h":"8"},"chart":{"id":"61jjd238n","queries":{"targets":[{"query":"disk_flush_ops_failed{folderId=b1gc1t4cb638********, service=compute}"}],"downsampling":{}},"visualizationSettings":{"interpolate":"INTERPOLATE_LINEAR","colorSchemeSettings":{"automatic":{}},"yaxisSettings":{"left":{"type":"YAXIS_TYPE_LINEAR","min":"0","max":"5","unitFormat":"UNIT_NONE","precision":"0"},"right":{"type":"YAXIS_TYPE_LINEAR","unitFormat":"UNIT_NONE","precision":"0"}}},"seriesOverrides":[{"targetIndex":"0","settings":{"yaxisPosition":"YAXIS_POSITION_LEFT"}}],"nameHidingSettings":{},"title":"Example"}}]}
}
```

### Update {#update}

Updating a dashboard:

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
   -d @ \
   -import-path ~/cloudapi/ \
   -import-path ~/cloudapi/third_party/googleapis/ \
   -proto ~/cloudapi/yandex/cloud/monitoring/v3/dashboard_service.proto \
monitoring.{{ api-host }}:443 yandex.cloud.monitoring.v3.DashboardService.Update <payload.json
```

**Example of payload.json**

In the `dashboard_id` field, specify the ID of the dashboard you want to update. In the `folderId` field, specify the ID of the folder with the dashboard.

```json
{
  "dashboard_id" : "<dashboard_ID>",
  "name": "dashboard-local",
  "description": "New dashboard description",
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
              "query": "disk_flush_ops_failed{folderId=<folder_ID>, service=compute}"
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
**Response example**

```json
{
  "id": "7cc53fff-8a4c-4a5c-b11e-326b********",
  "description": "Operation synchronous",
  "createdAt": "2022-12-13T12:42:39.444Z",
  "modifiedAt": "2022-12-13T12:42:39.444Z",
  "done": true,
  "response": {"@type":"type.googleapis.com/yandex.cloud.monitoring.v3.Dashboard","createdAt":"2022-12-13T12:38:48.151Z","createdBy":"aje2kcbb10f2********","description":"New dashboard description","etag":"1","folderId":"b1gc1t4cb638********","id":"fbee8i4vn87s********","labels":{"label1":"value2"},"modifiedAt":"2022-12-13T12:42:39.293Z","modifiedBy":"aje2kcbb10f2********","name":"dashboard-local","parametrization":{},"title":"Example title","widgets":[{"position":{"y":"8","w":"36","h":"8"},"chart":{"id":"61jjd238n","queries":{"targets":[{"query":"disk_flush_ops_failed{folderId=b1gc1t4cb638********, service=compute}"}],"downsampling":{}},"visualizationSettings":{"interpolate":"INTERPOLATE_LINEAR","colorSchemeSettings":{"automatic":{}},"yaxisSettings":{"left":{"type":"YAXIS_TYPE_LINEAR","min":"0","max":"5","unitFormat":"UNIT_NONE","precision":"0"},"right":{"type":"YAXIS_TYPE_LINEAR","unitFormat":"UNIT_NONE","precision":"0"}}},"seriesOverrides":[{"targetIndex":"0","settings":{"yaxisPosition":"YAXIS_POSITION_LEFT"}}],"nameHidingSettings":{},"title":"Example"}}]}
}
```

### Delete {#delete}

Deleting a dashboard. In the `dashboard_id` field, specify the ID of the dashboard you want to delete.

```bash
grpcurl -rpc-header "Authorization: Bearer <IAM_token>" \
   -d '{"dashboard_id": "<dashboard_ID>", "etag": "1"}' \
   -import-path ~/cloudapi/ \
   -import-path ~/cloudapi/third_party/googleapis/ \
   -proto ~/cloudapi/yandex/cloud/monitoring/v3/dashboard_service.proto \
monitoring.{{ api-host }}:443 yandex.cloud.monitoring.v3.DashboardService.Delete
```

**Example of an error response**

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
**Example of a successful response**

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
