# Canary release

[Canary release](https://martinfowler.com/bliki/CanaryRelease.html) is a way to roll out and deploy a new software version for testing purposes. While testing, the current version remains active and the new one is only used in a certain percentage of cases.

With an API gateway's canary release, incoming requests are randomly divided between the two versions as per the set percentage value. The canary release usually handles a small number of requests, while the current release, all the remaining ones. You can increase or decrease the percentage of requests to test the changes.

## Usage

To create a canary release, write an OpenAPI specification using one or more variables (see [Specification parameterization](./parametrization.md)), and then create or update an API gateway. Specify the following:
* Specification with variables.
* Variable values for the canary release.
* Percentage of requests to process by the canary release.

If the canary release handles a request, a response returned by {{ api-gw-short-name }} will contain an additional header, `x-yc-apigateway-release`, set to `canary`.

## Use cases {#examples}

* [{#T}](../../tutorials/canary-release.md)
