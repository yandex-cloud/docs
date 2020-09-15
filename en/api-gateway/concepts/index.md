# Relationship between service resources

_An API gateway_ is an interface for interacting with services in Yandex.Cloud or the internet.

API gateways are set in a declarative way using specifications. A specification is a JSON or YAML file with an API gateway description based on the [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) standard. In {{ api-gw-name}}, the specification is supplemented with extensions that you can use for integrating with other cloud platforms.

Available extensions:

* [Static response](../concepts/extensions/dummy.md).
* [Invoking a function](../concepts/extensions/cloud-functions.md).
* [Access via HTTP](../concepts/extensions/http.md).
* [Integration with Object Storage](../concepts/extensions/object-storage.md).

## Using domains {#domains}

{{ api-gw-short-name }} is integrated with the {{ certificate-manager-short-name }} domain management system.

You can use domains with confirmed rights when accessing the API. In this case, a certificate linked to the domain is used to provide a TLS connection.

For more information about domains, see [{#T}](../../certificate-manager/concepts/services.md).

#### See also {#see-also}

* [An overview of available extensions](extensions/index.md).
