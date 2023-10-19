# Canary release

[Canary release](https://martinfowler.com/bliki/CanaryRelease.html) is a way to roll out and deploy a new software version to test it. During testing, the current version remains active and the new one is only used in a certain percentage of cases.

With an API gateway's canary release, incoming requests are randomly divided into two parts as per the set percentage value. A small number of requests is usually handled by the canary release and the remaining ones, by the current release. You can increase or decrease the percentage of requests you are testing the changes on.

## Usage

To create a canary release, write an OpenAPI specification using one or more variables (see [Specification parameterization](https://github.com/yandex-cloud/docs-source/pull/4122/parametrization.md)). Next, create or update an API gateway. Specify the following:
* Specification with variables
* Variable values for the canary release
* Percentage of requests to be handled by the canary release

If a request is handled by the canary release, a response returned by {{ api-gw-short-name }} contains an additional header, `x-yc-apigateway-release`, set to `canary`.
