Available options:

* `awsV1HttpEndpoint`: Provides access to metadata using the AWS format (IMDSv1). It can be either `enabled` or `disabled`. If set to `disabled`, the metadata request will fail with error `404 Not Found`. The default value is `enabled`.

    {% note info %}

    The `awsV1HttpEndpoint` parameter is `enabled` by default, but we recommend disabling it. The IMDSv1 format comes with a number of security vulnerabilities. Its most severe flaw is the high risk of attacks, such as [SSRF](https://portswigger.net/web-security/ssrf). For more information, see the [AWS official blog](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/).

    {% endnote %}

* `gceHttpEndpoint`: Provides access to metadata using the Google Compute Engine format. It can be either `enabled` or `disabled`. If set to `disabled`, the metadata request will fail with error `404 Not Found`. The default value is `enabled`.
