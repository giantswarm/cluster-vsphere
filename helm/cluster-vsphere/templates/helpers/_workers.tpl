{{/*
Generates template spec for worker machines.
*/}}
{{- define "worker-vspheremachinetemplate-spec" -}}
{{- $d := (deepCopy $.Values) }}
datacenter: {{ $d.global.providerSpecific.vcenter.datacenter }}
datastore: {{ $d.global.providerSpecific.vcenter.datastore }}
server: {{ $d.global.providerSpecific.vcenter.server }}
thumbprint: {{ $d.global.providerSpecific.vcenter.thumbprint }}
{{ unset $d.global.nodePools "replicas" | toYaml }}
{{- end -}}
