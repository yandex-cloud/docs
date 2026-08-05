[Документация Yandex Cloud](../../../../../index.md) > [Yandex Identity Hub](../../../../index.md) > Справочник API > gRPC (англ.) > [Identity Provider API](../index.md) > [Synchronization](index.md) > GetReplicationToken

# Identity Provider API, gRPC: SynchronizationService.GetReplicationToken

Returns the replication token for synchronization.

## gRPC request

**rpc GetReplicationToken ([GetReplicationTokenRequest](#yandex.cloud.organizationmanager.v1.idp.GetReplicationTokenRequest)) returns ([GetReplicationTokenResponse](#yandex.cloud.organizationmanager.v1.idp.GetReplicationTokenResponse))**

## GetReplicationTokenRequest {#yandex.cloud.organizationmanager.v1.idp.GetReplicationTokenRequest}

```json
{
  "subject_container_id": "string",
  "session_type": "SessionType"
}
```

Request to get the replication token.

#|
||Field | Description ||
|| subject_container_id | **string**

Required field. ID of the subject container.

The maximum string length in characters is 50. ||
|| session_type | enum **SessionType**

Required field. Type of synchronization session.

- `AD_SYNC`: Active Directory synchronization session.
- `AD_PASSWORD_HASH`: Active Directory password hash session.
- `AD_USER_CONTROL`: Active Directory user control session.
- `LDAP_SYNC`: Generic LDAP synchronization session. ||
|#

## GetReplicationTokenResponse {#yandex.cloud.organizationmanager.v1.idp.GetReplicationTokenResponse}

```json
{
  "replication_token": "string"
}
```

Response message for [SynchronizationService.GetReplicationToken](#GetReplicationToken).

#|
||Field | Description ||
|| replication_token | **string**

Replication token value. ||
|#