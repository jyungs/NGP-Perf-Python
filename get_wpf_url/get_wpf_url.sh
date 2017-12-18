#!/bin/bash
rm /tmp/wpf_result/wpfurl.json
rm /tmp/wpf_result/wpfurl.csv

#replace %query_key% and %account% from New Relic Insights
 
curl -H "Accept: application/json" -H "X-Query-Key: %query_key%" "https://insights-api.newrelic.com/v1/accounts/%account%/query?nrql=SELECT%20count(pageUrl)%20FROM%20PageView%20FACET%20pageUrl%20where%20appName%20%3D%20%27Web%20Publishing%20Framework%20(WPF)%27%20since%207%20day%20ago%20limit%201000" > /tmp/wpf_result/wpfurl.json

    python /home/nfs/jyu/dev/json_to_csv.py facets /tmp/wpf_result/wpfurl.json /tmp/wpf_result/wpfurl.csv

file="/tmp/wpf_result/wpfurl.csv"
if [ -f "$file" ]
then
    /usr/bin/sendemail -t jay.yu@natgeo.com,Chris.Davis@natgeo.com,amelia.capilongo@natgeo.com -a /tmp/wpf_result/wpfurl.csv -f jay.yu@natgeo.com -m "Attached please find the top WPF application Urls from the last 7 days." -u "Top WPF Application Urls Last 7 Days"

## /usr/bin/sendemail -t jay.yu@natgeo.com -a /tmp/wpf_result/wpfurl.csv -f jay.yu@natgeo.com -m "Attached please find the top WPF application Urls." -u "Top WPF Application Urls"

fi


