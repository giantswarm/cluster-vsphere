{{- define "worker-vspheremachinetemplate-spec" -}}
{{- $pool := $.nodePool.config | deepCopy -}}
{{- $pool = unset $pool "replicas" -}}
{{- $pool = unset $pool "machineHealthCheck" -}}

{{- $osName := include "cluster.os.name" $ }}
{{- $osReleaseChannel := include "cluster.os.releaseChannel" $ }}
{{- $osVersion := include "cluster.os.version" $ }}
{{- $kubernetesVersion := include "cluster.component.kubernetes.version" $ }}
{{- $osToolingVersion := include "cluster.os.tooling.version" $ }}
{{- $templateSuffix := $.Values.global.providerSpecific.templateSuffix }}

{{- /* Modify $pool.template here */ -}}
{{- $templateValue := printf "%s-%s-%s-kube-%s-tooling-%s-gs-%s" $osName $osReleaseChannel $osVersion $kubernetesVersion $osToolingVersion $templateSuffix | trimSuffix "-" -}}
{{- $_ := set $pool "template" $templateValue -}}

datacenter: {{ $.Values.global.providerSpecific.vcenter.datacenter }}
datastore: {{ $.Values.global.providerSpecific.vcenter.datastore }}
server: {{ $.Values.global.providerSpecific.vcenter.server }}
thumbprint: {{ $.Values.global.providerSpecific.vcenter.thumbprint }}

{{ $pool | toYaml }}
{{- end -}}
