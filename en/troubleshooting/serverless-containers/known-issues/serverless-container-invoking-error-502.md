# You called a Serverless Container, but got the Code 502 Message Error during function invocation

## Issue description {#issue-description}
You used to run your application in a CRI-compatible environment within a container on a VM instance or a physical server.
You migrated the application to Serverless Containers, but now when you call it, you get `502 Message Error during function invocation`

## Solution {#issue-resolution}

You might get error 502 when the code running in the container makes an HTTP request, but this request terminates with an error.

- Check your container operating log. It might include the full error text mentioning the problem request.
- If you are unable to find any useful data in your container log, enable [detailed logging](../../../serverless-containers/concepts/logs.md) for your containerized application.

{% note alert %}

When calling a container over HTTPS, certain HTTP headers in the request and response are changed (see the [documentation](../../../serverless-containers/concepts/invoke.md#filter)).
When migrating your application to the Serverless Containers environment, you need to consider these changes.

{% endnote %}


## If the issue persists {#if-problem-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
Specify the following information in your request:
1. Container ID.
2. Time and date of your container call that terminated with an error.
3. Description of the container call procedure (whether the container is called from the third-party application code over the service API or directly, from the management console or YC CLI utility).
4. Full text of the error from the Serverless container log.
