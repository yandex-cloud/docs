---
title: ERR.DS_API.SOURCE_ACCESS_DENIED.INVALID_TOKEN error
description: This page describes the ERR.DS_API.SOURCE_ACCESS_DENIED.INVALID_TOKEN error.
---

# Invalid user token

`ERR.DS_API.SOURCE_ACCESS_DENIED.INVALID_TOKEN`

The token stored in the connection is not valid.

The token specified when creating the connection is no longer valid.
Possible reasons for token invalidation:

* You've changed your account password in Yandex ID.
* You've revoked the token in Yandex ID.

To fix this error:

1. In the list of your connections, select the connection whose token is no longer valid.
1. Click **Get token**.
1. If needed, grant {{ datalens-short-name }} access to your email address.
1. Click **Save changes**.
