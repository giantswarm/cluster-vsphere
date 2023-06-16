{{/* vim: set filetype=mustache: */}}

{{- define "isIpamEnabled" -}}
{{- if and (and (not .Values.connectivity.network.controlPlaneEndpoint.host) (.Values.connectivity.network.controlPlaneEndpoint.ipPoolName)) (.Capabilities.APIVersions.Has "ipam.cluster.x-k8s.io/v1alpha1/IPAddressClaim") }}
{{- printf "true" -}}
{{ else }}
{{- printf "false" -}}
{{- end }}
{{- end }}
