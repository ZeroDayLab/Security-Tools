PowerShell script to automate building Invoke-Mimikatz scripts with custom mimikatz binaries.

### Files

 * MimiPrepare.ps1 - Script containing functions to build Invoke-Mimikatz
 * Invoke-Mimikatz-Template.ps1 - Invoke-Mimikatz template edited slightly to support binary file compression
 * Invoke-Mimikatz64-Template.ps1 - Invoke-Mimikatz template with (_most_) code related to 32bit removed, because 64bit is much more common these days

### Usage

  *You might need to bypass AMSI before importing the script*

  To build a 64bit only Invoke-Mimikatz script:
  ```
Import-Module /path/to/module/MimiPrepare.ps1
New-Mimiikatz64Script -MimiBin /path/to/64bit/mimikatz.exe -OutFile Invoke-CustomMimikatz64.ps1
  ```

  To build an Invoke-Mimikatz script containing both 32 and 64 bits:
  ```
Import-Module /path/to/module/MimiPrepare.ps1
New-MimiikatzScript -MimiBin64 /path/to/64bit/mimikatz.exe -MimiBin32 /path/to/32bit/mimikatz.exe -OutFile Invoke-Custo
mMimikatz.ps1
  ```

### Todo

  * 32bit only support (_maybe_)
