```mermaid
flowchart BT
    datasphere.community-projects.viewer --> datasphere.community-projects.developer
    datasphere.community-projects.developer --> datasphere.community-projects.editor
    datasphere.community-projects.editor --> datasphere.community-projects.admin
    datasphere.community-projects.viewer --> datasphere.communities.viewer
    datasphere.communities.viewer --> datasphere.communities.developer
    datasphere.communities.developer --> datasphere.communities.editor
    datasphere.community-projects.editor --> datasphere.communities.editor
    datasphere.communities.editor --> datasphere.communities.admin
    datasphere.community-projects.admin --> datasphere.communities.admin
```