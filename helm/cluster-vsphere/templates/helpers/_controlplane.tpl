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

{{- /* Modify $d.global.controlPlane.machineTemplate.template here */ -}}
{{- $templateValue := printf "%s-%s-%s-kube-%s-tooling-%s-gs" $osName $osReleaseChannel $osVersion $kubernetesVersion $osToolingVersion -}}
{{- $_ := set $d.global.controlPlane.machineTemplate "template" $templateValue -}}

datacenter: {{ $d.global.providerSpecific.vcenter.datacenter }}
datastore: {{ $d.global.providerSpecific.vcenter.datastore }}
server: {{ $d.global.providerSpecific.vcenter.server }}
thumbprint: {{ $d.global.providerSpecific.vcenter.thumbprint }}

{{ $d.global.controlPlane.machineTemplate | toYaml }}
{{- end -}}

{{/*
Hash function based on data provided
Expects two arguments (as a `dict`) E.g.
  {{ include "hash" (dict "data" . "salt" .Values.providerIntegration.hasSalt) }}
Where `data` is the data to hash and `global` is the top level scope.

NOTE: this function has been copied from the giantswarm/cluster chart
(see `cluster.data.hash``) to ensure that resource naming is identical.
*/}}
{{- define "machineTemplateSpec.hash" -}}
{{- $data := mustToJson .data | toString  }}
{{- $salt := "" }}
{{- if .salt }}{{ $salt = .salt}}{{end}}
{{- (printf "%s%s" $data $salt) | quote | sha1sum | trunc 8 }}
{{- end -}}
