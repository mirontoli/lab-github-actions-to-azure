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

# Create environment: DEV

# Add environment secrets: 
# AZURE_CLIENT_ID, AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID
```
