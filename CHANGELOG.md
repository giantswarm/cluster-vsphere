# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Rename caFile to caPem in values schema.

## [0.60.0] - 2024-08-22

### **Breaking change**.

> [!CAUTION]
> It is important that you check each of the sections in the upgrade guide below. Note that some may not apply to your specific cluster configuration. However, the cleanup section must always be run against the cluster values.

<details>
<summary>Upgrade guide: how to migrate values (from v0.59.0)</summary>

Use the snippets below if the section applies to your chart's values:

## Control Plane endpoint address

If the controlPlane endpoint IP (loadbalancer for the Kubernetes API) has been statically assigned (this likely will not apply to workload clusters) then this value will need to be duplicated to the extraCertificateSANs list. Also, any additional certificate SANs must be added to the extraCertificateSANs list.

```
yq eval --inplace 'with(select(.global.connectivity.network.controlPlaneEndpoint.host != null); .cluster.internal.advancedConfiguration.controlPlane.apiServer.extraCertificateSANs += [ .global.connectivity.network.controlPlaneEndpoint.host ]) |
    with(select(.internal.apiServer.certSANs != null); .cluster.internal.advancedConfiguration.controlPlane.apiServer.extraCertificateSANs += [ .internal.apiServer.certSANs[] ])' values.yaml
```

## API server admission plugins

The default list is [here](https://github.com/giantswarm/cluster/blob/main/helm/cluster/templates/clusterapi/controlplane/_helpers_clusterconfiguration_apiserver.tpl#L104). If you have not extended this list then you do not need to provide a list of admission plugins at all (defaults will be used from the cluster chart). If this is the case, please ignore the following command.

```
yq eval --inplace 'with(select(.internal.apiServer.enableAdmissionPlugins != null); .cluster.providerIntegration.controlPlane.kubeadmConfig.clusterConfiguration.apiServer.additionalAdmissionPlugins = .internal.apiServer.enableAdmissionPlugins)' values.yaml

```

## API server feature gates

There is no default list of feature gates in the shared cluster chart, so if you have any values under `.internal.apiServer.featureGates` then these must be migrated to the new location.

```
yq eval --inplace 'with(select(.internal.apiServer.featureGates != null); .cluster.providerIntegration.controlPlane.kubeadmConfig.clusterConfiguration.apiServer.featureGates = .internal.apiServer.featureGates)' values.yaml
```

## OIDC config

`caFile` has been renamed to `caPem`.

```
yq eval --inplace 'with(select(.global.controlPlane.oidc.caFile != null); .global.controlPlane.oidc.caPem = .global.controlPlane.oidc.caFile)' values.yaml
```

## SSH trusted CA keys

If you are providing additional trusted CA keys for SSH authentication (other than the default Giant Swarm key) then these need to migrated to the new location.

```
yq eval --inplace 'with(select(.global.connectivity.shell.sshTrustedUserCAKeys != null); .cluster.providerIntegration.connectivity.sshSsoPublicKey = .global.connectivity.shell.sshTrustedUserCAKeys)' values.yaml
```

## Upstream proxy settings

If your cluster is behind an upstream proxy (if `.global.connectivity.proxy.enabled: true`) then the proxy configuration must also be added to the cluster chart's values.

- `httpProxy`: upstream proxy protocol, address and port (e.g. `http://proxy-address:port`)
- `httpsProxy`: upstream proxy protocol, address and port (e.g. `http://proxy-address:port`)
- `noProxy`: comma-separated list of domains and IP CIDRs which should not be proxied (e.g. `10.10.10.0/24,internal.domain.com`)

Additional notes:

- Encryption is always enabled with the shared cluster chart, so this toggle is removed entirely (`.internal.enableEncryptionProvider`).
- OIDC `groupsPrefix` and `usernamePrefix` are removed.
- Upstream proxy configuration is no longer read from the `.global.connectivity.proxy.secretName` value.

## Cleanup

Final tidyup to remove deprecated values:

```
yq eval --inplace 'del(.internal.apiServer.enableAdmissionPlugins) |
    del(.internal.apiServer.featureGates) |
    del(.internal.apiServer.certSANs) |
    del(.internal.enableEncryptionProvider) |
    del(.global.controlPlane.oidc.caFile) |
    del(.global.controlPlane.oidc.groupsPrefix) |
    del(.global.controlPlane.oidc.usernamePrefix) |
    del(.global.connectivity.shell.sshTrustedUserCAKeys) |
    del(.global.connectivity.proxy.secretName) |
    del(.internal.apiServer) |
    del(.internal.controllerManager) |
    del(.internal.enableEncryptionProvider) ' values.yaml
```
</details>

- Use `giantswarm/cluster` chart to render `KubeadmControlPlane` resource.
- Update giantswarm/cluster chart to 1.2.1.

## [0.59.0] - 2024-08-12

### Changed

- Set `kubeProxyReplacement` to `'true'` instead of deprecated value `strict` in cilium values.
- Make default storage class configurable.

## [0.58.3] - 2024-08-04

### Changed

- Allow additional properties on machine templates to offer wider CAPV configurations.

## [0.58.2] - 2024-08-01

### Changed

- Disable IPAM for service load balancers if `.global.connectivity.network.loadBalancers.cidrBlocks` is set.

## [0.58.1] - 2024-07-31

### Changed

- Change `cluster` in kubectl patch command to `cluster.cluster.x-k8s.io` inside hooks in case more than one API group is present.

## [0.58.0] - 2024-07-30

### Fixed

- Fix syntax error with helmrelease cleanup hook.

### Changed

- Update `ipam` API versions to `v1beta1`.

## [0.57.1] - 2024-07-24

## [0.57.0] - 2024-07-22

### Changed

### **Breaking change**.

> [!CAUTION]
> The cluster name must be added to the cluster values when upgrading to this chart release.

<details>
<summary>How to migrate values (from v0.56.1)</summary>

The cluster's name must be added to the cluster values in order to satisfy the updated values
schema. This can be done by adding the existing cluster name to the `cluster` values. For example,
where the cluster is named `test`:

```yaml
global:
  metadata:
    name: test
```
</details>

- Initial integration of shared `cluster` chart to render `Cluster` resource.
- Corrected cluster names in CI values.

## [0.56.1] - 2024-07-16

### Added

- Unpause Cluster resource as part of cleanup hook after deletion in order to prevent leftover resources.

## [0.56.0] - 2024-07-10

### Changed

### **Breaking change**.

> [!CAUTION]
> Upgrading to this chart release will cause all worker nodes to be replaced.

<details>
<summary>How to migrate values (from `v0.54.0` or later)</summary>

Using `yq`, migrate to the new values layout with the following command:

```bash
yq eval --inplace 'with(select(.global.nodeClasses != null);    .global.nodeClasses as $classes | with(.global.nodePools[]; . *= $classes[.class])) |

    del(.global.nodePools[].class) |
    del(.global.nodeClasses)' values.yaml
```

</details>

### Changed

- Move Helm values from each `.global.nodeClasses.$<class>` to any nodePool which references that class.
- Deleted Helm values property `.global.nodeClasses`.

### Fixed

- Correct default values for `network`s in values schema.

## [0.55.0] - 2024-06-25

### Changed

- Bump `cloud-provider-vsphere` to `1.7.0` for **Kubernetes 1.27** compatibility.
  - Update **vSphere CSI** to `3.2.0`.
  - Update **vSphere CPI** to `1.27.0`.
  - Update **kube-vip** to `0.8.0`.
  - Update **kube-vip-cloud-provider** to `0.0.5`.

## [0.54.0] - 2024-06-25

### Added

- Add `.global.connectivity.localRegistryCache` Helm values and support for in-cluster, local registry cache mirrors in containerd configuration.
  In such cases, the registry should be exposed via node ports and containerd connects via that port at 127.0.0.1 via HTTP (only allowed for this single use case).

### Fixed

- Fixed `containerd` config file generation when multiple registries are set with authentication

### Removed

- Stop setting `defaultPolicies.enabled=true` in `cilium-app` when `internal.ciliumNetworkPolicy.enabled=true` after all clusters are migrated.
- Stop setting `extraPolicies.remove=true` in `cilium-app` after all clusters are migrated.


## [0.53.1] - 2024-06-09

### Fixed

- Refer the API group (`ipam.cluster.x-k8s.io`) of `cluster-api-ipam-provider-in-cluster` for `ipaddresses` CRs to not use the built-in Kubernetes group (`networking.k8s.io/v1alpha1`).

## [0.53.0] - 2024-06-06

### Changed

- Remove kube-vip values to rely on the defaults of `cloud-provider-vsphere-app`.
- Bump k8s version from `1.26.15` to `1.27.14`.

## [0.52.0] - 2024-05-23

### Changed

- Normalise JSON schema.
- Remove unused values from schema.
- Update example manifests post-refactor.
- Improve values schema with definitions to make it more DRY.
- Bump k8s version from `1.25.16` to `1.26.15`.

## [0.51.0] - 2024-05-16

### **Breaking change**.

<details>
<summary>How to migrate values</summary>

Using `yq`, migrate to the new values layout with the following command:

```bash
#!/bin/bash
yq eval --inplace 'with(select(.metadata != null);          .global.metadata = .metadata) |
    with(select(.clusterDescription != null);               .global.metadata.description = .clusterDescription) |
    with(select(.organization != null);                     .global.metadata.organization = .organization) |
    with(select(.clusterLabels != null);                    .global.metadata.labels = .clusterLabels) |
    with(select(.servicePriority != null);                  .global.metadata.servicePriority = .servicePriority) |
    with(select(.connectivity != null);                     .global.connectivity = .connectivity) |
    with(select(.osUsers != null);                          .global.connectivity.shell.osUsers = .osUsers) |
    with(select(.sshTrustedUserCAKeys != null);             .global.connectivity.shell.sshTrustedUserCAKeys = .sshTrustedUserCAKeys) |
    with(select(.proxy != null);                            .global.connectivity.proxy = .proxy) |
    with(select(.baseDomain != null);                       .global.connectivity.baseDomain = .baseDomain) |
    with(select(.controlPlane != null);                     .global.controlPlane = .controlPlane) |
    with(select(.oidc != null);                             .global.controlPlane.oidc = .oidc) |
    with(select(.nodePools != null);                        .global.nodePools = .nodePools) |
    with(select(.vcenter != null);                          .global.providerSpecific.vcenter = .vcenter) |
    with(select(.cluster.kubernetesVersion != null);        .internal.kubernetesVersion = .cluster.kubernetesVersion) |
    with(select(.cluster.enableEncryptionProvider != null); .internal.enableEncryptionProvider = .cluster.enableEncryptionProvider) |
    with(select(.controllerManager.featureGates != null);   .internal.controllerManager.featureGates = (.controllerManager.featureGates | split(","))) |
    with(select(.apiServer.enableAdmissionPlugins != null); .internal.apiServer.enableAdmissionPlugins = (.apiServer.enableAdmissionPlugins | split(","))) |
    with(select(.apiServer.featureGates != null);           .internal.apiServer.featureGates = (.apiServer.featureGates | split(","))) |
    with(select(.apiServer.certSANs != null);               .internal.apiServer.certSANs = .apiServer.certSANs) |
    with(select(.kubectlImage != null);                     .internal.kubectlImage = .kubectlImage) |
    with(select(.nodeClasses != null);                      .global.nodeClasses = .nodeClasses) |

    del(.metadata) |
    del(.clusterDescription) |
    del(.organization) |
    del(.clusterLabels) |
    del(.servicePriority) |
    del(.connectivity) |
    del(.osUsers) |
    del(.sshTrustedUserCAKeys) |
    del(.proxy) |
    del(.baseDomain) |
    del(.controlPlane) |
    del(.oidc) |
    del(.nodePools) |
    del(.vcenter) |
    del(.cluster) |
    del(.controllerManager) |
    del(.apiServer) |
    del(.kubectlImage) |
    del(.nodeClasses)' values.yaml
```

</details>

### Changed

- Move Helm values property `.Values.metadata` to `.Values.global.metadata`.
- Move Helm values property `.Values.clusterDescription` to `.Values.global.metadata.description`.
- Move Helm values property `.Values.organization` to `.Values.global.metadata.organization`.
- Move Helm values property `.Values.clusterLabels` to `.Values.global.metadata.labels`.
- Move Helm values property `.Values.servicePriority` to `.Values.global.metadata.servicePriority`.
- Move Helm values property `.Values.connectivity` to `.Values.global.connectivity`.
- Move Helm values property `.Values.proxy` to `.Values.global.connectivity.proxy`.
- Move Helm values property `.Values.osUsers` to `.Values.global.connectivity.shell.osUsers`.
- Move Helm values property `.Values.sshTrustedUserCAKeys` to `.Values.global.connectivity.shell.sshTrustedUserCAKeys`.
- Move Helm values property `.Values.baseDomain` to `.Values.global.connectivity.baseDomain`.
- Move Helm values property `.Values.controlPlane` to `.Values.global.controlPlane`.
- Move Helm values property `.Values.oidc` to `.Values.global.controlPlane.oidc`.
- Move Helm values property `.Values.nodePools` to `.Values.global.nodePools`.
- Move Helm values property `.Values.vcenter` to `.Values.global.providerSpecific.vcenter`.
- Move Helm values property `.Values.controllerManager.featureGates` to `.Values.internal.controllerManager.featureGates` and convert from string to array.
- Move Helm values property `.Values.apiServer.enableAdmissionPlugins` to `.Values.internal.apiServer.enableAdmissionPlugins` and convert from string to array.
- Move Helm values property `.Values.apiServer.featureGates` to `.Values.internal.apiServer.featureGates` and convert from string to array.
- Move Helm values property `.Values.apiServer.certSANs` to `.Values.internal.apiServer.certSANs`.
- Move Helm values property `.Values.kubectlImage` to `.Values.internal.kubectlImage`.
- Move Helm values property `.Values.nodeClasses` to `.Values.global.nodeClasses`.

## [0.50.0] - 2024-04-23

### Changed

- No major change in `v0.50.0`, except that we are moving to a [release based upgrade cycle](https://github.com/giantswarm/roadmap/issues/3392) with Kubernetes version, VM template and other defaults are set in the chart values. They shouldn't be overridden as they are managed by Giant Swarm.
- Bump `kube-vip` to `v0.8.0`.

## [0.10.3] - 2024-04-08

### Changed

- Move extraPolicies from cilium-app to network-policies-app.
- Add `svc-lb-ips` as default IP Pool for service of type load balancer in workload clusters.

## [0.10.2] - 2024-04-02

### Changed

- Pull `kube-vip` image from Azure CR.
- Update teleport node labels - add `ins=` label and remove `cluster=` label condition check, such that MC nodes have this label.

## [0.10.1] - 2024-03-07

### Changed

- Bump Cilium to `0.21.0`.

## [0.10.0] - 2024-02-27

### Added

- Add CiliumNetworkPolicies for the cleanup job.
- Add flags to disable PSPs.
- Add `global.metadata.preventDeletion` to add the [deletion prevention label](https://docs.giantswarm.io/advanced/deletion-prevention/) to Cluster resources.

### Changed

- Switch container registry to `gsoci.azurecr.io`.
- Adapt cleanup hook for cluster policies.

## [0.9.9] - 2024-02-14

### Changed

- Bump netpol app which disables the coredns `CiliumClusterwideNetworkPolicy`.

## [0.9.8] - 2024-02-12

### Added

- Include support for schemadocs to generate Chart README file

## [0.9.7] - 2024-01-23

### Added

- Add teleport.service: Secure SSH access via Teleport

### Changed

- Bump Cilium to `0.19.2`.

## [0.9.6] - 2023-12-14

### Added

- Add vSphere icon.

### Fixed

- Fix cleanup of netpol helmrelease.

## [0.9.5] - 2023-12-12

### Fixed

- Fix templating issues of feature-gates.

## [0.9.4] - 2023-12-11

## [0.9.3] - 2023-12-07

### Added

- If `connectivity.network.allowAllEgress` is false (which is the default value), the deny-all network policies for
namespaces `giantswarm` and `kube-system` will be applied to the resulting cluster. In terms of API, this is a compatible
change but in terms of internal behavior it can be potentially :boom: **Breaking:**.

### Changed

- Remove `TTLAfterFinished` flag for Kubernetes 1.25 compatibility (enabled by default).
- Remove `ExpandPersistentVolumes` flag for Kubernetes 1.27 compatibility (enabled by default).
- Remove `logtostderr` for Kubernetes 1.27 compatibility (output is logged to stderr by default).

## [0.9.2] - 2023-11-15

### Fixed

- Minor fix and use of `--ignore-not-found` in IPAM.

## [0.9.1] - 2023-11-15

### Changed

- Bump `cilium` to `0.17.0`.
- Bump `coredns` to `1.19.0`.
- Enable renovate for `cilium` and `coredns`.


## [0.9.0] - 2023-11-08

### Changed

- :boom: **Breaking:** Switch from Ubuntu to Flatcar and start support ignition.

## [0.8.0] - 2023-10-31

### Added

- Add IPv4 addresses management (ipam) for WC's `kube-vip-cloud-provider`. If the ipPool is specified, currently one IP is requested from it
and is added to the end of the list for this controller. `kube-vip-cloud-provider` is part of our Service-lvl load balancer solution in WC and
at least 1 public IP is always needed for the ingress controller to be able to expose its stuff.

## [0.7.1] - 2023-09-04

### Fixed

- Remove leftover `helmchart` CRs.

## [0.7.0] - 2023-08-17

## [0.6.2] - 2023-08-01

### Changed

- Consolidate containerd `config.toml` into single file to address [#1737](https://github.com/giantswarm/roadmap/issues/1737)
- Add host OS user `nobody` to `root` group to enable node-exporter's `filesystem` collector to access the host filesystem.
- Bump `cilium` version to `0.10.0` 

## [0.6.1] - 2023-07-13

### Added

- Add a way to customize the timeout in `HelmRelease.spec`.
- Set value for `controller-manager` `terminated-pod-gc-threshold` to `125` ( consistent with vintage )
- Bump `cloud-provider-vsphere` version to `1.5.0` 

## [0.6.0] - 2023-07-04

### Added

- Add IPv4 addresses management (ipam) for WC's control planes.
- Add `connectivity.network.controlPlaneEndpoint.host` to `certSANs` list.
- Bind `kube-scheduler` metrics to 0.0.0.0.

## [0.5.1] - 2023-06-07

### Changed

- Bump the version of coredns-app to `1.16.0`

## [0.5.0] - 2023-05-22

### Changed

- :boom: **Breaking:** Stop deploying default network policies with the `cilium-app`. This means the cluster will be more locked down and all network traffic is blocked by default. Can be disabled with `network.allowAllEgress` setting. Requires `default-apps-vsphere@v0.9.2`.
- Bumped default k8s version to `1.24`, this might be :boom: **Breaking:**
- `.cluster.kubernetesVersion`: `v1.22.5+vmware.1` -> `v1.24.11`
- default machine template `ubuntu-2004-kube-v1.22.5+vmware.1` -> `ubuntu-2004-kube-v1.24.11`
- `.controlPlane.image.repository`: `projects.registry.vmware.com/tkg` -> `registry.k8s.io`
- Add audilog configuration.
- :boom: **Breaking:** Refactor api for network parameters to apply the standard interface for all providers.

### Fixed

- Set `/var/lib/kubelet` permissions to `0750` to fix `node-exporter` issue.

## [0.4.0] - 2023-04-24

### Added

- Add `MachineHealthCheck` for worker nodes.
- Add `loadBalancersCidrBlocks` parameter that is used by kube-vip for `LoadBalancer` services.
- Add `apiServer.certSANs` option.

### Changed

- Improve schema and ci values.
- :boom: **Breaking:** Change default pod network and service network to 10.244.0.0/16 and 10.96.0.0/16.
- :boom: **Breaking:** Install CoreDNS (`coredns-app`) using `HelmRelease` CR and stop deploying it with `cluster-shared` resource set.

### Fixed

- Set `.network.servicesCidrBlocks` value in Cluster CR.

### Removed

- Remove `cluster-shared` dependency.

## [0.3.1] - 2023-04-05

### Added

- Add `default-test` HelmRepository (catalog) for debugging.

### Changed

- Bump `cloud-provider-vsphere` version to `1.3.3`.

### Removed

- Remove unnecessary labels from HelmRepository CR.

## [0.3.0] - 2023-03-27

### Changed

- :boom: **Breaking:** Use cilium kube-proxy replacement.
- Bump `cloud-provider-vsphere` version to `1.3.2`.
- Use release name instead of `cluster.name`.
- Move `organization` to root level for uniformity.

## [0.2.1] - 2023-03-21

### Fixed

- Add missing files for CoreDNS configuration by cluster-shared.

## [0.2.0] - 2023-03-20

### Added

- Allow setting etcd image repository and tag.
- Set the default etcd version to 3.5.4 (kubeadm default is 3.5.0 which is not
  recommended in production).
- Set the default etcd image to retagged Giant Swarm one.

## [0.1.2] - 2022-05-09

## [0.1.1] - 2022-03-29

### Added

- Add CicleCI configuration.

## [0.1.0] - 2022-03-29

### Added

- Initial chart implementation.

[Unreleased]: https://github.com/giantswarm/cluster-vsphere/compare/v0.60.0...HEAD
[0.60.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.59.0...v0.60.0
[0.59.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.58.3...v0.59.0
[0.58.3]: https://github.com/giantswarm/cluster-vsphere/compare/v0.58.2...v0.58.3
[0.58.2]: https://github.com/giantswarm/cluster-vsphere/compare/v0.58.1...v0.58.2
[0.58.1]: https://github.com/giantswarm/cluster-vsphere/compare/v0.58.0...v0.58.1
[0.58.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.57.1...v0.58.0
[0.57.1]: https://github.com/giantswarm/cluster-vsphere/compare/v0.57.0...v0.57.1
[0.57.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.56.1...v0.57.0
[0.56.1]: https://github.com/giantswarm/cluster-vsphere/compare/v0.56.0...v0.56.1
[0.56.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.55.0...v0.56.0
[0.55.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.54.0...v0.55.0
[0.54.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.53.1...v0.54.0
[0.53.1]: https://github.com/giantswarm/cluster-vsphere/compare/v0.53.0...v0.53.1
[0.53.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.52.0...v0.53.0
[0.52.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.51.0...v0.52.0
[0.51.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.50.0...v0.51.0
[0.50.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.10.3...v0.50.0
[0.10.3]: https://github.com/giantswarm/cluster-vsphere/compare/v0.10.2...v0.10.3
[0.10.2]: https://github.com/giantswarm/cluster-vsphere/compare/v0.10.1...v0.10.2
[0.10.1]: https://github.com/giantswarm/cluster-vsphere/compare/v0.10.0...v0.10.1
[0.10.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.9.9...v0.10.0
[0.9.9]: https://github.com/giantswarm/cluster-vsphere/compare/v0.9.8...v0.9.9
[0.9.8]: https://github.com/giantswarm/cluster-vsphere/compare/v0.9.7...v0.9.8
[0.9.7]: https://github.com/giantswarm/cluster-vsphere/compare/v0.9.6...v0.9.7
[0.9.6]: https://github.com/giantswarm/cluster-vsphere/compare/v0.9.5...v0.9.6
[0.9.5]: https://github.com/giantswarm/cluster-vsphere/compare/v0.9.4...v0.9.5
[0.9.4]: https://github.com/giantswarm/cluster-vsphere/compare/v0.9.3...v0.9.4
[0.9.3]: https://github.com/giantswarm/cluster-vsphere/compare/v0.9.2...v0.9.3
[0.9.2]: https://github.com/giantswarm/cluster-vsphere/compare/v0.9.1...v0.9.2
[0.9.1]: https://github.com/giantswarm/cluster-vsphere/compare/v0.9.0...v0.9.1
[0.9.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.7.1...v0.8.0
[0.7.1]: https://github.com/giantswarm/cluster-vsphere/compare/v0.7.0...v0.7.1
[0.7.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.6.2...v0.7.0
[0.6.2]: https://github.com/giantswarm/cluster-vsphere/compare/v0.6.1...v0.6.2
[0.6.1]: https://github.com/giantswarm/cluster-vsphere/compare/v0.6.0...v0.6.1
[0.6.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.5.1...v0.6.0
[0.5.1]: https://github.com/giantswarm/cluster-vsphere/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.3.1...v0.4.0
[0.3.1]: https://github.com/giantswarm/cluster-vsphere/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.2.1...v0.3.0
[0.2.1]: https://github.com/giantswarm/cluster-vsphere/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/giantswarm/cluster-vsphere/compare/v0.1.2...v0.2.0
[0.1.2]: https://github.com/giantswarm/cluster-vsphere/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/giantswarm/cluster-vsphere/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/giantswarm/cluster-vsphere/releases/tag/v0.1.0
