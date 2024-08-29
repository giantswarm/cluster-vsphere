{{- define "additional-annotations" -}}
{{- $tags := .Values.global.providerSpecific.additionalVsphereClusterAnnotations | default dict }}
annotations:
  {{- if $tags }}
  {{- toYaml $tags | nindent 2 }}
  {{- end -}}
{{- end -}}
