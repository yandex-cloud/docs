For example, Julia works with multiple teams and belongs to their communities with different access permissions:

* In the <q>Cat lovers</q> community: `Admin` (the `{{ roles-datasphere-communities-admin }}` role).
* In the <q>Counting fences</q> community: `Developer` (the `{{ roles-datasphere-communities-developer }}` role).
* In the <q>Top secret</q> community: `Viewer` (the `{{ roles-datasphere-communities-viewer}}` role), but with the `Editor` permissions in <q>Project_111</q> of this community (the `{{ roles-datasphere-project-editor }}` role).

Julia can:

* Share the resources of any <q>Cat lovers</q> community's project within this community.
* Share the resources of any <q>Cat lovers</q> community's project in the <q>Counting fences</q> community.
* Publish the <q>Project_111</q> resources in the <q>Cat lovers</q> and <q>Counting fences</q> communities, but cannot share them in the <q>Top secret</q> community.
