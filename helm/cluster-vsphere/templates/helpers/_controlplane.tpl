{{/*
Generates template spec for control plane machines.
*/}}
{{- define "controlplane-vspheremachinetemplate-spec" -}}
{{- $d := (deepCopy $.Values) }}
datacenter: {{ $d.global.providerSpecific.vcenter.datacenter }}
datastore: {{ $d.global.providerSpecific.vcenter.datastore }}
server: {{ $d.global.providerSpecific.vcenter.server }}
thumbprint: {{ $d.global.providerSpecific.vcenter.thumbprint }}
{{ unset $d.global.controlPlane.machineTemplate "replicas" | toYaml }}
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