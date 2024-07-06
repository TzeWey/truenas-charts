{{- define "imaginary.persistence" -}}
persistence:
  {{- range $idx, $storage := .Values.imaginaryStorage.additionalStorages }}
  {{ printf "imaginary-%v:" (int $idx) }}
    enabled: true
    {{- include "ix.v1.common.app.storageOptions" (dict "storage" $storage) | nindent 4 }}
    targetSelector:
      imaginary:
        imaginary:
          mountPath: {{ $storage.mountPath }}
  {{- end }}
{{- end -}}