$TopDir = $env:USERPROFILE

$SourceDir = 'AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets'
$FullSourceDir = Join-Path -Path $TopDir -ChildPath $SourceDir

$DestDir = 'Pictures\Spotlight'
$FullDestDir = Join-Path -Path $TopDir -ChildPath $DestDir

If ( -Not (Test-Path -LiteralPath $FullDestDir))
{
	New-Item -ItemType Directory -Force -Path $FullDestDir
}

add-type -AssemblyName System.Drawing
$MinSize = 300KB

$SpotFiles = Get-ChildItem -LiteralPath $FullSourceDir | Where-Object {$_.Length -ge $MinSize}

foreach ($SF_Item in $SpotFiles)
{
	$png = New-Object System.Drawing.Bitmap $SF_Item.FullName
	If ($png.Width -gt $png.Height)
	{
		$TimeStamp = $SF_Item.CreationTime.ToString('yyyy-MM-dd_HH-mm-ss')
		$NewFileName = '{0}_-_{1}.jpg' -f $TimeStamp, $SF_Item.Name.SubString(0, 8)
		$FullNewFileName = Join-Path -Path $FullDestDir -ChildPath $NewFileName

		Copy-Item -LiteralPath $SF_Item.FullName -Destination $FullNewFileName
	}
}