---
editable: false
---

# Billing API, REST: Customer methods
A set of methods for managing Customer resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "billingAccountId": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the customer.</p> 
billingAccountId | **string**<br><p>ID of the <a href="/docs/billing/api-ref/BillingAccount#representation">BillingAccount</a> assigned to the customer.</p> 

## Methods {#methods}
Method | Description
--- | ---
[activate](activate.md) | Activates specified customer. After customer is activated, he can use resources associated with his billing account.
[createResellerServed](createResellerServed.md) | Creates new reseller-served customer.
[invite](invite.md) | Invites customer to the specified reseller.
[list](list.md) | Retrieves the list of customers associated with the specified reseller.
[suspend](suspend.md) | Suspend specified customer. After customer is suspended, he can't use resources associated with his billing account.