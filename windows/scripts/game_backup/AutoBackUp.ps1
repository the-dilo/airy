# Saves files periodically, comparing hash MD5 with last autosave
##############################################################################

param(
    [string]$source,
    [string]$backup,
    [int]$deltaTime=5,
    [int]$CNTryings=3
    )

$NTryings=1
$bRunJob=$true

filter FGet-FileList([string]$property="FullName")
{
    If(-not $_ -or -not (Test-Path $_)) { Write-Host "FGet-FileList: No item"; return }
    Elseif (Test-Path $_ -Type Container) 
    {
        @(Get-ChildItem $_ -Recurse |
            Where { -not $_.PsIsContainer } | Foreach-Object { $_.$property })
    }
    Else { @((Get-Item $_).$property) }
}

function FGet-FileHashMD5
{
    begin { $hasher = [System.Security.Cryptography.MD5]::Create() }
    process
    {
        $filename = (Resolve-Path $_ -ErrorAction SilentlyContinue).Path
        if(-not $filename -or -not (Test-Path $filename -Type Leaf))
        {
            continue
        }
        $inputStream = New-Object IO.StreamReader $filename
        $hashBytes = $hasher.ComputeHash($inputStream.BaseStream)
        $inputStream.Close()
        
        $builder = New-Object System.Text.StringBuilder
        $hashBytes | Foreach-Object { [void] $builder.Append($_.ToString("X2")) }
        $builder.ToString()
    }
}

function FGet-LastSaves([string]$dirpath, [string]$head)
{
    If($dirpath -and (Test-Path $dirpath -Type Container))
    {
        Get-ChildItem $dirpath | Where { $_.PsIsContainer -and ($_.Name -match ("^"+$head+"_"))} |
             Sort-Object LastWriteTime -descending | Foreach-Object { $_.FullName }
    }
}

function FCopy-Autosave([string]$srcpath, [string]$backupdir, [int]$Nattempt)
{
    $srclist =  $srcpath | FGet-FileList
    $bcplist = @(FGet-LastSaves $backupdir (Split-Path $srcpath -leaf))[0] | FGet-FileList

    If(-not $srclist)
    {
        Write-Host "This job will be stopped after '$Nattempt / $CNTryings' attempts, 'cause src is absent"
        $Nattempt+1
    }
    Elseif(-not $bcplist `
            -or @(Compare-Object ($srclist | FGet-FileList Name) ($bcplist | FGet-FileList Name)) `
            -or @(Compare-Object ($srclist | FGet-FileHashMD5) ($bcplist | FGet-FileHashMD5)))
    {
        $newname=(Split-Path $srcpath -leaf) + (Get-Date -uformat "_%Y-%m-%d_%H'%M'%S")
        $dstpath=Join-Path $backupdir $newname
        If($deltaTime -eq 0 -or ($srcpath | Get-ChildItem | Measure-Object -Sum Length).Sum -le ((10000000000/3600)*$deltaTime)) 
        {
            $NTryings=1
            Copy-Item $srcpath $dstpath -Recurse
            Write-Host "'$srcpath' copied into '$dstpath'"
            $Nattempt
        }
        Else {
            Write-Host "This job will be stopped after '$Nattempt / $CNTryings' attempts, 'cause src TOO BIG"
            $Nattempt+1
        }
        
    }
}

if($deltaTime -le 0) { FCopy-Autosave $source $backup $NTryings }
Else { while($bRunJob) { 
    $bRunJob=($NTryings=(FCopy-Autosave $source $backup $NTryings)) -le $CNTryings
    Start-Sleep $deltaTime }
}