### Password policy is PCI DSS 4.0 compliant {#pci-dss}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | access.password-policy.pci-dss ||
|#

#### Description

**How the rule works**: The rule automatically checks whether the password policy set for the pool's users complies with the following requirements:

* New passwords cannot be similar to previous ones.
* Passwords must be at least seven characters long and it may contain digits as well as uppercase and lowercase letters.
* The password lifetime is no longer than 90 days.
* The number of wrong password entries before lockout is no greater than six.
* The number of previous passwords that cannot be reused when changing a password — no more than 4.
* The lockout duration is at least 30 minutes.

**Risks when not complying with the rule**:

Weak passwords are one of the primary causes of account compromises. Hackers employ brute force attacks, dictionary attacks, and database leaks to gain access to user accounts. With no password policy in place, users can set easy or previously used passwords. This results in vulnerabilities that are difficult to spot and fix manually.

A password policy decreases such risks. Yandex Cloud provides certain password policy [recommendations](https://yandex.cloud/en/docs/organization/concepts/password-policy).

A PCI DSS-compliant password policy sets the following requirements for user passwords:

* **Minimum length**: 12 characters. The password contains letters and digits. Special characters as well as uppercase and lowercase letters are recommended.
* **Requirement 8.2.4**: Users must change their password at least once in 90 days. When using MFA, however, frequent password changes are not mandatory.
* **Requirement 8.2.5**: The new password must not be identical to the last four passwords.
* **Requirement 8.2.6**: When logging in for the first time or resetting the password, the user must change the temporary password.

Additional requirements:

* **Requirement 8.1.6**: Lockout occurs after six wrong password entries. The lockout lasts at least 30 minutes or until an admin lifts it.
* **Requirement 8.1.8**: Automatic logout occurs after 15 minutes of idle time.
* **Requirement 8.3**: Multi-factor authentication (MFA) is always mandatory in case of remote access to the cardholder data environment (CDE) as well as in case of admin access.

#### Instructions and solutions

1. Log in to [Yandex Identity Hub](https://center.yandex.cloud/organization) using an administrator or organization owner account.
2. In the left-hand panel, click **User pools** and select a user pool.
3. Navigate to the **Overview** → **Password policy** → **Set up policy** → tab.
4. In the **Password complexity** section:

   * In the **Mandatory** field, select the character types for the password by activating the following options:

     * **Lowercase Latin letters**
     * **Uppercase Latin letters**
     * **Numbers**

   * In the **Minimum length** field, specify the minimum number of characters in the password but not fewer than seven.

5. Optionally, under **Password uniqueness**, in the **Password verification** field, enable **You cannot use passwords included in the database of common passwords**. This will protect users from using passwords that can be easily guessed using a dictionary.
6. In the **Password lifetime** section, set a password lifetime of no longer than 90 days.
7. In the **Protection against password guessing** section, set the following:

   * **Number of wrong password entries before lockout**, no greater than six.
   * **Interval for counting wrong entries** in minutes.
   * **Lockout duration**, at least 30 minutes.