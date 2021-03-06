<#
.EXTERNALHELP CosmosDB-help.xml
#>
#Requires -Version 5.1
#Requires -Modules @{ ModuleName = 'Az.Accounts'; ModuleVersion = '1.0.0'; Guid = '17a2feff-488b-47f9-8729-e2cec094624c' }
#Requires -Modules @{ ModuleName = 'Az.Resources'; ModuleVersion = '1.0.0'; Guid = '48bb344d-4c24-441e-8ea0-589947784700' }

$moduleRoot = Split-Path `
    -Path $MyInvocation.MyCommand.Path `
    -Parent

# Import dependent Az modules
Import-Module -Name Az.Accounts -MinimumVersion 1.0.0 -Scope Global
Import-Module -Name Az.Resources -MinimumVersion 1.0.0 -Scope Global

#region LocalizedData
$culture = 'en-us'

if (Test-Path -Path (Join-Path -Path $moduleRoot -ChildPath $PSUICulture))
{
    $culture = $PSUICulture
}

Import-LocalizedData `
    -BindingVariable LocalizedData `
    -Filename 'CosmosDB.strings.psd1' `
    -BaseDirectory $moduleRoot `
    -UICulture $culture
#endregion

#region Types
if (-not ([System.Management.Automation.PSTypeName]'CosmosDB.Context').Type)
{
    <#
        Attempt to load the classes from within the CosmosDB.dll in the
        same folder as the module. If the file doesn't exist then load
        them from the CosmosDB.cs file.

        Loading the classes from the CosmosDB.cs file requires compilation
        which currently fails in PowerShell on Azure Functions 2.0.

        See https://github.com/Azure/azure-functions-powershell-worker/issues/220
    #>
    $classDllPath = Join-Path -Path $moduleRoot -ChildPath 'CosmosDB.dll'

    if (Test-Path -Path $classDllPath)
    {
        Write-Verbose -Message $($LocalizedData.LoadingTypesFromDll -f $classDllPath)
        Add-Type -Path $classDllPath
    }
    else
    {
        $typeDefinitionPath = Join-Path -Path $moduleRoot -ChildPath 'classes\CosmosDB\CosmosDB.cs'
        Write-Verbose -Message $($LocalizedData.LoadingTypesFromCS -f $typeDefinitionPath)
        $typeDefinition = Get-Content -Path $typeDefinitionPath -Raw
        Add-Type -TypeDefinition $typeDefinition
    }
}

<#
    This type is available in PowerShell Core, but it is not available in
    Windows PowerShell. It is needed to check the exception type within the
    Invoke-CosmosDbRequest function.
#>
if (-not ([System.Management.Automation.PSTypeName]'Microsoft.PowerShell.Commands.HttpResponseException').Type)
{
    $httpResponseExceptionClassDefinition = @'
namespace Microsoft.PowerShell.Commands
{
    public class HttpResponseException : System.Net.WebException
    {
        public System.Int32 dummy;
    }
}
'@

    Add-Type -TypeDefinition $httpResponseExceptionClassDefinition
}
#endregion

#region ImportFunctions
# Dot source any functions in the libs folder
$libFiles = Get-ChildItem `
    -Path (Join-Path -Path $moduleRoot -ChildPath 'lib') `
    -Include '*.ps1' `
    -Recurse

Foreach ($libFile in $libFiles)
{
    Write-Verbose -Message $($LocalizedData.ImportingLibFileMessage -f $libFile.Fullname)
    . $libFile.Fullname
}
#endregion

# Add Aliases
New-Alias -Name 'New-CosmosDbConnection' -Value 'New-CosmosDbContext' -Force
