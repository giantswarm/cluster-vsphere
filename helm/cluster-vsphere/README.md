# Values schema documentation

This page lists all available configuration options, based on the [configuration values schema](values.schema.json).

<!-- DOCS_START -->

### 
Properties within the `.internal` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `internal.kubectlImage` | **Kubectl image** - Used by cluster-shared library chart to configure coredns in-cluster.|**Type:** `[object]`<br/>|
| `internal.kubectlImage.name` | **Repository**|**Type:** `[string]`<br/>**Default:** `"giantswarm/kubectl"`|
| `internal.kubectlImage.registry` | **Registry**|**Type:** `[string]`<br/>**Default:** `"gsoci.azurecr.io"`|
| `internal.kubectlImage.tag` | **Tag**|**Type:** `[string]`<br/>**Default:** `"1.29.9"`|

### Components
Properties within the `.global.components` object
Advanced configuration of components that are running on all nodes.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.components.containerd` | **Containerd** - Configuration of containerd.|**Type:** `[object]`<br/>|
| `global.components.containerd.containerRegistries` | **Container registries** - Endpoints and credentials configuration for container registries.|**Type:** `[object]`<br/>**Default:** `{}`|
| `global.components.containerd.containerRegistries.*` | **Registries** - Container registries and mirrors|**Type:** `[array]`<br/>|
| `global.components.containerd.containerRegistries.*[*]` | **Registry**|**Type:** `[object]`<br/>|
| `global.components.containerd.containerRegistries.*[*].credentials` | **Credentials**|**Type:** `[object]`<br/>|
| `global.components.containerd.containerRegistries.*[*].credentials.auth` | **Auth** - Base64-encoded string from the concatenation of the username, a colon, and the password.|**Type:** `[string]`<br/>|
| `global.components.containerd.containerRegistries.*[*].credentials.identitytoken` | **Identity token** - Used to authenticate the user and obtain an access token for the registry.|**Type:** `[string]`<br/>|
| `global.components.containerd.containerRegistries.*[*].credentials.password` | **Password** - Used to authenticate for the registry with username/password.|**Type:** `[string]`<br/>|
| `global.components.containerd.containerRegistries.*[*].credentials.username` | **Username** - Used to authenticate for the registry with username/password.|**Type:** `[string]`<br/>|
| `global.components.containerd.containerRegistries.*[*].endpoint` | **Endpoint** - Endpoint for the container registry.|**Type:** `[string]`<br/>|
| `global.components.containerd.localRegistryCache` | **Local registry caches configuration** - Enable local cache via http://127.0.0.1:<PORT>.|**Type:** `[object]`<br/>|
| `global.components.containerd.localRegistryCache.enabled` | **Enable local registry caches** - Flag to enable local registry cache.|**Type:** `[boolean]`<br/>**Default:** `false`|
| `global.components.containerd.localRegistryCache.mirroredRegistries` | **Registries to cache locally** - A list of registries that should be cached.|**Type:** `[array]`<br/>**Default:** `[]`|
| `global.components.containerd.localRegistryCache.mirroredRegistries[*]` |**None**|**Type:** `[string]`<br/>|
| `global.components.containerd.localRegistryCache.port` | **Local port for the registry cache** - Port for the local registry cache under: http://127.0.0.1:<PORT>.|**Type:** `[integer]`<br/>**Default:** `32767`|
| `global.components.containerd.managementClusterRegistryCache` | **Management cluster registry cache** - Caching container registry on a management cluster level.|**Type:** `[object]`<br/>|
| `global.components.containerd.managementClusterRegistryCache.enabled` | **Enabled** - Enabling this will configure containerd to use management cluster's Zot registry service. To make use of it as a pull-through cache, you also have to specify registries to cache images for.|**Type:** `[boolean]`<br/>**Default:** `true`|
| `global.components.containerd.managementClusterRegistryCache.mirroredRegistries` | **Registries to cache** - Here you must specify each registry to cache container images for. Please also make sure to have an entry for each registry in Global > Components > Containerd > Container registries.|**Type:** `[array]`<br/>**Default:** `[]`|
| `global.components.containerd.managementClusterRegistryCache.mirroredRegistries[*]` |**None**|**Type:** `[string]`<br/>|
| `global.components.containerd.selinux` | **SELinux configuration** - SELinux configuration for containerd.|**Type:** `[object]`<br/>|
| `global.components.containerd.selinux.enabled` | **Enabled** - Enabling this will configure containerd to do SELinux relabeling to containers.|**Type:** `[boolean]`<br/>**Default:** `false`|

### Connectivity
Properties within the `.global.connectivity` object
Configurations related to cluster connectivity such as container registries.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.connectivity.baseDomain` | **Base DNS domain**|**Type:** `[string]`<br/>|
| `global.connectivity.containerRegistries` | **Container registries** - Endpoints and credentials configuration for container registries.|**Type:** `[object]`<br/>**Default:** `{}`|
| `global.connectivity.containerRegistries.*` |**None**|**Type:** `[array]`<br/>|
| `global.connectivity.containerRegistries.*[*]` |**None**|**Type:** `[object]`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials` | **Credentials** - Credentials for the endpoint.|**Type:** `[object]`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials.auth` | **Auth** - Base64-encoded string from the concatenation of the username, a colon, and the password.|**Type:** `[string]`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials.identitytoken` | **Identity token** - Used to authenticate the user and obtain an access token for the registry.|**Type:** `[string]`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials.password` | **Password** - Used to authenticate for the registry with username/password.|**Type:** `[string]`<br/>|
| `global.connectivity.containerRegistries.*[*].credentials.username` | **Username** - Used to authenticate for the registry with username/password.|**Type:** `[string]`<br/>|
| `global.connectivity.containerRegistries.*[*].endpoint` | **Endpoint** - Endpoint for the container registry.|**Type:** `[string]`<br/>|
| `global.connectivity.localRegistryCache` | **Local registry cache** - Caching container registry within the cluster.|**Type:** `[object]`<br/>|
| `global.connectivity.localRegistryCache.enabled` | **Enable** - Enabling this will deploy the Zot registry service in the cluster. To make use of it as a pull-through cache, you also have to specify registries to cache images for.|**Type:** `[boolean]`<br/>**Default:** `false`|
| `global.connectivity.localRegistryCache.mirroredRegistries` | **Registries to cache** - Here you must specify each registry to cache container images for. Please also make sure to have an entry for each registry in Global > Components > Containerd > Container registries.|**Type:** `[array]`<br/>**Default:** `[]`|
| `global.connectivity.localRegistryCache.mirroredRegistries[*]` |**None**|**Type:** `[string]`<br/>|
| `global.connectivity.localRegistryCache.port` | **Service port** - NodePort used by the local registry service.|**Type:** `[integer]`<br/>**Default:** `32767`|
| `global.connectivity.network` | **Network**|**Type:** `[object]`<br/>|
| `global.connectivity.network.controlPlaneEndpoint` | **Endpoint** - Kubernetes API configuration.|**Type:** `[object]`<br/>|
| `global.connectivity.network.controlPlaneEndpoint.host` | **Host** - IP for access to the Kubernetes API. Manually select an IP for kube API. Empty string for auto selection from the ipPoolName pool.|**Type:** `[string]`<br/>|
| `global.connectivity.network.controlPlaneEndpoint.ipPoolName` | **Ip Pool Name** - Ip for control plane will be drawn from this GlobalInClusterIPPool resource.|**Type:** `[string]`<br/>**Value pattern:** `^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$`<br/>**Default:** `"wc-cp-ips"`|
| `global.connectivity.network.controlPlaneEndpoint.port` | **Port number** - Port for access to the Kubernetes API.|**Type:** `[integer]`<br/>**Default:** `6443`|
| `global.connectivity.network.loadBalancers` | **Load balancers** - Loadbalancer IP source.|**Type:** `[object]`<br/>|
| `global.connectivity.network.loadBalancers.cidrBlocks` |**None**|**Type:** `[array]`<br/>|
| `global.connectivity.network.loadBalancers.cidrBlocks[*]` |IPv4 address range, in CIDR notation.|**Type:** `[string]`<br/>**Example:** `"10.244.0.0/16"`<br/>**Value pattern:** `^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(/([0-9]|[1,2][0-9]|[3][0-2]))?$`<br/>|
| `global.connectivity.network.loadBalancers.ipPoolName` | **Ip Pool Name** - Ip for Service LB running in WC will be drawn from this GlobalInClusterIPPool resource.|**Type:** `[string]`<br/>**Value pattern:** `^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$`<br/>**Default:** `"svc-lb-ips"`|
| `global.connectivity.network.loadBalancers.numberOfIps` | **Number of LB IPs to reserve**|**Type:** `[integer]`<br/>**Default:** `3`|
| `global.connectivity.network.pods` | **Pods**|**Type:** `[object]`<br/>|
| `global.connectivity.network.pods.cidrBlocks` |**None**|**Type:** `[array]`<br/>|
| `global.connectivity.network.pods.cidrBlocks[*]` |IPv4 address range, in CIDR notation.|**Type:** `[string]`<br/>**Example:** `"10.244.0.0/16"`<br/>**Value pattern:** `^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(/([0-9]|[1,2][0-9]|[3][0-2]))?$`<br/>|
| `global.connectivity.network.services` | **Services**|**Type:** `[object]`<br/>|
| `global.connectivity.network.services.cidrBlocks` |**None**|**Type:** `[array]`<br/>|
| `global.connectivity.network.services.cidrBlocks[*]` |IPv4 address range, in CIDR notation.|**Type:** `[string]`<br/>**Example:** `"10.244.0.0/16"`<br/>**Value pattern:** `^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(/([0-9]|[1,2][0-9]|[3][0-2]))?$`<br/>|
| `global.connectivity.proxy` | **Proxy** - Whether/how outgoing traffic is routed through proxy servers.|**Type:** `[object]`<br/>|
| `global.connectivity.proxy.enabled` | **Enable**|**Type:** `[boolean]`<br/>|
| `global.connectivity.proxy.httpProxy` | **HTTP proxy** - HTTP proxy - To be passed to the HTTP_PROXY environment variable in all hosts.|**Type:** `[string]`<br/>|
| `global.connectivity.proxy.httpsProxy` | **HTTPS proxy** - HTTPS proxy - To be passed to the HTTPS_PROXY environment variable in all hosts.|**Type:** `[string]`<br/>|
| `global.connectivity.proxy.noProxy` | **No proxy** - No proxy - Comma-separated addresses to be passed to the NO_PROXY environment variable in all hosts.|**Type:** `[string]`<br/>|

### Control plane
Properties within the `.global.controlPlane` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.controlPlane.machineHealthCheck` | **Machine health check**|**Type:** `[object]`<br/>|
| `global.controlPlane.machineHealthCheck.enabled` | **Enabled** - Enable machine health checks.|**Type:** `[boolean]`<br/>**Default:** `true`|
| `global.controlPlane.machineHealthCheck.maxUnhealthy` | **Max unhealthy** - Maximum number or percentage of unhealthy nodes.|**Type:** `[string]`<br/>**Default:** `"40%"`|
| `global.controlPlane.machineHealthCheck.nodeStartupTimeout` | **Node startup timeout** - Time to wait for a node to become healthy.|**Type:** `[string]`<br/>**Default:** `"20m0s"`|
| `global.controlPlane.machineHealthCheck.unhealthyNotReadyTimeout` | **Unhealthy not ready timeout** - Time to wait for a node to become ready.|**Type:** `[string]`<br/>**Default:** `"10m0s"`|
| `global.controlPlane.machineHealthCheck.unhealthyUnknownTimeout` | **Unhealthy unknown timeout** - Time to wait for a node to become known.|**Type:** `[string]`<br/>**Default:** `"10m0s"`|
| `global.controlPlane.machineTemplate` | **Template to define control plane nodes**|**Type:** `[object]`<br/>|
| `global.controlPlane.machineTemplate.cloneMode` | **VM template clone mode**|**Type:** `[string]`<br/>**Default:** `"linkedClone"`|
| `global.controlPlane.machineTemplate.diskGiB` | **Disk size**|**Type:** `[integer]`<br/>**Example:** `30`<br/>|
| `global.controlPlane.machineTemplate.memoryMiB` | **Memory size**|**Type:** `[integer]`<br/>**Example:** `8192`<br/>|
| `global.controlPlane.machineTemplate.network` | **Network configuration**|**Type:** `[object]`<br/>|
| `global.controlPlane.machineTemplate.network.devices` | **Network devices** - Network interface configuration for VMs.|**Type:** `[array]`<br/>|
| `global.controlPlane.machineTemplate.network.devices[*]` | **Devices**|**Type:** `[object]`<br/>|
| `global.controlPlane.machineTemplate.network.devices[*].dhcp4` | **IPv4 DHCP** - Is DHCP enabled on this segment.|**Type:** `[boolean]`<br/>|
| `global.controlPlane.machineTemplate.network.devices[*].networkName` | **Segment name** - Segment name to attach nodes to. Must already exist.|**Type:** `[string]`<br/>|
| `global.controlPlane.machineTemplate.numCPUs` | **Number of CPUs**|**Type:** `[integer]`<br/>**Example:** `6`<br/>|
| `global.controlPlane.machineTemplate.resourcePool` | **VSphere resource pool name**|**Type:** `[string]`<br/>**Default:** `"*/Resources"`|
| `global.controlPlane.machineTemplate.template` | **VM template**|**Type:** `[string]`<br/>|
| `global.controlPlane.oidc` | **OIDC authentication**|**Type:** `[object]`<br/>|
| `global.controlPlane.oidc.caPem` | **Certificate authority file** - Path to identity provider's CA certificate in PEM format.|**Type:** `[string]`<br/>|
| `global.controlPlane.oidc.clientId` | **Client ID** - OIDC client identifier to identify with.|**Type:** `[string]`<br/>|
| `global.controlPlane.oidc.groupsClaim` | **Groups claim** - Name of the identity token claim bearing the user's group memberships.|**Type:** `[string]`<br/>|
| `global.controlPlane.oidc.issuerUrl` | **Issuer URL** - URL of the provider which allows the API server to discover public signing keys, not including any path. Discovery URL without the '/.well-known/openid-configuration' part.|**Type:** `[string]`<br/>|
| `global.controlPlane.oidc.usernameClaim` | **Username claim** - Name of the identity token claim bearing the unique user identifier.|**Type:** `[string]`<br/>|
| `global.controlPlane.replicas` | **Number of nodes**|**Type:** `[integer]`<br/>|

### Metadata
Properties within the `.global.metadata` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.metadata.description` | **Cluster description** - User-friendly description of the cluster's purpose.|**Type:** `[string]`<br/>|
| `global.metadata.labels` | **Labels** - These labels are added to the Kubernetes resources defining this cluster.|**Type:** `[object]`<br/>|
| `global.metadata.labels.PATTERN` | **Label**|**Type:** `[string]`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-zA-Z0-9/\._-]+$`<br/>**Value pattern:** `^[a-zA-Z0-9\._-]+$`<br/>|
| `global.metadata.name` | **Cluster name**|**Type:** `[string]`<br/>|
| `global.metadata.organization` | **Organization**|**Type:** `[string]`<br/>|
| `global.metadata.preventDeletion` | **Prevent cluster deletion**|**Type:** `[boolean]`<br/>**Default:** `false`|
| `global.metadata.servicePriority` | **Service priority** - The relative importance of this cluster.|**Type:** `[string]`<br/>**Default:** `"highest"`|

### Node pools
Properties within the `.global.nodePools` object
Groups of worker nodes with identical configuration.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.nodePools.PATTERN` |**None**|**Type:** `[object]`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9-]{3,10}$`<br/>|
| `global.nodePools.worker` | **Default nodePool**|**Type:** `[object]`<br/>|
| `global.nodePools.worker.cloneMode` | **VM template clone mode**|**Type:** `[string]`<br/>**Default:** `"linkedClone"`|
| `global.nodePools.worker.diskGiB` | **Disk size**|**Type:** `[integer]`<br/>**Example:** `30`<br/>|
| `global.nodePools.worker.machineHealthCheck` | **Machine health check**|**Type:** `[object]`<br/>|
| `global.nodePools.worker.machineHealthCheck.enabled` | **Enabled** - Enable machine health checks.|**Type:** `[boolean]`<br/>**Default:** `true`|
| `global.nodePools.worker.machineHealthCheck.maxUnhealthy` | **Max unhealthy** - Maximum number or percentage of unhealthy nodes.|**Type:** `[string]`<br/>**Default:** `"40%"`|
| `global.nodePools.worker.machineHealthCheck.nodeStartupTimeout` | **Node startup timeout** - Time to wait for a node to become healthy.|**Type:** `[string]`<br/>**Default:** `"20m0s"`|
| `global.nodePools.worker.machineHealthCheck.unhealthyNotReadyTimeout` | **Unhealthy not ready timeout** - Time to wait for a node to become ready.|**Type:** `[string]`<br/>**Default:** `"10m0s"`|
| `global.nodePools.worker.machineHealthCheck.unhealthyUnknownTimeout` | **Unhealthy unknown timeout** - Time to wait for a node to become known.|**Type:** `[string]`<br/>**Default:** `"10m0s"`|
| `global.nodePools.worker.memoryMiB` | **Memory size**|**Type:** `[integer]`<br/>**Example:** `8192`<br/>|
| `global.nodePools.worker.network` | **Network configuration**|**Type:** `[object]`<br/>|
| `global.nodePools.worker.network.devices` | **Network devices** - Network interface configuration for VMs.|**Type:** `[array]`<br/>|
| `global.nodePools.worker.network.devices[*]` | **Devices**|**Type:** `[object]`<br/>|
| `global.nodePools.worker.network.devices[*].dhcp4` | **IPv4 DHCP** - Is DHCP enabled on this segment.|**Type:** `[boolean]`<br/>|
| `global.nodePools.worker.network.devices[*].networkName` | **Segment name** - Segment name to attach nodes to. Must already exist.|**Type:** `[string]`<br/>|
| `global.nodePools.worker.numCPUs` | **Number of CPUs**|**Type:** `[integer]`<br/>**Example:** `6`<br/>|
| `global.nodePools.worker.replicas` | **Number of nodes**|**Type:** `[integer]`<br/>**Default:** `2`|
| `global.nodePools.worker.resourcePool` | **VSphere resource pool name**|**Type:** `[string]`<br/>**Default:** `"*/Resources"`|
| `global.nodePools.worker.template` | **VM template**|**Type:** `[string]`<br/>|

### Other global

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.managementCluster` | **Management cluster** - Name of the Cluster API cluster managing this workload cluster.|**Type:** `[string]`<br/>|

### Pod Security Standards
Properties within the `.global.podSecurityStandards` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.podSecurityStandards.enforced` | **Enforced Pod Security Standards** - Use PSSs instead of PSPs.|**Type:** `[boolean]`<br/>**Default:** `true`|

### Provider specific configuration
Properties within the `.global.providerSpecific` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.providerSpecific.additionalVsphereClusterAnnotations` | **Additional vsphere cluster annotations** - Additional annotations to be added to the vspherecluster custom resource.|**Type:** `[array]`<br/>**Default:** `[]`|
| `global.providerSpecific.additionalVsphereClusterAnnotations[*]` |**None**|**Type:** `[string]`<br/>**Example:** `"example.com/annotation: value"`<br/>|
| `global.providerSpecific.defaultStorageClass` | **Default Storage Class** - Configuration of the default storage class.|**Type:** `[object]`<br/>|
| `global.providerSpecific.defaultStorageClass.enabled` | **Enable default storage class** - Creates a default storage class if set to true.|**Type:** `[boolean]`<br/>**Default:** `true`|
| `global.providerSpecific.defaultStorageClass.reclaimPolicy` | **Reclaim Policy** - Reclaim policy of the storage class (Delete or Retain).|**Type:** `[string]`<br/>**Default:** `"Delete"`|
| `global.providerSpecific.defaultStorageClass.storagePolicyName` | **Storage Policy name** - Name of the vSphere storage policy to use in the storage class. Leave empty for no storage policy.|**Type:** `[string]`<br/>**Default:** `""`|
| `global.providerSpecific.templateSuffix` | **Template suffix** - Suffix to append to the VM template name to find the correct template.|**Type:** `[string]`<br/>**Default:** `""`|
| `global.providerSpecific.vcenter` | **VCenter** - Configuration for vSphere API access.|**Type:** `[object]`<br/>|
| `global.providerSpecific.vcenter.datacenter` | **Datacenter** - Name of the datacenter to deploy nodes into.|**Type:** `[string]`<br/>|
| `global.providerSpecific.vcenter.datastore` | **Datastore** - Name of the datastore for node disk storage.|**Type:** `[string]`<br/>|
| `global.providerSpecific.vcenter.password` | **Password** - Password for the VSphere API.|**Type:** `[string]`<br/>|
| `global.providerSpecific.vcenter.region` | **Region** - Category name in VSphere for topology.kubernetes.io/region labels.|**Type:** `[string]`<br/>|
| `global.providerSpecific.vcenter.server` | **Server** - URL of the VSphere API.|**Type:** `[string]`<br/>|
| `global.providerSpecific.vcenter.thumbprint` | **Thumbprint** - TLS certificate signature of the VSphere API.|**Type:** `[string]`<br/>|
| `global.providerSpecific.vcenter.username` | **Username** - Username for the VSphere API.|**Type:** `[string]`<br/>|
| `global.providerSpecific.vcenter.zone` | **Zone** - Category name in VSphere for topology.kubernetes.io/zone labels.|**Type:** `[string]`<br/>|

### Release
Properties within the `.global.release` object
Information about the workload cluster release.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.release.version` | **Version**|**Type:** `[string]`<br/>|

### Other

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `baseDomain` | **Base DNS domain**|**Type:** `[string]`<br/>|
| `cluster` | **Cluster** - Helm values for the provider-independent cluster chart.|**Type:** `[object]`<br/>**Default:** `{"internal":{"advancedConfiguration":{"controlPlane":{"apiServer":{"extraArgs":{"requestheader-allowed-names":"front-proxy-client"}}}}},"providerIntegration":{"apps":{"capiNodeLabeler":{"enable":true},"certExporter":{"configTemplateName":"vSphereCertExporterHelmValues","enable":true},"certManager":{"configTemplateName":"vSphereCertManagerHelmValues","enable":true},"chartOperatorExtensions":{"enable":true},"cilium":{"configTemplateName":"vSphereCiliumHelmValues","enable":true},"ciliumServiceMonitors":{"enable":true},"coreDns":{"enable":true},"coreDnsExtensions":{"enable":true},"etcdDefrag":{"enable":true},"etcdKubernetesResourcesCountExporter":{"enable":true},"k8sDnsNodeCache":{"enable":true},"metricsServer":{"enable":true},"netExporter":{"enable":true},"networkPolicies":{"configTemplateName":"vSphereNetworkPoliciesHelmValues","enable":true},"nodeExporter":{"configTemplateName":"vSphereNodeExporterHelmValues","enable":true},"observabilityBundle":{"enable":true},"observabilityPolicies":{"enable":true},"securityBundle":{"enable":true},"teleportKubeAgent":{"enable":true},"verticalPodAutoscaler":{"enable":true},"verticalPodAutoscalerCrd":{"enable":true}},"controlPlane":{"kubeadmConfig":{"files":[{"contentFrom":{"secret":{"key":"content","name":"kubevip-pod","prependClusterNameAsPrefix":true}},"path":"/etc/kubernetes/manifests/kube-vip.yaml","permissions":"0600"}],"postKubeadmCommands":["sed --in-place \"s|/etc/kubernetes/super-admin.conf|/etc/kubernetes/admin.conf|g\" /etc/kubernetes/manifests/kube-vip.yaml"]},"resources":{"infrastructureMachineTemplate":{"group":"infrastructure.cluster.x-k8s.io","kind":"VSphereMachineTemplate","version":"v1beta1"},"infrastructureMachineTemplateSpecTemplateName":"controlplane-vspheremachinetemplate-spec"}},"environmentVariables":{"hostName":"COREOS_CUSTOM_HOSTNAME","ipv4":"COREOS_CUSTOM_IPV4"},"kubeadmConfig":{"enableGiantswarmUser":true,"files":[{"contentFrom":{"secret":{"key":"set-hostname.sh","name":"provider-specific-files-1","prependClusterNameAsPrefix":true}},"path":"/opt/bin/set-hostname.sh","permissions":"0755"}],"ignition":{"containerLinuxConfig":{"additionalConfig":{"systemd":{"units":[{"contents":{"install":{"wantedBy":["multi-user.target"]},"unit":{"description":"VMWare metadata agent"}},"dropins":[{"contents":"[Unit]\nAfter=nss-lookup.target\nAfter=network-online.target\nWants=network-online.target\n[Service]\nType=oneshot\nRestart=on-failure\nRemainAfterExit=yes\nEnvironment=OUTPUT=/run/metadata/coreos\nExecStart=/usr/bin/mkdir --parent /run/metadata\nExecStart=/usr/bin/bash -cv 'echo \"COREOS_CUSTOM_HOSTNAME=$(\"$(find /usr/bin /usr/share/oem -name vmtoolsd -type f -executable 2\u003e/dev/null | head -n 1)\" --cmd \"info-get guestinfo.metadata\" | base64 -d | awk \\'/local-hostname/ {print $2}\\' | tr -d \\'\"\\')\" \u003e\u003e ${OUTPUT}'\nExecStart=/usr/bin/bash -cv 'echo \"COREOS_CUSTOM_IPV4=$(\"$(find /usr/bin /usr/share/oem -name vmtoolsd -type f -executable 2\u003e/dev/null | head -n 1)\" --cmd \"info-get guestinfo.ip\")\" \u003e\u003e ${OUTPUT}'","name":"10-coreos-metadata.conf"}],"enabled":true,"name":"coreos-metadata.service"},{"contents":{"install":{"wantedBy":["multi-user.target"]},"unit":{"description":"Set machine hostname"}},"dropins":[{"contents":"[Unit]\nRequires=coreos-metadata.service\nAfter=coreos-metadata.service\nBefore=teleport.service\n[Service]\nType=oneshot\nRemainAfterExit=yes\nEnvironmentFile=/run/metadata/coreos\nExecStart=/opt/bin/set-hostname.sh","name":"10-set-hostname.conf"}],"enabled":true,"name":"set-hostname.service"},{"contents":{"install":{"wantedBy":["default.target"]},"unit":{"description":"Disable TCP segmentation offloading"}},"dropins":[{"contents":"[Unit]\nAfter=network.target\n[Service]\nType=oneshot\nRemainAfterExit=yes\nExecStart=/usr/sbin/ethtool -K ens192 tx-udp_tnl-csum-segmentation off\nExecStart=/usr/sbin/ethtool -K ens192 tx-udp_tnl-segmentation off","name":"10-ethtool-segmentation.conf"}],"enabled":true,"name":"ethtool-segmentation.service"}]}}}},"postKubeadmCommands":["usermod -aG root nobody"]},"pauseProperties":{"global.connectivity.network.controlPlaneEndpoint.host":""},"provider":"vsphere","resourcesApi":{"bastionResourceEnabled":false,"cleanupHelmReleaseResourcesEnabled":true,"helmRepositoryResourcesEnabled":true,"infrastructureCluster":{"group":"infrastructure.cluster.x-k8s.io","kind":"VSphereCluster","version":"v1beta1"},"infrastructureMachinePool":{"group":"infrastructure.cluster.x-k8s.io","kind":"VSphereMachineTemplate","version":"v1beta1"},"nodePoolKind":"MachineDeployment"},"useReleases":true,"workers":{"defaultNodePools":{"def00":{"cloneMode":"linkedClone","machineHealthCheck":{"enabled":true,"maxUnhealthy":"40%","nodeStartupTimeout":"20m0s","unhealthyNotReadyTimeout":"10m0s","unhealthyUnknownTimeout":"10m0s"},"memoryMiB":16896,"network":{},"numCPUs":6,"replicas":2,"resourcePool":"*/Resources","template":""}},"resources":{"infrastructureMachineTemplateSpecTemplateName":"worker-vspheremachinetemplate-spec"}}}}`|
| `cluster-shared` | **Library chart**|**Type:** `[object]`<br/>|
| `managementCluster` | **Management cluster name**|**Type:** `[string]`<br/>|
| `provider` | **Provider name**|**Type:** `[string]`<br/>|



<!-- DOCS_END -->
