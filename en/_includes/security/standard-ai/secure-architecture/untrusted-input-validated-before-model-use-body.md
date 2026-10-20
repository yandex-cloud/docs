{#ai-app-waf1-id}

Requirement ID: `AI-APP-WAF1`

{#ai-app-waf1-requirement}

**Requirement**

The application must verify the type, size, encoding, structure, required fields, as well as validity of user and machine input before including the data into the model request or performing any other action. For each field and object type, the allowed values or an explicit rejection rule must be defined. The text, file, URL, search result, and external service's response remain untrusted whether or not they have passed the network perimeter.

{#ai-app-waf1-implementation}

**Implementation**

For public HTTP(S) entry points, [{{ api-gw-full-name }}](../../../../api-gateway/index.yaml) and [{{ sws-full-name }}](../../../../smartwebsecurity/index.yaml) can limit requests at the levels of HTTP, WAF rules, bot activity, and frequency. This does not replace application-level validation of the prompt's semantic content.

The connection between {{ api-gw-name }} and an {{ sws-name }} profile is set by a documented [OpenAPI extension](../../../../api-gateway/concepts/extensions/sws.md); for profile capabilities, see [{#T}](../../../../smartwebsecurity/concepts/profiles.md).

For additional moderation of requests and responses, you can use guardrails. However, this feature is in Preview and does not replace authorization, schema validation, or personal data processing. For more information, see this [guardrail description]({{ link-docs-ai }}ai-studio/concepts/security/guardrails.html).

For {{ serverless-containers-name }}, {{ sf-name }}, and {{ k8s }} without {{ sws-name }}, the same validator resides in the Ingress or application intermediate layer; security groups and network policies do not analyze the prompt and request body. The `N/A` result is acceptable only for the {{ sws-name }} branch, provided there is no HTTP(S) entry point, and does not cancel application-level input data validation. Semantic moderation of content pertains to `AI-CONTENT1`.

For a route with an {{ sws-name }} profile, both profile connection details and access log are saved.

{#ai-app-waf1-check}

**Check**

1. Send a valid request, a request with a missing or extra field, violated schema, exceeded limit, and content that should be rejected by the approved rule.
1. Check that each time the rejection occurs before the model call or another risky action, has a specific code or reason, and the log contains no secrets or excessive original content.

A valid request must get a correlation ID. Each rejection must be additionally confirmed by the absence of a subsequent model call or tool call event in the log or trace.

{#ai-app-waf1-artifacts}

**Artifact**

* Rejection records.
* OpenAPI specification configuration and hash.
* {{ sws-name }} profile ID.
* Test requests and their results.
* Subsequent call absence confirmation.
