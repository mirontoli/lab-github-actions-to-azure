# lab-github-actions-to-azure
Some labs to learn Github Actions towards Azure.

# Lab 1 Connection

```bash
brew install azure-cli
az login --use-device-code

az ad sp create-for-rbac --name "github-actions-lab" --skip-assignment


appId=d147297c-94be-4ac8-bad7-da4a87cd1771

appObjectId=$(az ad app show --id $appId --query id -o tsv)
subscriptionId=$(az account show --query "id" -o tsv)

az rest --method POST --uri "https://graph.microsoft.com/v1.0/applications/$appObjectId/federatedIdentityCredentials" --headers "Content-Type=application/json" --body '{ "name": "github-environment-DEV", "issuer": "https://token.actions.githubusercontent.com", "subject": "repo:mirontoli/lab-github-actions-to-azure:environment:DEV", "description": "Allow GitHub Actions on main to request tokens", "audiences": ["api://AzureADTokenExchange"] }'

az rest --method GET \
  --uri "https://graph.microsoft.com/v1.0/applications/$appObjectId/federatedIdentityCredentials" \
  | jq

az role assignment create --assignee $appId --role "Contributor" --scope /subscriptions/$subscriptionId

az role assignment create --assignee $appId --role "User Access Administrator" --scope /subscriptions/$subscriptionId

az role assignment list --assignee $appId --scope /subscriptions/$subscriptionId --query "[].roleDefinitionName" -o tsv

az role assignment delete --assignee $appId --role "User Access Administrator" --scope /subscriptions/$subscriptionId

# Lowering the permissions
az role assignment create --assignee $appId --role "Role Based Access Control Administrator" --scope /subscriptions/$subscriptionId

# Create environment: DEV

# Add environment secrets: 
# AZURE_CLIENT_ID, AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID


```

cleanup

```bash
az stack sub list --query "[].name" -o tsv
az stack sub delete --name stack-role-assignment --action-on-unmanage deleteAll --yes
az group list --query "[].name" -o tsv
az group delete --name rg-iac-demo-003 --yes
az group delete --name rg-iac-demo-002 --yes
az group delete --name rg-iac-demo --yes
```
