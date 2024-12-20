1. [Become a partner](../../marketplace/quickstart.md#send-application) of {{ marketplace-short-name }} and [register](../../marketplace/operations/registration.md) a legal entity account.
1. In the [partner dashboard]({{ link-cloud-partners }}), create a [product](../../marketplace/operations/create-product.md) and a [service plan](../../marketplace/operations/create-tariff.md) with the [Subscription](../../marketplace/concepts/subscription.md) type.
1. [Create](../../iam/operations/sa/create.md) a service account you will use to authenticate in the API.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) the service account the `license-manager.saasSubscriptionSupervisor` role for the [partner profile](../../marketplace/concepts/publisher.md) and your [product](../../marketplace/concepts/product.md).
1. [Get](../../iam/concepts/authorization/iam-token.md) an IAM token for the service account you will use to authenticate in the License Manager API.

To use the examples, install [cURL](https://curl.haxx.se) and [gRPCurl](https://github.com/fullstorydev/grpcurl) (if using the [gRPC API](../../marketplace/api-ref/ImageProductUsage/index.md)).