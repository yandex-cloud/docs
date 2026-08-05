---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/replication-token
    method: get
    path: null
    query:
      type: object
      properties:
        subjectContainerId:
          description: |-
            **string**
            Required field. ID of the subject container.
            The maximum string length in characters is 50.
          type: string
        sessionType:
          description: |-
            **enum** (SessionType)
            Required field. Type of synchronization session.
            - `AD_SYNC`: Active Directory synchronization session.
            - `AD_PASSWORD_HASH`: Active Directory password hash session.
            - `AD_USER_CONTROL`: Active Directory user control session.
            - `LDAP_SYNC`: Generic LDAP synchronization session.
          type: string
          enum:
            - SESSION_TYPE_UNSPECIFIED
            - AD_SYNC
            - AD_PASSWORD_HASH
            - AD_USER_CONTROL
            - LDAP_SYNC
      required:
        - subjectContainerId
        - sessionType
      additionalProperties: false
    body: null
    definitions: null
---

# Identity Provider API, REST: Synchronization.GetReplicationToken

Returns the replication token for synchronization.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/replication-token
```

## Query parameters {#yandex.cloud.organizationmanager.v1.idp.GetReplicationTokenRequest}

Request to get the replication token.

#|
||Field | Description ||
|| subjectContainerId | **string**

Required field. ID of the subject container.

The maximum string length in characters is 50. ||
|| sessionType | **enum** (SessionType)

Required field. Type of synchronization session.

- `AD_SYNC`: Active Directory synchronization session.
- `AD_PASSWORD_HASH`: Active Directory password hash session.
- `AD_USER_CONTROL`: Active Directory user control session.
- `LDAP_SYNC`: Generic LDAP synchronization session. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.GetReplicationTokenResponse}

**HTTP Code: 200 - OK**

```json
{
  "replicationToken": "string"
}
```

Response message for [SynchronizationService.GetReplicationToken](#GetReplicationToken).

#|
||Field | Description ||
|| replicationToken | **string**

Replication token value. ||
|#