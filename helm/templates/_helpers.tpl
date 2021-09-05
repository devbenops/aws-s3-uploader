
{{/*
Expand the name of the chart.
*/}}
{{- define "appName" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Common labels
*/}}
{{- define "app.labels" -}}
{{- if .Values.deployment -}}
{{- range $key, $val := .Values.deployment.labels }}
{{ $key }}: {{ $val }}
{{- end }}
release: {{ .Release.Name }}
{{- else -}}
{{- range $key, $val := .Values.cronjob.labels }}
{{ $key }}: {{ $val }}
{{- end }}
release: {{ .Release.Name }}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for deployment/cronjob
*/}}
{{- define "app.apiVersion" -}}
{{- if .Values.deployment -}}
{{- print "apps/v1" -}}
{{- else -}}
{{- print "batch/v1beta1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate kind for deployment/cronjob
*/}}
{{- define "app.kind" -}}
{{- if .Values.deployment -}}
{{- print "Deployment" -}}
{{- else -}}
{{- print "CronJob" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for ingress
*/}}
{{- define "ingress.api" -}}
{{- print "networking.k8s.io/v1" -}}
{{- end -}}
