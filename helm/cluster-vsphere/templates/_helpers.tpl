{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "infrastructureApiVersion" -}}
infrastructure.cluster.x-k8s.io/v1beta1
{{- end -}}

{{/*
VSphereMachineTemplate is immutable. We need to create new versions during upgrades.
Here we are generating a hash suffix to trigger upgrade when only it is necessary by
using only the parameters used in vspheredmachinetemplate.yaml.
*/}}
{{- define "mtSpec" -}}
datacenter: {{ $.global.providerSpecific.vcenter.datacenter }}
datastore: {{ $.global.providerSpecific.vcenter.datastore }}
server: {{ $.global.providerSpecific.vcenter.server }}
thumbprint: {{ $.global.providerSpecific.vcenter.thumbprint }}

{{- $pool := .currentPool | deepCopy -}}   # Make a deep copy to avoid mutating the original
{{- $pool = unset $pool "replicas" -}}     # Unset "replicas" in the copied version
{{- $pool = unset $pool "machineHealthCheck" -}}   # Unset "machineHealthCheck" in the copied version
{{ $pool | toYaml }}
{{- end -}}

{{/*
Takes an array of maps containing worker nodePools and adds each map to a new
map. Results in a map of node specs which can be iterated over to create
MachineDeployments.
*/}}
{{ define "createMapOfWorkerPoolSpecs" -}}
{{- $nodeMap := dict -}}
{{- range $index, $pool := .Values.global.nodePools | default .Values.cluster.providerIntegration.workers.defaultNodePools -}}
  {{- $_ := set $nodeMap $index $pool -}}
{{- end -}}
{{ toYaml $nodeMap }}
{{- end }}

{{/*
Common labels without kubernetes version
https://github.com/giantswarm/giantswarm/issues/22441
*/}}
{{- define "labels.selector" -}}
app: {{ include "name" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
cluster.x-k8s.io/cluster-name: {{ include "resource.default.name" . | quote }}
giantswarm.io/cluster: {{ include "resource.default.name" . | quote }}
giantswarm.io/organization: {{ .Values.global.metadata.organization | quote }}
application.giantswarm.io/team: {{ index .Chart.Annotations "application.giantswarm.io/team" | quote }}
{{- end -}}

{{/*
Common labels with kubernetes version
https://github.com/giantswarm/giantswarm/issues/22441
*/}}
{{- define "labels.common" -}}
{{- include "labels.selector" . }}
app.kubernetes.io/version: {{ $.Chart.Version | quote }}
helm.sh/chart: {{ include "chart" . | quote }}
{{- end -}}

{{/*
Create label to prevent accidental cluster deletion
*/}}
{{- define "preventDeletionLabel" -}}
{{- if $.Values.global.metadata.preventDeletion -}}
giantswarm.io/prevent-deletion: "true"
{{ end -}}
{{- end -}}

{{/*
Create a prefix for all resource names.
*/}}
{{- define "resource.default.name" -}}
{{ .Release.Name }}
{{- end -}}

{{- define "securityContext.runAsUser" -}}
1000
{{- end -}}
{{- define "securityContext.runAsGroup" -}}
1000
{{- end -}}

{{- define "credentialSecretName" -}}
{{- include "resource.default.name" $ }}-credentials
{{- end -}}
