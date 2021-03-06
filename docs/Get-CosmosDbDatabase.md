---
external help file: CosmosDB-help.xml
Module Name: CosmosDB
online version:
schema: 2.0.0
---

# Get-CosmosDbDatabase

## SYNOPSIS

Return the databases in a Cosmos DB account.

## SYNTAX

### Context (Default)

```powershell
Get-CosmosDbDatabase -Context <Context> [-Key <SecureString>] [-KeyType <String>] [-Id <String>]
 [<CommonParameters>]
```

### Account

```powershell
Get-CosmosDbDatabase -Account <String> [-Key <SecureString>] [-KeyType <String>] [-Id <String>]
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet will return the databases in a Cosmos DB account.
If the Id is specified then only the database matching this
Id will be returned, otherwise all databases will be returned.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-CosmosDbDatabase -Context $cosmosDbContext
```

Get a list of databases in the CosmosDB account.

### Example 2

```powershell
PS C:\> Get-CosmosDbDatabase -Context $cosmosDbContext -Id 'MyDatabase'
```

Get the database 'MyDatabase' from the CosmosDB account.

## PARAMETERS

### -Account

The account name of the Cosmos DB to access.

```yaml
Type: String
Parameter Sets: Account
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Context

This is an object containing the context information of the Cosmos DB database
that will be deleted. It should be created by \`New-CosmosDbContext\`.

If the context contains a database it will be ignored.

```yaml
Type: Context
Parameter Sets: Context
Aliases: Connection

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

This is the Id of the database to get.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Key

The key to be used to access this Cosmos DB.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeyType

The type of key that will be used to access ths Cosmos DB.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: master, resource

Required: False
Position: Named
Default value: Master
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
