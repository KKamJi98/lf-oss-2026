{{- define "lf-oss-na-2026.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "lf-oss-na-2026.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "lf-oss-na-2026.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "lf-oss-na-2026.labels" -}}
helm.sh/chart: {{ include "lf-oss-na-2026.chart" . }}
{{ include "lf-oss-na-2026.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "lf-oss-na-2026.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lf-oss-na-2026.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
