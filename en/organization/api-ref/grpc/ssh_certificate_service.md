---
editable: false
sourcePath: en/_api-ref-grpc/organization/api-ref/grpc/ssh_certificate_service.md
---

# Cloud Organization API, gRPC: SshCertificateService



| Call | Description |
| --- | --- |
| [Generate](#Generate) | Members of an organization can generate certificates for themselves Signing certificates for other users requires a special permission |

## Calls SshCertificateService {#calls}

## Generate {#Generate}

Members of an organization can generate certificates for themselves Signing certificates for other users requires a special permission

**rpc Generate ([GenerateSshCertificateRequest](#GenerateSshCertificateRequest)) returns ([GenerateSshCertificateResponse](#GenerateSshCertificateResponse))**

### GenerateSshCertificateRequest {#GenerateSshCertificateRequest}

Field | Description
--- | ---
scope | **oneof:** `cloud_id` or `organization_id`<br>
&nbsp;&nbsp;cloud_id | **string**<br> The maximum string length in characters is 50.
&nbsp;&nbsp;organization_id | **string**<br> The maximum string length in characters is 50.
subject | **oneof:** `subject_id` or `os_login`<br>
&nbsp;&nbsp;subject_id | **string**<br> The maximum string length in characters is 50.
&nbsp;&nbsp;os_login | **string**<br> The maximum string length in characters is 32.
public_key | **string**<br>Required.  The maximum string length in characters is 15000.


### GenerateSshCertificateResponse {#GenerateSshCertificateResponse}

Field | Description
--- | ---
signed_certificate | **string**<br>as per specification https://cvsweb.openbsd.org/src/usr.bin/ssh/PROTOCOL.certkeys?annotate=HEAD 


