<#
    .SYNOPSIS
    Helper function that asserts a Cosmos DB User Defined Function Id is valid.
#>
function Assert-CosmosDbUserDefinedFunctionIdValid
{

    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Id
    )

    $matches = [regex]::Match($Id,"[^\\/#?]{1,255}(?<!\s)")
    if ($matches.value -ne $Id)
    {
        Throw $($LocalizedData.UserDefinedFunctionIdInvalid -f $Id)
    }

    return $true
}
