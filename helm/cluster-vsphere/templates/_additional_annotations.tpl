{{- define "additional-annotations" -}}
{{- $tags := .Values.global.providerSpecific.additionalVsphereClusterAnnotations | default dict }}
annotations:
  azure-resource-tag.giantswarm-cluster: {{ include "resource.default.name" . }}
  {{- if $tags }}
  {{- toYaml $tags | nindent 2 }}
  {{- end -}}
{{- end -}}
