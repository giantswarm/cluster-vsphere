{{- define "worker-vspheremachinetemplate-spec" -}}
datacenter: {{ $.Values.global.providerSpecific.vcenter.datacenter }}
datastore: {{ $.Values.global.providerSpecific.vcenter.datastore }}
server: {{ $.Values.global.providerSpecific.vcenter.server }}
thumbprint: {{ $.Values.global.providerSpecific.vcenter.thumbprint }}

{{- $pool := $.nodePool.config | deepCopy -}}
{{- $pool = unset $pool "replicas" -}}
{{- $pool = unset $pool "machineHealthCheck" -}}

{{- $osName := include "cluster.os.name" $ }}
{{- $osReleaseChannel := include "cluster.os.releaseChannel" $ }}
{{- $osVersion := include "cluster.os.version" $ }}
{{- $kubernetesVersion := include "cluster.component.kubernetes.version" $ }}
{{- $osToolingVersion := include "cluster.os.tooling.version" $ }}

{{- /* Modify $pool.template here */ -}}
{{- $templateValue := printf "%s-%s-%s-kube-%s-tooling-%s-gs" $osName $osReleaseChannel $osVersion $kubernetesVersion $osToolingVersion -}}
{{- $_ := set $pool "template" $templateValue -}}

{{- if $pool }}
{{ $pool | toYaml }}
{{- end }}

{{- end -}}
