---
title: "Relationship of resources of the Yandex API Gateway service"
description: "An API gateway is an interface for interacting with services within Yandex Cloud or on the Internet. An API gateway is set declaratively using a specification. A specification is a JSON or YAML file with a description of an API gateway according to the OpenAPI 3.0 standard. In the service The API Gateway specification has been updated with extensions that you can use to integrate with other cloud platforms."
---

# Relationships between resources in {{ api-gw-name }}

_API gateway_ is an interface for interacting with services in {{ yandex-cloud }} or on the internet.

API gateways are set in a declarative way using specifications. A specification is a JSON or YAML file with an API gateway description based on the [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) standard. In {{ api-gw-name}}, the specification is supplemented with extensions that you can use for integrating with other cloud platforms.

Available extensions:

* [Static response](../concepts/extensions/dummy.md).
* [Invoking a function](../concepts/extensions/cloud-functions.md).
* [Access via HTTP](../concepts/extensions/http.md).
* [Integration with {{ objstorage-name }}](../concepts/extensions/object-storage.md).
* [{{ ml-platform-name }} integration](../concepts/extensions/datasphere.md).
* [Integration with {{ yds-name }}](../concepts/extensions/datastreams.md).
* [Integration with {{ serverless-containers-name }}](../concepts/extensions/containers.md).
* [Integration with {{ message-queue-short-name }}](../concepts/extensions/ymq.md).
* [Greedy parameters](../concepts/extensions/greedy-parameters.md).
* [Generalized HTTP method](../concepts/extensions/any-method.md).

## Using domains {#domains}

{{ api-gw-short-name }} is integrated with the {{ certificate-manager-short-name }} domain management system.

You can use domains with confirmed rights when accessing the API. In this case, a certificate linked to the domain is used to provide a TLS connection.

For more information about domains, see [{#T}](../../certificate-manager/concepts/domains/services.md).

## Authorization {#authorization}

{{ api-gw-short-name }} enables you to implement standard [authentication and authorization mechanisms](https://swagger.io/docs/specification/authentication/) as described in the [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) specification. At present, [authorization using a function](../concepts/extensions/function-authorizer.md) is available.

#### See also {#see-also}

* [An overview of available extensions](extensions/index.md).

