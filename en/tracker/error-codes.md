---
sourcePath: en/tracker/api-ref/error-codes.md
---
# Possible response codes

200
:   Request executed successfully.

201
:  The `POST` request resulted in creating a new object.

204
:  The DELETE request is executed, the object was deleted.

400
:   One or more request parameters have an invalid value.

401
:  The user isn't authorized. Make sure that actions described in [{#T}](concepts/access.md) are performed.

403
:  Insufficient rights to perform this action. You can check what rights you have in the {{ tracker-name }} interface. The same rights are required to perform an action via the API and interface.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

412
:   There was a conflict when editing the object. The error may be due to an invalid update version.

412
:   There was a conflict when editing the object. The error may be due to an invalid update version.

422
:  Validation error. The request body may contain an invalid or non-existent parameter.

428
:   Access to the resource is denied. Make sure all required conditions for the request are specified.

