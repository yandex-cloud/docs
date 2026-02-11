---
title: Password policy in {{ org-full-name }}
description: A password policy brings together rules on creating and updating passwords for pool users. When you create a user pool, it is assigned a default password policy, which you can change.
---

# Password policy


A _password policy_ brings together rules on creating and updating passwords for [pool](user-pools.md) users.

## Password policy settings {#settings}

Users with an administrator or organization owner account have access to [password policy settings](../operations/user-pools/set-password-policy.md).

### Password complexity {#complexity}

There are two available password complexity options:

* **Any character types**: Minimum length depends on the number of character types used in a password. For example, for a password made up of lowercase and uppercase letters, you can set the length of 14 characters, and for a more complex one, 10 characters.

  This is the preferred option as it does not require specific characters and allows users to create strong, yet more memorable passwords.

* **Required character types**: Password must contain all specified character types and meet the required length. You can specify the following types of characters:

  * Lowercase letters
  * Uppercase letters
  * Numbers
  * Special characters, e.g., `!@#$%^&*`

### Password lifetime {#lifetime}

Password lifetime is the period of time after which users will have to update their passwords. You can specify a lifetime of up to 730 days or set no limit.

### Protection against password guessing {#protection}

To configure protection against password guessing, you can use the following settings:

* Number of wrong password entries before lockout: 1 to 100.
* Interval for counting wrong entries in minutes or seconds.
* Lockout duration in minutes or seconds.

## Default password policy {#default-policy}

When you create a user pool, it is assigned the following default password policy:

* Minimum password length for character types used in the password:
  * 4 types: 10
  * 3 types: 11
  * 2 types: 24
* Minimum password lifetime: Unlimited.
* Maximum password lifetime: 365 days.
* Number of wrong password entries before lockout: 15.
* Interval for counting wrong entries: 10 minutes.
* Lockout duration: 10 minutes.
