Connect-AzAccount
$vminventoryobj = @()
$subscriptions = Get-AzSubscription
foreach ($sub in $subscriptions)
    {
        Set-AzContext -Subscription $sub
            $vms = Get-AzVM -status
            foreach($vm in $vms)
                {
                    $vmInfo = [pscustomobject]@{

                    'VM Name' = $vm.Name
                    'Resource Group Name' = $vm.ResourceGroupName
                    'Subscription' = $vm.SubscriptionName
                    'Location' = $vm.Location
                    'Os Type' = $vm.OsType
                    'Power Staus' = $vm.PowerState
                    'Os Disk' = $vm.StorageProfile.OsDisk.Name
                    'VM Id' = $vm.Id
                    }
                $vminventoryobj += $vmInfo
                }
        }
$vminventoryobj | ConvertTo-Json
