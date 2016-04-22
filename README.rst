Sahara templates
----------------------------------------------
Sahara templates contain scripts to create and launch Hadoop clusters with different Hadoop distributions and versions on OpenStack cloud.
Usage:
- Source the OpenStack credential files
- Setting up customized environment variables. If not set, it will try to find the right values from OpenStack cloud:
	- IMG_ID: Image of VM's image.
	- PUBLIC_NET: External network (Floating-IP pool)
	- PRIVATE_NET: Tenant's private network
	- KEY_ID: (imperative) user's public key
	- FLAVOR_ID: Flavor_ID for VMs
	- SAHARA_URL: URL for Sahara service. Necessary if Sahara is not declared in Keystone's endpoints.
-  Using ./launch_xxx for creating and launching correspondent cluster