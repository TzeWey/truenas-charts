{{- define "imaginary.workload" -}}
workload:
  imaginary:
    enabled: true
    primary: true
    type: Deployment
    podSpec:
      hostNetwork: {{ .Values.imaginaryNetwork.hostNetwork }}
      securityContext:
        fsGroup: {{ .Values.imaginaryID.group }}
      containers:
        imaginary:
          enabled: true
          primary: true
          imageSelector: image
          securityContext:
            runAsUser: {{ .Values.imaginaryID.user }}
            runAsGroup: {{ .Values.imaginaryID.group }}
            capabilities:
              add:
                - SYS_NICE
          env:
            PORT: {{ .Values.imaginaryNetwork.serverPort }}
            CONFIG_PATH: /config
            METADATA_PATH: /metadata
          {{ with .Values.imaginaryConfig.additionalEnvs }}
          envList:
            {{ range $env := . }}
            - name: {{ $env.name }}
              value: {{ $env.value }}
            {{ end }}
          {{ end }}
          probes:
            liveness:
              enabled: true
              type: http
              port: "{{ .Values.imaginaryNetwork.serverPort }}"
              path: /health
            readiness:
              enabled: true
              type: http
              port: "{{ .Values.imaginaryNetwork.serverPort }}"
              path: /health
            startup:
              enabled: true
              type: http
              port: "{{ .Values.imaginaryNetwork.serverPort }}"
              path: /health
{{- end -}}