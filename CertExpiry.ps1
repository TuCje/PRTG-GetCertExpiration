param (
  [string]$website,
  [string]$ExpWarning,
  [string]$ExpError
 )
#Transferring to variables
$CertAgeDaysY = $ExpWarning
$CertAgeDaysR = $ExpError
$url = $website

#Check if CertAgeDays Yellow has been set, else set default value
if ($CertAgeDaysY -like ""){
    $CertAgeDaysY = 30
}
#Check if CertAgeDays Red has been set, else set default value
if ($CertAgeDaysY -like ""){
    $CertAgeDaysR = 7
}

# If url is empty, give error
if ($url -eq ""){

    Write-Host "3:Error - Invalid url"
    Exit 0
}
#Get the data
$req = [Net.HttpWebRequest]::Create($url)
$req.AllowAutoRedirect = $false
$req.GetResponse()
[datetime]$expiration = [System.DateTime]::Parse($req.ServicePoint.Certificate.GetExpirationDateString())
[int]$certExpiresIn = ($expiration - $(get-date)).Days

#If the url is incorrect the return is a date with a minus number
if ($certExpiresIn -contains "-"){

    Write-Host "3:Error - Somethings wrong with expiry date : $certExpiresIn "
    Exit 0
}

#Output for prtg
if ($certExpiresIn -le $CertAgeDaysR){

    Write-Host "3:Error - Certificate expires in $certExpiresIn days "
    Exit 0
}

if ($certExpiresIn -le $CertAgeDaysY){

    Write-Host "2:Warning - Certificate $website expires in $certExpiresIn days | Warn: $CertAgeDaysY Err: $CertAgeDaysR "
    Exit 0
}else{

 Write-Host "0:Ok - Certificate $website expires in $certExpiresIn days | Warn: $CertAgeDaysY Err: $CertAgeDaysR"
    Exit 0
}