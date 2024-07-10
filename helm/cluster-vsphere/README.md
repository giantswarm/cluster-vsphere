# Values schema documentation

This page lists all available configuration options, based on the [configuration values schema](values.schema.json).

<!-- DOCS_START -->

### 
Properties within the `.internal` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `internal.apiServer` |**None**|**Type:** `object`<br/>|
| `internal.apiServer.certSANs` | **Subject alternative names (SAN)** - Alternative names to encode in the API server's certificate.|**Type:** `array`<br/>**Default:** `[]`|
| `internal.apiServer.certSANs[*]` | **SAN**|**Type:** `string`<br/>|
| `internal.apiServer.enableAdmissionPlugins` | **Admission plugins** - List of admission plugins to be passed to the API server via the --enable-admission-plugins flag.|**Type:** `array`<br/>**Default:** `["DefaultStorageClass","DefaultTolerationSeconds","LimitRanger","MutatingAdmissionWebhook","NamespaceLifecycle","PersistentVolumeClaimResize","Priority","ResourceQuota","ServiceAccount","ValidatingAdmissionWebhook"]`|
| `internal.apiServer.enableAdmissionPlugins[*]` | **Plugin**|**Type:** `string`<br/>**Examples:** `"DefaultStorageClass", "Priority"`<br/>**Value pattern:** `^[A-Za-z0-9]+$`<br/>|
| `internal.apiServer.featureGates` | **Feature gates** - API server feature gate activation/deactivation.|**Type:** `array`<br/>**Default:** `[]`|
| `internal.apiServer.featureGates[*]` | **Feature gate**|**Type:** `object`<br/>|
| `internal.apiServer.featureGates[*].enabled` | **Enabled**|**Type:** `boolean`<br/>|
| `internal.apiServer.featureGates[*].name` | **Name**|**Type:** `string`<br/>**Example:** `"UserNamespacesStatelessPodsSupport"`<br/>**Value pattern:** `^[A-Za-z0-9]+$`<br/>|
| `internal.ciliumNetworkPolicy` | **CiliumNetworkPolicies**|**Type:** `object`<br/>|
| `internal.ciliumNetworkPolicy.enabled` | **Enable CiliumNetworkPolicies** - Installs the network-policies-app (deny all by default) if set to true|**Type:** `boolean`<br/>**Default:** `true`|
| `internal.controllerManager` | **Controller manager**|**Type:** `object`<br/>|
| `internal.controllerManager.featureGates` | **Feature gates** - Controller manager feature gate activation/deactivation.|**Type:** `array`<br/>**Default:** `[]`|
| `internal.controllerManager.featureGates[*]` | **Feature gate**|**Type:** `object`<br/>|
| `internal.controllerManager.featureGates[*].enabled` | **Enabled**|**Type:** `boolean`<br/>|
| `internal.controllerManager.featureGates[*].name` | **Name**|**Type:** `string`<br/>**Example:** `"UserNamespacesStatelessPodsSupport"`<br/>**Value pattern:** `^[A-Za-z0-9]+$`<br/>|
| `internal.enableEncryptionProvider` | **API server encryption at REST** - Enable encryption at REST feature of API server.|**Type:** `boolean`<br/>**Default:** `true`|
| `internal.kubectlImage` | **Kubectl image** - Used by cluster-shared library chart to configure coredns in-cluster.|**Type:** `object`<br/>|
| `internal.kubectlImage.name` | **Repository**|**Type:** `string`<br/>**Default:** `"giantswarm/kubectl"`|
| `internal.kubectlImage.registry` | **Registry**|**Type:** `string`<br/>**Default:** `"gsoci.azurecr.io"`|
| `internal.kubectlImage.tag` | **Tag**|**Type:** `string`<br/>**Default:** `"1.27.14"`|
| `internal.kubernetesVersion` | **Kubernetes version** - Kubernetes version to deploy. Must match the version available in the image defined at template.|**Type:** `string`<br/>**Default:** `"v1.27.14"`|
| `internal.sandboxContainerImage` | **Sandbox Container image**|**Type:** `object`<br/>|
| `internal.sandboxContainerImage.name` | **Repository**|**Type:** `string`<br/>**Default:** `"giantswarm/pause"`|
| `internal.sandboxContainerImage.registry` | **Registry**|**Type:** `string`<br/>**Default:** `"gsoci.azurecr.io"`|
| `internal.sandboxContainerImage.tag` | **Tag**|**Type:** `string`<br/>**Default:** `"3.9"`|
| `internal.teleport` | **Teleport**|**Type:** `object`<br/>|
| `internal.teleport.enabled` | **Enable teleport**|**Type:** `boolean`<br/>**Default:** `true`|
| `internal.teleport.proxyAddr` | **Teleport proxy address**|**Type:** `string`<br/>**Default:** `"teleport.giantswarm.io:443"`|
| `internal.teleport.version` | **Teleport version**|**Type:** `string`<br/>**Default:** `"14.1.3"`|

### Connectivity
Properties within the `.global.connectivity` object
Configurations related to cluster connectivity such as container registries.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.connectivity.baseDomain` | **Base DNS domain**|**Type:** `string`<br/>|
| `global.connectivity.containerRegistries` | **Container registries** - Endpoints and credentials configuration for container registries.|**Type:** `object`<br/>**Default:** `{}`|
| `global.connectivity.containerRegistries.*` |**None**|**Type:** `array`<br/>|
| `global.connectivity.containerRegistries.*[*]` |**None**|**Type:** `object`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials` | **Credentials** - Credentials for the endpoint.|**Type:** `object`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials.auth` | **Auth** - Base64-encoded string from the concatenation of the username, a colon, and the password.|**Type:** `string`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials.identitytoken` | **Identity token** - Used to authenticate the user and obtain an access token for the registry.|**Type:** `string`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials.password` | **Password** - Used to authenticate for the registry with username/password.|**Type:** `string`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials.username` | **Username** - Used to authenticate for the registry with username/password.|**Type:** `string`<br/>|
| `global.connectivity.containerRegistries.*[*].endpoint` | **Endpoint** - Endpoint for the container registry.|**Type:** `string`<br/>|
| `global.connectivity.localRegistryCache` | **Local registry cache** - Caching container registry within the cluster.|**Type:** `object`<br/>|
| `global.connectivity.localRegistryCache.enabled` | **Enable** - Enabling this will deploy the Zot registry service in the cluster. To make use of it as a pull-through cache, you also have to specify registries to cache images for.|**Type:** `boolean`<br/>**Default:** `false`|
| `global.connectivity.localRegistryCache.mirroredRegistries` | **Registries to cache** - Here you must specify each registry to cache container images for. Please also make sure to have an entry for each registry in Global > Components > Containerd > Container registries.|**Type:** `array`<br/>**Default:** `[]`|
| `global.connectivity.localRegistryCache.mirroredRegistries[*]` |**None**|**Type:** `string`<br/>|
| `global.connectivity.localRegistryCache.port` | **Service port** - NodePort used by the local registry service.|**Type:** `integer`<br/>**Default:** `32767`|
| `global.connectivity.network` | **Network**|**Type:** `object`<br/>|
| `global.connectivity.network.controlPlaneEndpoint` | **Endpoint** - Kubernetes API configuration.|**Type:** `object`<br/>|
| `global.connectivity.network.controlPlaneEndpoint.host` | **Host** - IP for access to the Kubernetes API. Manually select an IP for kube API. Empty string for auto selection from the ipPoolName pool.|**Type:** `string`<br/>|
| `global.connectivity.network.controlPlaneEndpoint.ipPoolName` | **Ip Pool Name** - Ip for control plane will be drawn from this GlobalInClusterIPPool resource.|**Type:** `string`<br/>**Value pattern:** `^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$`<br/>**Default:** `"wc-cp-ips"`|
| `global.connectivity.network.controlPlaneEndpoint.port` | **Port number** - Port for access to the Kubernetes API.|**Type:** `integer`<br/>**Default:** `6443`|
| `global.connectivity.network.loadBalancers` | **Load balancers** - Loadbalancer IP source.|**Type:** `object`<br/>|
| `global.connectivity.network.loadBalancers.cidrBlocks` |**None**|**Type:** `array`<br/>|
| `global.connectivity.network.loadBalancers.cidrBlocks[*]` |IPv4 address range, in CIDR notation.|**Type:** `string`<br/>**Example:** `"10.244.0.0/16"`<br/>**Value pattern:** `^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(/([0-9]|[1,2][0-9]|[3][0-2]))?$`<br/>|
| `global.connectivity.network.loadBalancers.ipPoolName` | **Ip Pool Name** - Ip for Service LB running in WC will be drawn from this GlobalInClusterIPPool resource.|**Type:** `string`<br/>**Value pattern:** `^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$`<br/>**Default:** `"svc-lb-ips"`|
| `global.connectivity.network.pods` | **Pods**|**Type:** `object`<br/>|
| `global.connectivity.network.pods.cidrBlocks` |**None**|**Type:** `array`<br/>|
| `global.connectivity.network.pods.cidrBlocks[*]` |IPv4 address range, in CIDR notation.|**Type:** `string`<br/>**Example:** `"10.244.0.0/16"`<br/>**Value pattern:** `^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(/([0-9]|[1,2][0-9]|[3][0-2]))?$`<br/>|
| `global.connectivity.network.services` | **Services**|**Type:** `object`<br/>|
| `global.connectivity.network.services.cidrBlocks` |**None**|**Type:** `array`<br/>|
| `global.connectivity.network.services.cidrBlocks[*]` |IPv4 address range, in CIDR notation.|**Type:** `string`<br/>**Example:** `"10.244.0.0/16"`<br/>**Value pattern:** `^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(/([0-9]|[1,2][0-9]|[3][0-2]))?$`<br/>|
| `global.connectivity.proxy` | **Proxy** - Whether/how outgoing traffic is routed through proxy servers.|**Type:** `object`<br/>|
| `global.connectivity.proxy.enabled` | **Enable**|**Type:** `boolean`<br/>|
| `global.connectivity.proxy.secretName` | **Secret name** - Name of a secret resource used by containerd to obtain the HTTP_PROXY, HTTPS_PROXY, and NO_PROXY environment variables. If empty the value will be defaulted to <clusterName>-cluster-values.|**Type:** `string`<br/>**Value pattern:** `^[a-z0-9-]{0,63}$`<br/>|
| `global.connectivity.shell` | **Shell access**|**Type:** `object`<br/>|
| `global.connectivity.shell.osUsers` | **OS Users** - Configuration for OS users in cluster nodes.|**Type:** `array`<br/>**Default:** `[{"name":"giantswarm","sudo":"ALL=(ALL) NOPASSWD:ALL"}]`|
| `global.connectivity.shell.osUsers[*]` | **User**|**Type:** `object`<br/>|
| `global.connectivity.shell.osUsers[*].name` | **Name** - Username of the user.|**Type:** `string`<br/>**Value pattern:** `^[a-z][-a-z0-9]+$`<br/>|
| `global.connectivity.shell.osUsers[*].sudo` | **Sudoers configuration** - Permissions string to add to /etc/sudoers for this user.|**Type:** `string`<br/>|
| `global.connectivity.shell.sshTrustedUserCAKeys` | **Trusted SSH cert issuers** - CA certificates of issuers that are trusted to sign SSH user certificates.|**Type:** `array`<br/>**Default:** `["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4cvZ01fLmO9cJbWUj7sfF+NhECgy+Cl0bazSrZX7sU vault-ca@vault.operations.giantswarm.io"]`|
| `global.connectivity.shell.sshTrustedUserCAKeys[*]` |**None**|**Type:** `string`<br/>|

### Control plane
Properties within the `.global.controlPlane` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.controlPlane.image` | **Node container image**|**Type:** `object`<br/>|
| `global.controlPlane.image.repository` | **Repository**|**Type:** `string`<br/>**Default:** `"gsoci.azurecr.io/giantswarm"`|
| `global.controlPlane.machineTemplate` | **Template to define control plane nodes**|**Type:** `object`<br/>|
| `global.controlPlane.machineTemplate.cloneMode` | **VM template clone mode**|**Type:** `string`<br/>**Default:** `"linkedClone"`|
| `global.controlPlane.machineTemplate.diskGiB` | **Disk size**|**Type:** `integer`<br/>**Example:** `30`<br/>|
| `global.controlPlane.machineTemplate.memoryMiB` | **Memory size**|**Type:** `integer`<br/>**Example:** `8192`<br/>|
| `global.controlPlane.machineTemplate.network` | **Network configuration**|**Type:** `object`<br/>|
| `global.controlPlane.machineTemplate.network.devices` | **Network devices** - Network interface configuration for VMs.|**Type:** `array`<br/>|
| `global.controlPlane.machineTemplate.network.devices[*]` | **Devices**|**Type:** `object`<br/>|
| `global.controlPlane.machineTemplate.network.devices[*].dhcp4` | **IPv4 DHCP** - Is DHCP enabled on this segment.|**Type:** `boolean`<br/>|
| `global.controlPlane.machineTemplate.network.devices[*].networkName` | **Segment name** - Segment name to attach nodes to. Must already exist.|**Type:** `string`<br/>|
| `global.controlPlane.machineTemplate.numCPUs` | **Number of CPUs**|**Type:** `integer`<br/>**Example:** `6`<br/>|
| `global.controlPlane.machineTemplate.resourcePool` | **VSphere resource pool name**|**Type:** `string`<br/>**Default:** `"*/Resources"`|
| `global.controlPlane.machineTemplate.template` | **VM template**|**Type:** `string`<br/>**Default:** `"flatcar-stable-3815.2.2-kube-v1.27.14-gs"`|
| `global.controlPlane.oidc` | **OIDC authentication**|**Type:** `object`<br/>|
| `global.controlPlane.oidc.caFile` | **Certificate authority file** - Path to identity provider's CA certificate in PEM format.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.clientId` | **Client ID** - OIDC client identifier to identify with.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.groupsClaim` | **Groups claim** - Name of the identity token claim bearing the user's group memberships.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.groupsPrefix` | **Groups prefix** - Prefix prepended to groups values to prevent clashes with existing names.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.issuerUrl` | **Issuer URL** - URL of the provider which allows the API server to discover public signing keys, not including any path. Discovery URL without the '/.well-known/openid-configuration' part.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.usernameClaim` | **Username claim** - Name of the identity token claim bearing the unique user identifier.|**Type:** `string`<br/>|
| `global.controlPlane.oidc.usernamePrefix` | **Username prefix** - Prefix prepended to username values to prevent clashes with existing names.|**Type:** `string`<br/>|
| `global.controlPlane.replicas` | **Number of nodes**|**Type:** `integer`<br/>|
| `global.controlPlane.resourceRatio` | **Resource ratio** - Ratio between node resources and apiserver resource requests.|**Type:** `integer`<br/>**Default:** `8`|

### Metadata
Properties within the `.global.metadata` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.metadata.description` | **Cluster description** - User-friendly description of the cluster's purpose.|**Type:** `string`<br/>|
| `global.metadata.labels` | **Labels** - These labels are added to the Kubernetes resources defining this cluster.|**Type:** `object`<br/>|
| `global.metadata.labels.PATTERN` | **Label**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-zA-Z0-9/\._-]+$`<br/>**Value pattern:** `^[a-zA-Z0-9\._-]+$`<br/>|
| `global.metadata.organization` | **Organization**|**Type:** `string`<br/>|
| `global.metadata.preventDeletion` | **Prevent cluster deletion**|**Type:** `boolean`<br/>**Default:** `false`|
| `global.metadata.servicePriority` | **Service priority** - The relative importance of this cluster.|**Type:** `string`<br/>**Default:** `"highest"`|

### Node pools
Properties within the `.global.nodePools` object
Groups of worker nodes with identical configuration.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.nodePools.PATTERN` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.worker` | **Default nodePool**|**Type:** `object`<br/>|
| `global.nodePools.worker.cloneMode` | **VM template clone mode**|**Type:** `string`<br/>**Default:** `"linkedClone"`|
| `global.nodePools.worker.diskGiB` | **Disk size**|**Type:** `integer`<br/>**Example:** `30`<br/>|
| `global.nodePools.worker.memoryMiB` | **Memory size**|**Type:** `integer`<br/>**Example:** `8192`<br/>|
| `global.nodePools.worker.network` | **Network configuration**|**Type:** `object`<br/>|
| `global.nodePools.worker.network.devices` | **Network devices** - Network interface configuration for VMs.|**Type:** `array`<br/>|
| `global.nodePools.worker.network.devices[*]` | **Devices**|**Type:** `object`<br/>|
| `global.nodePools.worker.network.devices[*].dhcp4` | **IPv4 DHCP** - Is DHCP enabled on this segment.|**Type:** `boolean`<br/>|
| `global.nodePools.worker.network.devices[*].networkName` | **Segment name** - Segment name to attach nodes to. Must already exist.|**Type:** `string`<br/>|
| `global.nodePools.worker.numCPUs` | **Number of CPUs**|**Type:** `integer`<br/>**Example:** `6`<br/>|
| `global.nodePools.worker.replicas` | **Number of nodes**|**Type:** `integer`<br/>**Default:** `2`|
| `global.nodePools.worker.resourcePool` | **VSphere resource pool name**|**Type:** `string`<br/>**Default:** `"*/Resources"`|
| `global.nodePools.worker.template` | **VM template**|**Type:** `string`<br/>**Default:** `"flatcar-stable-3815.2.2-kube-v1.27.14-gs"`|

### Pod Security Standards
Properties within the `.global.podSecurityStandards` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.podSecurityStandards.enforced` | **Enforced Pod Security Standards** - Use PSSs instead of PSPs.|**Type:** `boolean`<br/>**Default:** `true`|

### Provider specific configuration
Properties within the `.global.providerSpecific` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.providerSpecific.vcenter` | **VCenter** - Configuration for vSphere API access.|**Type:** `object`<br/>|
| `global.providerSpecific.vcenter.datacenter` | **Datacenter** - Name of the datacenter to deploy nodes into.|**Type:** `string`<br/>|
| `global.providerSpecific.vcenter.datastore` | **Datastore** - Name of the datastore for node disk storage.|**Type:** `string`<br/>|
| `global.providerSpecific.vcenter.password` | **Password** - Password for the VSphere API.|**Type:** `string`<br/>|
| `global.providerSpecific.vcenter.region` | **Region** - Category name in VSphere for topology.kubernetes.io/region labels.|**Type:** `string`<br/>|
| `global.providerSpecific.vcenter.server` | **Server** - URL of the VSphere API.|**Type:** `string`<br/>|
| `global.providerSpecific.vcenter.thumbprint` | **Thumbprint** - TLS certificate signature of the VSphere API.|**Type:** `string`<br/>|
| `global.providerSpecific.vcenter.username` | **Username** - Username for the VSphere API.|**Type:** `string`<br/>|
| `global.providerSpecific.vcenter.zone` | **Zone** - Category name in VSphere for topology.kubernetes.io/zone labels.|**Type:** `string`<br/>|

### Other

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `baseDomain` | **Base DNS domain**|**Type:** `string`<br/>|
| `managementCluster` | **Management cluster name**|**Type:** `string`<br/>|
| `provider` | **Provider name**|**Type:** `string`<br/>|



<!-- DOCS_END -->