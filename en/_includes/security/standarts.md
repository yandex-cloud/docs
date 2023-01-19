# Security measures on the {{ yandex-cloud }} side

Here you'll find information about how the cloud platform operation and security processes work.

## Information security management system {#suib}

{{ yandex-cloud }} has an Information Security Management System (ISMS). It describes policies and procedures for providing information security (IS) and minimizing security risks. The ISMS defines secure development lifecycle processes, software update policies, and incident management action plans.

The {{ yandex-cloud }} information security department is in charge of monitoring and compliance for these processes. The department's experts continually improve ISMS, carry out internal and external audits, annually assess risks, and find ways to reduce them.

## Asset inventory {#asset-inv}

{{ yandex-cloud }} has a process for taking asset inventory, including accounting for systems that process customer data. Rules for using information and assets related to information processing are fixed in internal documents and regularly made clear to employees. When dismissed, employees return all corporate assets. System access permissions are revoked automatically.

Assets are classified in accordance with the legal requirements. The classification takes into account the value of information and negative consequences in the event of its unauthorized modification or disclosure.

Requirements for handling different classes of data are specified in the rules for the acceptable use of information and assets. Data carriers that are unfit for use or no longer needed are removed from operation in accordance with internal regulations.

## Access control {#access-contr}

The {{ yandex-cloud }} experts developed and use access control policies. This ensures that only authorized employees have access to facilities, secure areas, server rooms, and network resources.

{{ yandex-cloud }} team members only have access to the resources they require to perform their duties (the need-to-know principle). Permissions are granted according to the principle of least privilege.

Access rights to facilities, secure areas, server rooms, and network resources are approved by company executives. Hardware and network resource management interfaces are located in a dedicated network with highly restricted access. {{ yandex-cloud }} only provides access to source code to authorized employees according to the established security policy.

## Physical security {#physic-sec}

{{ yandex-cloud }} takes the following measures to ensure physical security:

* {{ yandex-cloud }} hardware resources are hosted in their privately owned data centers.
* Access to data centers is strictly regulated. Guests and {{ yandex-cloud }} team members who don't permanently work there may only enter the premises if permission is granted ahead of time.
* Cloud service facilities (racks, lockers, diagnostic areas) are under continuous video surveillance.
* Video camera recordings are stored on {{ yandex-cloud }} servers for at least three months and can be accessed whenever required.
* The {{ yandex-cloud }} security team monitors access to secure areas and service racks.
* Video camera recordings are stored on {{ yandex-cloud }} servers for at least three months and can be accessed whenever required.
* The {{ yandex-cloud }} security team monitors access to secure areas and service racks.
* {{ yandex-cloud }} customer data stored on disks must be encrypted.
* Malfunctioning equipment is only replaced upon request. Data is deleted from carriers when the equipment is removed from operation or reused.
* Faulty equipment is stored in a safe in special deposit bags. It may only be removed from the premises after the appropriate request is approved.

## Security development lifecycle {#sec-dev}

The Security Development Lifecycle (SDLC) is an integral part of designing new and improving existing services. {{ yandex-cloud }} implements and continues to develop the key components of this process.

* Training. Employees involved in the development of cloud services regularly do the following:
   * Attend mandatory training that is conducted annually for all specialists. All developers must pass theory and practice tests.
   * Familiarize themselves with the internal manual. It describes the basic SDLC principles, contains a list of possible vulnerabilities for different types of applications, and shows typical examples of vulnerable code and how to fix it. The manual also provides information on how to use vulnerability mitigation technologies. The regulations specify the minimum requirements for using cryptography when developing services and applications.
   * Continuously share knowledge with other experts. We regularly hold meetings to discuss in detail specific topics, new threats, and counteractions.
   * Participate in the annual Capture The Flag game. This is an opportunity to test the developers' knowledge in the field of information security. This training helps teams avoid mistakes when designing and developing real services.
* Architecture planning. As required by the classic SDLC, before developing any product and changing the architecture of an existing service, we hold meetings with security experts to discuss possible threats and ways to attack the service. As a result of these meetings, the service acquires an "immune system". This, along with other measures for Defense in Depth, provides reliable protection of the service and data being processed.
* Static and dynamic analysis. We use static code analysis systems to regularly scan the repository during the development process. We check the quality of code and its coverage using tests. Our teams also use dynamic analysis tools for sanity and fuzzy testing.
* Final security analysis. Despite the name, this procedure is carried out more than once. It's performed before each major stage of a project, such as before the Preview release of a service. The final security analysis is in fact white-box penetration testing. To think through the most effective attack possible, test engineers have access to the documentation and test bench. They also cooperate with the development team. They test both the service itself and the environment it's running in. As a result, they assess the risks and audit the service's compliance with external requirements.

In addition to the SDLC, the team pays attention to protecting the development environment. In {{ yandex-cloud }}, the development, testing, and production environments are divided and a control system is implemented to prevent the replication of production data onto other environments.

## Update management {#update-manage}

The {{ yandex-cloud }} team has developed an update management policy that regulates the maximum installation time for each type of software. Updates released by the software vendor should be installed within this period.

## Vulnerability management {#vulnere-manage}

{{ yandex-cloud }} regularly performs vulnerability testing for pre-production server systems with internet access and for network devices before moving them to the production environment. Any vulnerabilities are fixed before systems are put into production.

When vulnerabilities are detected in the components of the production environment, we analyze the operation complexity and the severity of the consequences. After this, the development team prepares updates based on the vulnerabilities found.

## Internal and external audits, penetration tests {#audits}

{{ yandex-cloud }} regularly conducts internal and external audits and penetration tests to check the efficiency of the existing processes for ensuring information security and improves them.

* The ISMS is subject to regular internal audits based on ISO 19011 recommendations.
* As part of the internal audits, we check asset management, physical security, change management, IS incident management, monitoring, and other processes and groups of IS controls.
* An internal auditor may conduct interviews, fill out checklists, audit documented information involving the audited employee, monitor their activities, and create a representative sample.
* Any nonconformities identified during the internal audit are analyzed to determine their cause and make changes to the action plan.
* In accordance with the laws on personal data protection and ISO standards, {{ yandex-cloud }} has a schedule of external audits for compliance with ISO 27001, ISO 27017, and ISO 27018, and a plan of monitoring activities to check the compliance of IS processes and controls with FSTEC Order No. 21.
* The {{ yandex-cloud }} security team uses Red Teaming. Vulnerabilities detected through regular penetration tests are fixed by development teams or, if it's not possible to quickly release an update, patched with appropriate security tools before a fix is released.

## Incident response {#incident-resp}

{{ yandex-cloud }} has an incident management policy. IS incidents are managed by the Security Operations Center (SOC) of the information security department. If required, employees from relevant departments provide legal, administrative, and expert support. The main objective of the SOC is to conduct procedures to improve security:

* Collecting IS events from monitoring tools, user messages, and other sources.
* Detecting IS incidents based on automated tools, as well as the knowledge and expertise of SOC employees.
* Responding to IS incidents based on a standard response plan. If there is no such plan, experts are involved in incident management.
* IS incidents are analyzed immediately after their consequences are eliminated.
* Corrective actions based on the analysis results.

### Notifying customers {#custom-notice}

Situations where the customer needs to be notified of incidents are specified in the agreement. If required, notification is sent within 24 hours as an email.

It's written by the incident manager appointed when the incident is registered. The message describes the nature of the incident, its possible consequences, and measures taken (or planned) to address them. The incident manager agrees the message content with the employees in charge and sends it to the support service.

Emails are sent in Russian and English. If the customer can prevent the incident or reduce its consequences, the notification describes the measures they can take.

## {{ yandex-cloud }} HR measures {#employees}

{{ yandex-cloud }} holds events for {{ yandex-cloud }} employees to mitigate possible information security risks associated with their actions.

* {{ yandex-cloud }} carries background verification checks on all candidates for employment.
* Employees are familiarized with the requirements of internal policies and regulations, including the {{ yandex-cloud }} Information Security Policy and {{ yandex-cloud }} Personal Data Processing Regulations.
* Data center employees, administrators, and developers regularly take additional training courses related to the secure development lifecycle and regulations for the administration and operation of cloud services. Training is conducted in-person and online.
* After completing training, employees take tests that assess their knowledge.
* The results from testing practical skills and knowledge of theory are analyzed to adjust the company's ISMS.
* Employees who fail to pass training within the scheduled period aren't allowed to perform their duties.
* Permissions are reviewed every six months.
* When an employee quits or takes a different job within the company, permissions to access information resources are automatically revoked.
* Passwords are checked for compliance with the password policy. We regularly evaluate password strength and make sure passwords aren't found in common dictionaries.

## Business continuity and fault tolerance {#continuity}

{{ yandex-cloud }} uses a business continuity management system that defines requirements for all business-critical processes. The violation of these requirements affects the fulfillment of obligations to partners and customers.

The business continuity management system consists of action plans to be followed by employees when a potential negative scenario takes place. The system provides redundancy mechanisms for all business-critical components of the cloud platform. This includes geo-redundancy in three geographically distributed data centers. {{ yandex-cloud }} also uses data storage redundancy that enables the recovery of customer data in the event of equipment failure.

We regularly conduct tests to check the effectiveness of these plans. We analyze testing results to develop remedial measures and make the decision to review existing plans.

## Cloud platform infrastructure security {#sec-cloud}

### Resource separation and isolation {#separation}

{{ yandex-cloud }} isolates administrative and user resources as follows:

* Physical isolation using host groups. Services that are critical in terms of security are run on VMs using a separate group of physical hosts where no user VMs are run.
* Logical isolation at the hypervisor and individual core level. Sometimes the administrative workload can be run on hosts where user VMs reside. In this case, isolation is implemented at the hypervisor and physical core level.
* Logical isolation using {{ iam-name }} ({{ iam-short-name }}). All administrative operations are performed through {{ iam-short-name }}. This requires special permissions that aren't granted to {{ yandex-cloud }} users.
* Network-level isolation. All administrative VMs run in physically or logically isolated networks. A provider's corporate network is separated from the cloud platform network. Access control is carried out automatically using dynamic and host firewalls and access control lists (ACL) on routers.
* In multi-tenant systems, isolation is implemented at the application level and by verifying cloud and folder access rights of the user performing operations with the resources.

### Cloud platform machine security {#sec-machines}

There are several levels of security for physical machines and service VMs.

* The following types of firewalls are used at the network level:
    * Packet filters at the boundaries of internal subnets.
    * A simple packet filter at the Top-of-Rack switching level.
    * A hardware firewall at the boundary of the {{ yandex-cloud }} infrastructure and {{ yandex-cloud }} infrastructure.
    * A software firewall installed on all physical hosts and VMs.

* The following additional security features are used:
    * AppArmor and Seccomp create an isolation environment (sandbox) for applications. All VMs at the host OS level run under AppArmor.
    * Osquery 4: An improved version of the Osquery framework that implements the Host-Based Intrusion Detection System functionality, collects telemetry data from the host, including AppArmor and Seccomp logs, enriches data, and sends it to the Security Information and Event Management (SIEM) system.
    * Suspicious behavior monitoring and notification system.

* Operating system configurations are described using code and stored in a repository. All configuration changes are subject to mandatory testing in test environments before being transferred to the production environment.

* Administrators and developers' access to the production environment is controlled by a bastion host that logs user sessions. The logged session data is processed and sent to the SIEM system. {{ yandex-cloud }} information security department employees analyze this data on a regular basis.

* SSH access to the cluster is enabled by hardware authentication devices that store employee authentication data. This reduces the risk of stealing employee credentials when they access the production environment.

* All production environment packages are regularly checked for vulnerabilities and updated to the latest versions.

### Protection against supply chain attacks {#simply-chain-attacks}

{{ yandex-cloud }} has a Research and Development (R&D) Department. It works on the design and production of the server hardware used by {{ yandex-cloud }}. All server hardware is tested before commissioning. Packages with code that are deployed to the production environment contain a cryptographic signature. A package manager checks it before installation. All third-party open-source software packages are re-signed before they're added to the company's package repository.


Updates are released from special management servers that can only be accessed through the bastion host described above. The production environment update log is saved and analyzed by release engineers. All changes to applications or configurations are subject to mandatory verification.

Configurations of all production environment components are collected separately using Osquery. Information security department employees analyze them using the SIEM system.

## Protecting employee credentials {#sec-account}

Authentication on corporate resources that aren't linked to the cloud infrastructure is based on the world's best practices:

* All authentication events are collected and analyzed for possible identity theft.
* {{ yandex-cloud }} uses anti-phishing techniques.
* The company has a password policy.
* External access to the resources requires a VPN connection or two-factor authentication.
* We regularly check password strength.

Authentication on corporate resources that are linked to the cloud infrastructure is more strict:

* Access rights are requested separately and need to be approved by an information security department employee.
* To access the production environment, you must use a hardware token.
* Authentication on production environment web resources is done via the WebAuthn protocol. SSH authentication uses certificates.
* A certificate-linked private key stays on the hardware token.
* The hardware token is additionally protected by the user's PIN or biometrics.
* Access to the production environment is provided through the bastion host. All user sessions are logged and saved.

Strict authentication measures using hardware tokens increase the security of user credentials. Even if an employee's machine is compromised, an attacker won't be able to steal and re-use their credentials. It's unlikely that an account will be compromised through phishing.

## Data protection {#sec-data}

The data owner is always the cloud platform user. {{ yandex-cloud }} only uses customer data hosted on the platform to fulfill the purposes outlined in the agreement and notifies the customer of any incidents that affect their data.

* Encryption at the Storage level

  Storage is a multi-tenant system that encrypts data with a separate set of keys prior to writing the data to a physical disk. The encryption keys are stored on the physical hosts running Storage.

* Encryption at the {{ ydb-full-name }} database level

  {{ ydb-short-name }} implements database-level encryption. Data is encrypted before being sent to Storage. Database-level encryption is done in {{ ydb-short-name }}-based systems (such as {{ message-queue-full-name }}) and other platform services that use {{ ydb-short-name }} for storing data.

* Data backup encryption in Managed Services for Databases (MDB).

  Managed database services encrypt all backups before sending them to permanent storage. For each user, a unique asymmetric encryption key pair is generated and stored in the MDB service.

* Encryption of transmitted data

  Data sent over the internet is encrypted using TLS. The keys used for TLS are stored on hosts running the protocol.

The above scenarios use the following cryptographic algorithms:

* Symmetric: AES, ChaCha.
* Asymmetric: RSA, Ed25519.

The minimum used key length is 128 bits for symmetric encryption algorithms, and 2048 bits for asymmetric encryption algorithms.

### Deleting data {#delete-data}

* Deleting resources via the API If a service receives a request to delete a resource via the API, the resource is immediately marked as deleted.

* When a cloud is suspended automatically. After 60 days (or 7 days if the cloud is suspended for violation of the Terms of Use), {{ yandex-cloud }} may mark the resources for deletion.

* When deleting a cloud. All folders and resources are immediately marked for deletion.

* Upon termination of the contract. All clouds and resources are immediately marked for deletion.

{% note info %}

A resource that's marked for deletion can't be restored. The data is actually deleted within 72 hours.

{% endnote %}

* Deleting logs of requests to resources Records of API requests to user resources are stored for one year. They are used for analyzing information security incidents and preventing fraud. Records are permanently deleted after one year.

* When a billing account is deleted. At the user's request, the billing account is marked for deletion and within 72 hours, the user loses access to it. Billing account data may be used to generate financial statements. Therefore, this data is kept until the expiration of the term of the limitation of actions and the term set by the applicable finance laws. When these terms expire, the billing account is irrevocably deleted.

### Disclosing information to third parties {#data-disclosure}

{{ yandex-cloud }} doesn't disclose information to third parties, except when required by applicable law or the provisions of the agreement. Whenever possible, {{ yandex-cloud }} redirects a third-party request to the customer.


## Protecting user information {#sec-user-info}

Information about users is provided to the {{ yandex-cloud }} team on a need-to-know basis. This means that user information is only available to those departments that require it to perform their duties. User information processing and storage systems use authentication, authorization, and record action logging.

User information includes:

* User action (operation) logs.
* API and console access logs.
* Technical information about the status of user services.
* Financial and resource consumption information.

The rights to access the above information are restricted by default and regularly reviewed by the information security department. Systems for storing and processing this information are created based on the Security Development Lifecycle and are regularly subject to internal penetration testing. If possible, user information is encrypted during storage and transmission.

## Monitoring {#monitoring}

{{ yandex-cloud }} uses the Security Information and Event Management (SIEM) system for collecting and handling security events. Event data is delivered to the SIEM system from various sources, mainly via HTTPS and Syslog.

Events collected in the SIEM system are analyzed and correlated together. If there are any signs of an attack or violation of IS policies, the information security department receives an alert. At the same time, an alarm is logged about the activation of protective devices. The alarm appears in the system as a task that contains the necessary information and further instructions. Depending on the alarm's severity, the person in charge will receive an email or SMS.

Each alarm has a type that determines its priority and the employee responsible for handling it. Some alarms are analyzed by the employees on duty for the appropriate services, others are sent to the information security department.

If an alarm is recognized as an information security incident, a regulation that describes how to handle it is put into effect.
