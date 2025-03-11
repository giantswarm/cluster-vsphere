{{/*
Generates template spec for control plane machines.
*/}}
{{- define "controlplane-vspheremachinetemplate-spec" -}}
{{- $d := $.Values | deepCopy -}}
{{- $_ := unset $d.global.controlPlane.machineTemplate "replicas" -}}

{{- $osName := include "cluster.os.name" $ }}
{{- $osReleaseChannel := include "cluster.os.releaseChannel" $ }}
{{- $osVersion := include "cluster.os.version" $ }}
{{- $kubernetesVersion := include "cluster.component.kubernetes.version" $ }}
{{- $osToolingVersion := include "cluster.os.tooling.version" $ }}
{{- $templateSuffix := $.Values.global.providerSpecific.templateSuffix }}

{{- /* Modify $d.global.controlPlane.machineTemplate.template here */ -}}
{{- $templateValue := printf "%s-%s-%s-kube-%s-tooling-%s-gs-%s" $osName $osReleaseChannel $osVersion $kubernetesVersion $osToolingVersion $templateSuffix | trimSuffix "-" -}}
{{- $_ := set $d.global.controlPlane.machineTemplate "template" $templateValue -}}

datacenter: {{ $d.global.providerSpecific.vcenter.datacenter }}
datastore: {{ $d.global.providerSpecific.vcenter.datastore }}
server: {{ $d.global.providerSpecific.vcenter.server }}
thumbprint: {{ $d.global.providerSpecific.vcenter.thumbprint }}

{{ $d.global.controlPlane.machineTemplate | toYaml }}
{{- end -}}
