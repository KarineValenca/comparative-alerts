Comparative Alerts


Purpose: 
Compare metrics of two versions of the same software with the purpose of validade wheter the newest version has some issue when compared with the 
last version. 
It could be usefull when using green-blue deployment strategy, as well canary deployment. 

Method:
Technnologies:
    - Prometheus
    - Grafana
    - Metric-Generator-Tabajara
    - AlertManager


sum by (device_app_version, status) (http_requests_app_total)

Error alerts -> ratio of 400 requests error in version 2.0 is 10% higher than in version 1.0
//sum by (device_app_version, status) (http_requests_app_total{status=~"4.."})
//sum by (device_app_version, status) (irate(http_requests_app_total{status=~"4.."}[1m]))
(irate(http_requests_app_total{status=~"4..", device_app_version="v0003"}[1m]))

http_requests_app_total{status=~"4..", device_app_version="v0003"}  /  ignoring(device_app_version) http_requests_app_total{status=~"4..", device_app_version="v0002"} 


Formula mais interessamte
rate(http_requests_app_total{status=~"4..", device_app_version="v0002"}[5m])  /  ignoring(device_app_version) rate(http_requests_app_total{status=~"4..", device_app_version="v0001"}[5m])

Mesmo resultado da anterior
( rate(http_requests_app_total{status=~"4..", device_app_version="v0002"}[5m]) -  ignoring(device_app_version) rate(http_requests_app_total{status=~"4..", device_app_version="v0001"}[5m]) )  /  ignoring(device_app_version) rate(http_requests_app_total{status=~"4..", device_app_version="v0001"}[5m])

Prometheus documentation recomends to use rate instead irate in alerts. Try to find out why:
    

rate is calculates by the difference in value over time setted, then
rate(x[35s]) = difference in value over 35 seconds  