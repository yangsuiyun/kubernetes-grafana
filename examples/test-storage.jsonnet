local grafana = import 'grafana/grafana.libsonnet';

{
  _config:: {
    namespace: 'monitoring-grafana',
    storage: {
          name: 'v1',
          kind: 'PersistentVolumeClaim',
          metadata: {
            name: 'grafana-storage',
          },
          spec:
          {
            accessModes: [
              'ReadWriteOnce',
            ],
            volumeMode: 'Filesystem',
            resources: {
              requests: {
                storage: '8Gi',
              },
            },
          },
        },
  },

  grafana: grafana($._config) + {
    service+: {
      spec+: {
        ports: [
          port {
            nodePort: 30910,
          }
          for port in super.ports
        ],
      },
    },
  },
}
