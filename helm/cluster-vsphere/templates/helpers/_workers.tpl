{{- define "worker-vspheremachinetemplate-spec" -}}
datacenter: {{ $.Values.global.providerSpecific.vcenter.datacenter }}
datastore: {{ $.Values.global.providerSpecific.vcenter.datastore }}
server: {{ $.Values.global.providerSpecific.vcenter.server }}
thumbprint: {{ $.Values.global.providerSpecific.vcenter.thumbprint }}

{{- $pool := $.nodePool.config | deepCopy -}}   # Access the node pool configuration
{{- $pool = unset $pool "replicas" -}}          # Unset "replicas"
{{- $pool = unset $pool "machineHealthCheck" -}}   # Unset "machineHealthCheck"
{{ $pool | toYaml }}   # Render the modified pool configuration
{{- end -}}
