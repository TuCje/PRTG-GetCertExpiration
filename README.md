# PRTG-GetCertExpiration
Check the expiration of certificates in PRTG (without creating a device for every certificate)

**Will be updated**
- Create an exe/xml sensor
- Select the CertExpiry.ps1
- Parameters:
  -website {https://websitename.nl} 
  -ExpWarning is not required, default is 30 days before warning
  -ExpError is not required, default is 7 days before error
 - Go to overview tab -> click on the gear icon of “value” 
 - Click on “enable alerting based on limits” on Lookups and limits and fill in "2" on upper error limit and "1" on upper warning limit
