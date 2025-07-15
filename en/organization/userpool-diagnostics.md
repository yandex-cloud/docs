---
title: Errors related to user pools in {{ org-full-name }}
description: In this article, you will learn about errors related to user pools.
---

# Diagnosing user pool-related errors

## Login not found {#login-not-found}

Error on attempt to log in. Username not found in the pool.

## Invalid redirect URL {#invalid-redirect-url}

If the `yc_sub_hint` and `yc_login_hint` parameters were not specified when attempting to log in, the pool user gets redirected to the address specified in the `redirectUrl` parameter. The error means that the address in `redirectUrl` is not valid.

## Subject not found {#subject-not-found}

Failure to find the user the login attempt was registered for. Check whether `yc_sub_hint` and `yc_login_hint` are correct.
