
{{- define "kubevip" -}}
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  name: kube-vip
  namespace: kube-system
spec:
  containers:
  - args:
    - start
    env:
    - name: vip_arp
      value: "true"
    - name: vip_leaderelection
      value: "true"
    - name: vip_address
      value: {{ .Values.connectivity.network.controlPlaneEndpoint.host }}
    - name: vip_interface
      value: eth0
    - name: vip_leaseduration
      value: "15"
    - name: vip_renewdeadline
      value: "10"
    - name: vip_retryperiod
      value: "2"
    image: ghcr.io/kube-vip/kube-vip:v0.3.5
    imagePullPolicy: IfNotPresent
    name: kube-vip
    resources: {}
    securityContext:
      capabilities:
        add:
        - NET_ADMIN
        - SYS_TIME
    volumeMounts:
    - mountPath: /etc/kubernetes/admin.conf
      name: kubeconfig
  hostNetwork: true
  volumes:
  - hostPath:
      path: /etc/kubernetes/admin.conf
      type: FileOrCreate
    name: kubeconfig
status: {}
{{- end -}}