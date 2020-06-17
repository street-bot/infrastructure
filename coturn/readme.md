# COTURN on Kubernetes

## Layout
### STUN/TURN server
The TURN server is configured to use a CertManager managed certificate `coturn`. 
The certificate secret `coturn-tls-secret` is mounted on the coturn pod at `/app/tls` via a secret VolumeMount. 
The TURN server runs on `tcp:3478` (insecure) and `tcp:5349` (secure) with UDP access disabled. 

TURN URI: `turn:streetbot-coturn.frankgu.me`  

You will need to create a user in the WebAdmin terminal to access the TURN service. User credentials are not persistent across pod restarts!


### WebAdmin
CoTURN has a WebAdmin page that can be used for on-the-fly configuration of certain STUN/TURN server options. 
This page is currently exposed on https://streetbot-coturn-web.frankgu.me with an Ingress.
To access the WebAdmin page, an Admin User must first be created (since the image does not contain any user database information). 
You can `kubectl exec` into the `coturn-xxxx-xxx` pod in the `coturn` namespace, and run: 
```bash
turnadmin -A -u <username> -p <password>
```
Then you can use these credentials to gain access to the WebAdmin page. The credentials will be wiped whenever the pod is restarted!  

## Considerations
1. The Coturn server needs both TCP and UDP services to be exposed via the `nginx-ingress-controller` config (tcpServices, udpServices)
2. If the ingress controller cannot handle these ports, then a NodePort should be used. The pod shall be bound to a specific Node with a StaticIP.