{{- define "worker-vspheremachinetemplate-spec" -}}
datacenter: {{ $.Values.global.providerSpecific.vcenter.datacenter }}
datastore: {{ $.Values.global.providerSpecific.vcenter.datastore }}
server: {{ $.Values.global.providerSpecific.vcenter.server }}
thumbprint: {{ $.Values.global.providerSpecific.vcenter.thumbprint }}

{{- $pool := $.nodePool.config | deepCopy -}}
{{- $pool = unset $pool "replicas" -}}
{{- $pool = unset $pool "machineHealthCheck" -}}

{{- if $pool }}
{{ $pool | toYaml }}
{{- end }}

{{- end -}}
