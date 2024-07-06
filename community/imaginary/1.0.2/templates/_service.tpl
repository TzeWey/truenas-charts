{{- define "imaginary.service" -}}
service:
  imaginary:
    enabled: true
    primary: true
    type: NodePort
    targetSelector: imaginary
    ports:
      server:
        enabled: true
        primary: true
        port: {{ .Values.imaginaryNetwork.serverPort }}
        nodePort: {{ .Values.imaginaryNetwork.serverPort }}
        protocol: http
        targetSelector: imaginary
{{- end -}}
