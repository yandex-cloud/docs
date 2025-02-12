* `aws-v1-http-endpoint`: Provides access to metadata using AWS format (IMDSv1). It can be either `enabled` or `disabled`. If set to `disabled`, the metadata request will fail with error `400` (`BadRequest`). The default value is `enabled`.
* `aws-v1-http-token`: Enables using AWSv1 (IMDSv1) metadata to get the [service account](../../iam/concepts/users/service-accounts.md) token for the VM. It can be either `enabled` or `disabled`. If set to `disabled`, the token request will fail with error `400` (`BadRequest`). The default value is `disabled`.

  {% note info %}

  The IMDSv1 format comes with a number of security vulnerabilities; therefore, `aws-v1-http-token` is set to `disabled` by default. The most severe flaw of IMDSv1 is its high risk of attacks, such as [SSRF](https://portswigger.net/web-security/ssrf). You can read more about it in the [AWS official blog](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/). To change the default behavior of this parameter, contact [support]({{ link-console-support }}).

  The most secure way to get a token in {{ yandex-cloud }} is to use the [Google Compute Engine](../../compute/operations/vm-info/get-info.md#gce-metadata) format, which provides an extra header to protect against SSRF.

  {% endnote %}

* `gce-http-endpoint`: Provides access to metadata using the Google Compute Engine format. It can be either `enabled` or `disabled`. If set to `disabled`, the metadata request will fail with error `400` (`BadRequest`). The default value is `enabled`.
* `aws-v1-http-token`: Enables using Google Compute Engine metadata to get the [service account](../../iam/concepts/users/service-accounts.md) token for the VM. It can be either `enabled` or `disabled`. If set to `disabled`, the token request will fail with error `400` (`BadRequest`). The default value is `enabled`.

You can get the values of the metadata service parameters together with the [VM information](../../compute/operations/vm-info/get-info.md#outside-instance) using the [CLI](../../cli/cli-ref/compute/cli-ref/instance/get.md) and [API](../../compute/api-ref/Instance/get.md).