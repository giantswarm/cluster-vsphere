# Values schema documentation

This page lists all available configuration options, based on the [configuration values schema](values.schema.json).

<!-- DOCS_START -->

### Cluster
Properties within the `.cluster` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `cluster.kubernetesVersion` | **Kubernetes version**|**Type:** `string`<br/>|

### Connectivity
Properties within the `.connectivity` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `connectivity.network` | **Network**|**Type:** `object`<br/>|
| `connectivity.network.allowAllEgress` | **Allow all egress**|**Type:** `boolean`<br/>**Default:** `false`|
| `connectivity.network.containerRegistries` | **Container registries** - Endpoints and credentials configuration for container registries.|**Type:** `object`<br/>**Default:** `{}`|
| `connectivity.network.containerRegistries.*` |**None**|**Type:** `array`<br/>|
| `connectivity.network.containerRegistries.*[*]` |**None**|**Type:** `object`<br/>|
| `connectivity.network.containerRegistries.*[*].credentials` | **Credentials** - Credentials for the endpoint.|**Type:** `object`<br/>|
| `connectivity.network.containerRegistries.*[*].credentials.auth` | **Auth** - Base64-encoded string from the concatenation of the username, a colon, and the password.|**Type:** `string`<br/>|
| `connectivity.network.containerRegistries.*[*].credentials.identitytoken` | **Identity token** - Used to authenticate the user and obtain an access token for the registry.|**Type:** `string`<br/>|
| `connectivity.network.containerRegistries.*[*].credentials.password` | **Password** - Used to authenticate for the registry with username/password.|**Type:** `string`<br/>|
| `connectivity.network.containerRegistries.*[*].credentials.username` | **Username** - Used to authenticate for the registry with username/password.|**Type:** `string`<br/>|
| `connectivity.network.containerRegistries.*[*].endpoint` | **Endpoint** - Endpoint for the container registry.|**Type:** `string`<br/>|
| `connectivity.network.controlPlaneEndpoint` | **Endpoint** - Kubernetes API configuration.|**Type:** `object`<br/>|
| `connectivity.network.controlPlaneEndpoint.host` | **Host** - IP for access to the Kubernetes API.|**Type:** `string`<br/>|
| `connectivity.network.controlPlaneEndpoint.ipPoolName` | **Ip Pool Name** - Ip for control plane will be drawn from this GlobalInClusterIPPool resource.|**Type:** `string`<br/>**Value pattern:** `^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$`<br/>**Default:** `"wc-cp-ips"`|
| `connectivity.network.controlPlaneEndpoint.port` | **Port number** - Port for access to the Kubernetes API.|**Type:** `integer`<br/>|
| `connectivity.network.loadBalancers` | **Load balancers**|**Type:** `object`<br/>|
| `connectivity.network.pods` | **Pods**|**Type:** `object`<br/>|
| `connectivity.network.pods.cidrBlocks` |**None**|**Type:** `array`<br/>|
| `connectivity.network.pods.cidrBlocks[*]` |IPv4 address range, in CIDR notation.|**Type:** `string`<br/>**Example:** `"10.244.0.0/16"`<br/>**Value pattern:** `^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(/([0-9]|[1,2][0-9]|[3][0-2]))?$`<br/>|
| `connectivity.network.services` | **Services**|**Type:** `object`<br/>|
| `connectivity.network.services.cidrBlocks` |**None**|**Type:** `array`<br/>|
| `connectivity.network.services.cidrBlocks[*]` |IPv4 address range, in CIDR notation.|**Type:** `string`<br/>**Example:** `"10.244.0.0/16"`<br/>**Value pattern:** `^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(/([0-9]|[1,2][0-9]|[3][0-2]))?$`<br/>|

### Control plane
Properties within the `.controlPlane` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `controlPlane.etcd` | **Etcd**|**Type:** `object`<br/>|
| `controlPlane.etcd.imageRepository` | **Image repository**|**Type:** `string`<br/>|
| `controlPlane.etcd.imageTag` | **Image tag**|**Type:** `string`<br/>|
| `controlPlane.replicas` | **Number of nodes**|**Type:** `integer`<br/>|

### Kubeadm
Properties within the `.kubeadm` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `kubeadm.users` | **Users**|**Type:** `array`<br/>|
| `kubeadm.users[*]` |**None**|**Type:** `object`<br/>|
| `kubeadm.users[*].authorizedKeys` | **Authorized keys**|**Type:** `array`<br/>|
| `kubeadm.users[*].authorizedKeys[*]` | **Key**|**Type:** `string`<br/>|
| `kubeadm.users[*].name` | **Name**|**Type:** `string`<br/>|

### Kubectl image
Properties within the `.kubectlImage` top-level object
Used by cluster-shared library chart to configure coredns in-cluster.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `kubectlImage.name` |**None**|**Type:** `string`<br/>|
| `kubectlImage.registry` |**None**|**Type:** `string`<br/>|
| `kubectlImage.tag` |**None**|**Type:** `string`<br/>|

### Kubernetes API server
Properties within the `.apiServer` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `apiServer.certSANs` | **Subject alternative names (SAN)** - Alternative names to encode in the API server's certificate.|**Type:** `array`<br/>**Default:** `[]`|
| `apiServer.certSANs[*]` | **SAN**|**Type:** `string`<br/>|
| `apiServer.enableAdmissionPlugins` | **Admission plugins** - Comma-separated list of admission plugins to enable.|**Type:** `string`<br/>**Default:** `"NamespaceLifecycle,LimitRanger,ServiceAccount,ResourceQuota,PersistentVolumeClaimResize,DefaultStorageClass,Priority,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook"`|
| `apiServer.featureGates` | **Feature gates** - Enabled feature gates, as a comma-separated list.|**Type:** `string`<br/>**Default:** `""`|

### Kubernetes Controller Manager
Properties within the `.controllerManager` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `controllerManager.featureGates` | **Feature gates** - Enabled feature gates, as a comma-separated list.|**Type:** `string`<br/>**Default:** `""`|

### Node template
Properties within the `.template` top-level object
Provisioning options for node templates.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `template.cloneMode` | **Clone mode** - Method used to clone template image.|**Type:** `string`<br/>|
| `template.diskGiB` | **Disk size (GB)** - Node disk size in GB. Must be at least as large as the source image.|**Type:** `integer`<br/>|
| `template.folder` | **Folder** - VSphere folder to deploy instances in. Must already exist.|**Type:** `string`<br/>|
| `template.memoryMiB` | **Memory (MB)** - Node memory allocation in MB.|**Type:** `integer`<br/>|
| `template.networkName` | **Segment name** - Segment name to attach nodes to. Must already exist.|**Type:** `string`<br/>|
| `template.numCPUs` | **CPU cores** - Number of CPUs to assign per node.|**Type:** `integer`<br/>|
| `template.resourcePool` | **Resource pool** - Resource pool to allocate nodes from. Must already exist.|**Type:** `string`<br/>|
| `template.storagePolicyName` | **Storage policy** - Storage policy to use. If specified, it must already exist.|**Type:** `string`<br/>|
| `template.templateName` | **Name** - Image template name to use for nodes.|**Type:** `string`<br/>|

### VCenter
Properties within the `.vcenter` top-level object
Configuration for vSphere API access.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `vcenter.datacenter` | **Datacenter** - Name of the datacenter to deploy nodes into.|**Type:** `string`<br/>|
| `vcenter.datastore` | **Datastore** - Name of the datastore for node disk storage.|**Type:** `string`<br/>|
| `vcenter.password` | **Password** - Password for the VSphere API.|**Type:** `string`<br/>|
| `vcenter.region` | **Region** - Category name in VSphere for topology.kubernetes.io/region labels.|**Type:** `string`<br/>|
| `vcenter.server` | **Server** - URL of the VSphere API.|**Type:** `string`<br/>|
| `vcenter.thumbprint` | **Thumbprint** - TLS certificate signature of the VSphere API.|**Type:** `string`<br/>|
| `vcenter.username` | **Username** - Username for the VSphere API.|**Type:** `string`<br/>|
| `vcenter.zone` | **Zone** - Category name in VSphere for topology.kubernetes.io/zone labels.|**Type:** `string`<br/>|

### Worker
Properties within the `.worker` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `worker.replicas` | **Number of nodes**|**Type:** `integer`<br/>|

### Other

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `organization` | **Organization**|**Type:** `string`<br/>|



<!-- DOCS_END -->