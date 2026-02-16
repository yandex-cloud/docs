```mermaid
flowchart BT
    billing.accounts.viewer --> billing.accounts.accountant
    billing.accounts.viewer --> billing.accounts.editor
    billing.accounts.editor --> billing.accounts.admin
    billing.accounts.partnerAdmin --> billing.accounts.admin
    billing.partners.editor --> billing.accounts.admin
    billing.partners.editor --> billing.accounts.varWithoutDiscounts
    billing.accounts.admin --> billing.accounts.owner
    billing.accounts.varWithoutDiscounts --> billing.accounts.owner
    billing.accounts.member --> billing.accounts.viewer
```