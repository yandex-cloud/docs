{#ai-net7-id}

Requirement ID: `AI-NET7`

{#ai-net7-requirement}

**Requirement**

For each public endpoint, the owner must record the domain, route, authentication method, rate limit, maximum request size, logging policy, and internal backend connection. Direct backend access must not bypass the checks established for the public path.

{#ai-net7-implementation}

**Implementation**

{{ api-gw-name }} supports authorization via documented extensions, including [JWT authorizer](../../../../api-gateway/concepts/extensions/jwt-authorizer.md), and {{ sws-name }} integration. Do not assign a non-existent generic invocation role to {{ api-gw-name }}: the authorization method depends on the OpenAPI specification and backend integration. {{ sws-name }} logs events within its [documented log model](../../../../smartwebsecurity/concepts/logging.md). A list of allowed requests does not substitute for a complete application log.

The {{ sws-name }} rate limits protect the relevant HTTP route but do not apply to model token costs or content semantics. The `N/A` result is allowed for a closed internal system without a public route, but partner endpoints must comply.

{#ai-net7-check}

**Check**

1. Compare your published OpenAPI specification, domain, and backend to make sure they match.
1. Test a request without credentials, request with invalid credentials, request exceeding the limit, and a direct request to the backend.

Access must match the specified schema, and there must be no way to bypass the perimeter. Match gateway or {{ sws-name }} logs and target system logs using the unified correlation ID. Run this test from both from a public and private source. A prohibition and disabled public access indicate a safe disaster state.

{#ai-net7-artifacts}

**Artifact**

* OpenAPI specification.
* Unauthenticated requests.
* Backend bypass test.
* Specification and {{ sws-name }} profile IDs.
* Bindings.
* HTTP test results.
