{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "nacos.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nacos.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nacos.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper Nacos image name
*/}}
{{- define "nacos.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper Nacos initDB image name
*/}}
{{- define "nacos.initDBImage" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.initDB.image "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper Nacos Metrics image name
*/}}
{{- define "nacos.metrics.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.metrics.image "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "nacos.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.initDB.image .Values.metrics.image) "global" .Values.global) -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "nacos.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified mysql name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "nacos.mysql.fullname" -}}
{{- $name := default "mysql" .Values.mysql.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "nacos.mysql.master.service.fullname" -}}
{{- printf "%s-%s" .Release.Name "mysql" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "nacos.mysql.slave.service.fullname" -}}
{{- printf "%s-%s" .Release.Name "mysql-slave" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Compile all warnings into a single message, and call fail.
*/}}
{{- define "nacos.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "nacos.validateValues.dags.repositories" .) -}}
{{- $messages := append $messages (include "nacos.validateValues.dags.repository_details" .) -}}
{{- $messages := append $messages (include "nacos.validateValues.plugins.repositories" .) -}}
{{- $messages := append $messages (include "nacos.validateValues.plugins.repository_details" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{{/* Check if there are rolling tags in the images */}}
{{- define "nacos.checkRollingTags" -}}
{{- include "common.warnings.rollingTag" .Values.web.image }}
{{- include "common.warnings.rollingTag" .Values.scheduler.image }}
{{- include "common.warnings.rollingTag" .Values.worker.image }}
{{- include "common.warnings.rollingTag" .Values.git.image }}
{{- include "common.warnings.rollingTag" .Values.metrics.image }}
{{- end -}}
