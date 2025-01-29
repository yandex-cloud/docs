---
title: Integration with the {{ marketplace-short-name }} {{ cloud-apps-name }} Workload API
description: You will learn how to work with the {{ cloud-apps-full-name }} Workload API to integrate your application with {{ marketplace-full-name }}.
---

# Getting started with the {{ marketplace-short-name }} {{ cloud-apps-name }} Workload API

This section provides examples of using the {{ marketplace-short-name }} {{ cloud-apps-name }} Workload [REST API](../../../workload/api-ref/) and [gRPC API](../../../workload/api-ref/grpc/) to get information about an application in {{ cloud-apps-name }} and how to link such an app and the VM it runs on to [{{ cloud-apps-full-name }}](../../../../cloud-apps/index.yaml).

You can also send all the requests given below using the [Node.js](https://github.com/yandex-cloud/nodejs-sdk), [Python](https://github.com/yandex-cloud/python-sdk), [Go](https://github.com/yandex-cloud/go-sdk), [Java](https://github.com/yandex-cloud/java-sdk), or [C#](https://github.com/yandex-cloud/dotnet-sdk) SDKs.

## Getting started {#before-begin}

To get started with the {{ marketplace-short-name }} {{ cloud-apps-name }} Workload API:

1. [Get](../../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) an IAM token for the [service account](../../../../iam/concepts/users/service-accounts.md) created automatically while installing the application and linked to the [VM](../../../../compute/concepts/vm.md) running this application.
1. [Get](../../../../compute/concepts/vm-metadata.md#identity-document) the ID of the VM running the application.

To use the examples, install these utilities:
* [cURL](https://curl.haxx.se) if using the [REST API](../../../workload/api-ref/)
* [gRPCurl](https://github.com/fullstorydev/grpcurl) if using the [gRPC API](../../../workload/api-ref/grpc/)

## Get information about a {{ cloud-apps-full-name }} application {#get-app-info}

To get information about an application in {{ cloud-apps-name }}, use the [service account](../../../../iam/concepts/users/service-accounts.md) created automatically while installing the application and linked to the VM running this application. Run this command:

{% list tabs group=instructions %}

- REST API {#api}

  ```bash
  curl \
    --request GET \
    --header "Authorization: Bearer <IAM_token>" \ 
    https://cloudapps.{{ api-host }}/cloudapps/workload/v1/cloud-applications
  ```

  Where `<IAM_token>` is the service account [IAM token](../../../../iam/concepts/authorization/iam-token.md) you got earlier.

  Result:

  ```json
  {
    "id": "d7fsg12ho5h6********",
    "status": "DEPLOYED",
    "billing": {
      "type": "PAY_AS_YOU_GO"
    }
  }
  ```

  The request uses the [get](../../../workload/api-ref/CloudApplication/get.md) REST API method for the [CloudApplication](../../../workload/api-ref/CloudApplication/index.md) resource.

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -H "Authorization: Bearer <IAM_token>" \
    cloudapps.{{ api-host }}:443 yandex.cloud.cloudapps.workload.v1.CloudApplicationService/Get
  ```

  Where `<IAM_token>` is the service account [IAM token](../../../../iam/concepts/authorization/iam-token.md) you got earlier.

  Result:

  ```json
  {
    "id": "d7fsg12ho5h6********",
    "status": "DEPLOYED",
    "billing": {
      "type": "PAY_AS_YOU_GO"
    }
  }
  ```

  The request uses the [CloudApplicationService/Get](../../../workload/api-ref/grpc/CloudApplication/get.md) gRPC API call.

{% endlist %}

This response indicates that the service account was automatically created while installing a {{ cloud-apps-name }} application whose ID is `d7fsg12ho5h6********`. The current application status is `DEPLOYED`, and the current [service plan](../../../concepts/tariff.md) type is `PAY_AS_YOU_GO`.

## Make sure the application is running in {{ cloud-apps-name }} {#ensure-cloud-app}

To make sure your application is running in {{ cloud-apps-name }}, check that the VM is linked to the application. To do this, use the service account created automatically while installing the application and linked to the VM running this application. Run this command:

{% list tabs group=instructions %}

- REST API {#api}

  ```bash
  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer <IAM_token>" \ 
    --data '{"workload_type": "COMPUTE_INSTANCE", "workload_id": "<VM_ID>"}' \
    https://cloudapps.{{ api-host }}/cloudapps/workload/v1/cloud-applications:resolve-by-workload
  ```

  Where:
  
  * `<IAM_token>`: Service account IAM token you got [earlier](#before-begin).
  * `<VM_ID>`: VM ID you got [earlier](#before-begin).

  Result:

  {% cut "The VM is linked to the {{ cloud-apps-name }} application" %}

  ```json
  {
    "cloudApplication": {
      "id": "d7fsg12ho5h6********",
      "status": "DEPLOYED",
      "billing": {
        "type": "PAY_AS_YOU_GO"
      }
    }
  }
  ```

  This response indicates that the VM and its linked service account were created automatically while installing a {{ cloud-apps-name }} application whose ID is `d7fsg12ho5h6********`. The current application status is `DEPLOYED`, and the current [service plan](../../../concepts/tariff.md) type is `PAY_AS_YOU_GO`.

  {% endcut %}

  {% cut "The VM is not linked to the {{ cloud-apps-name }} application" %}

  ```json
  {
   "code": 5,
   "message": "Workload not found",
   "details": [
    {
     "@type": "type.googleapis.com/google.rpc.RequestInfo",
     "requestId": "5899fc83-b123-47b8-94c3-1ad1********"
    }
   ]
  }
  ```

  If the request returns the above error, this means the user created the VM manually. As a result, the cost of the software product as per the service plan is not credited to the user’s account, and the application running on that VM may not be fully functional.

  {% endcut %}


  The request uses the [resolveByWorkload](../../../workload/api-ref/CloudApplication/resolveByWorkload.md) REST API method for the [CloudApplication](../../../workload/api-ref/CloudApplication/index.md) resource.

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -H "Authorization: Bearer <IAM_token>" \
    -d '{"workload_type": "COMPUTE_INSTANCE", "workload_id": "<VM_ID>"}' \
    cloudapps.{{ api-host }}:443 yandex.cloud.cloudapps.workload.v1.CloudApplicationService/ResolveByWorkload
  ```

  Where:
  
  * `<IAM_token>`: Service account IAM token you got [earlier](#before-begin).
  * `<VM_ID>`: VM ID you got [earlier](#before-begin).

  Result:

  {% cut "The VM is linked to the {{ cloud-apps-name }} application" %}

  ```json
  {
    "cloudApplication": {
      "id": "d7fsg12ho5h6********",
      "status": "DEPLOYED",
      "billing": {
        "type": "PAY_AS_YOU_GO"
      }
    }
  }
  ```

  This response indicates that the VM and its linked service account were created automatically while installing a {{ cloud-apps-name }} application whose ID is `d7fsg12ho5h6********`. The current application status is `DEPLOYED`, and the current [service plan](../../../concepts/tariff.md) type is `PAY_AS_YOU_GO`.

  {% endcut %}

  {% cut "The VM is not linked to the {{ cloud-apps-name }} application" %}

  ```json
  ERROR:
    Code: NotFound
    Message: Workload not found
    Details:
    1)    {
            "@type": "type.googleapis.com/google.rpc.RequestInfo",
            "requestId": "5899fc83-b123-47b8-94c3-1ad1********"
          }
  ```

  If the request returns the above error, this means the user created the VM manually. As a result, the cost of the software product as per the service plan is not credited to the user’s account, and the application running on that VM may not be fully functional.

  {% endcut %}

  The request uses the [CloudApplicationService/ResolveByWorkload](../../../workload/api-ref/grpc/CloudApplication/resolveByWorkload.md) gRPC API call.

{% endlist %}