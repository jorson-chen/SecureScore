function Set-AdminMFA {
    [Parameter(Mandatory = $true)]$tenant
    if (!$script:confirmed) {
        Write-Warning "This will enable multi-factor authentication for all admin users, and prompt them at first logon to configure MFA. Do you want to continue?" -WarningAction Inquire  
    } 

    $mf = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
    $mf.RelyingParty = "*"
    $mfa = @($mf)
    $admins = Get-MsolRoleMember -TenantId $tenant.tenantid -RoleObjectId (Get-MsolRole -RoleName "CompanyAdministrator").ObjectId | Set-MsolUser -StrongAuthenticationRequirements $mfa   
}