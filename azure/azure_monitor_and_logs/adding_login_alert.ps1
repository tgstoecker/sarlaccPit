#link: https://learn.microsoft.com/en-us/azure/azure-monitor/logs/azure-cli-log-analytics-workspace-sample

#using azure ad
az group create -l germanywestcentral -n test_group -l germanywestcentral
az monitor log-analytics workspace create --resource-group test_group --workspace-name testWorkspace

az monitor log-analytics workspace table list --resource-group test_group --workspace-name testWorkspace --output table