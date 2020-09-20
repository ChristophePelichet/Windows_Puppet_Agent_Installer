<#

██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗███████╗    ██████╗ ██╗   ██╗██████╗ ██████╗ ███████╗████████╗     █████╗  ██████╗ ███████╗███╗   ██╗████████╗
██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║██╔════╝    ██╔══██╗██║   ██║██╔══██╗██╔══██╗██╔════╝╚══██╔══╝    ██╔══██╗██╔════╝ ██╔════╝████╗  ██║╚══██╔══╝
██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██║ █╗ ██║███████╗    ██████╔╝██║   ██║██████╔╝██████╔╝█████╗     ██║       ███████║██║  ███╗█████╗  ██╔██╗ ██║   ██║   
██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║███╗██║╚════██║    ██╔═══╝ ██║   ██║██╔═══╝ ██╔═══╝ ██╔══╝     ██║       ██╔══██║██║   ██║██╔══╝  ██║╚██╗██║   ██║   
╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝███████║    ██║     ╚██████╔╝██║     ██║     ███████╗   ██║       ██║  ██║╚██████╔╝███████╗██║ ╚████║   ██║   
 ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚══════╝    ╚═╝      ╚═════╝ ╚═╝     ╚═╝     ╚══════╝   ╚═╝       ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝   ╚═╝   
PowerShell Installer V1.0                                                                                                                                                                


.SYNOPSIS

Windows_Puppet_Agent_Installer.ps1 - Simple PowerShell script for installing Puppet Agent

.DESCRIPTION

Simple PowerShell script for installing Puppet Agent by GPO or any other distribution system. 
The script downloads the installation file and the .msi source to your Puppet Master server and launche the install.ps1 provided by Puppet.

.OUTPUTS
You can see the .msi installer log here : C:\Users\XXX\AppData\Local\Temp\*-puppet-install.log

.LINK
https://puppet.com/docs/pe/2019.8/installing_agents.html#installing_windows_agents


.NOTES
Written by: Christophe Pelichet (c.pelichet@gmail.com)
 
Find me on: 
 
* LinkedIn:     https://linkedin.com/in/christophepelichet
* Github:       https://github.com/ChristophePelichet
 
Change Log 
V1.00 - 09/20/2020 - Initial version 

#>

########################################################
######################## Path ##########################
########################################################

$MyScriptPath    = split-path -parent $MyInvocation.MyCommand.Definition


########################################################
###################### Functions #######################
########################################################

## No Functions 


#######################################################
###################### Variables ######################
#######################################################

## Set Download URL
$url = "https://cldpupma01.ixioncloud.local:8140/packages/current/install.ps1"

## Set Download Directory
$output = "$MyScriptPath\install.ps1"

## Set the security protocol.    (https://docs.microsoft.com/en-us/dotnet/api/system.net.servicepointmanager.securityprotocol?view=netcore-3.1)
[System.Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

## Set the callback to validate a server certificate.   (https://docs.microsoft.com/en-us/dotnet/api/system.net.servicepointmanager.servercertificatevalidationcallback?view=netcore-3.1)
[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true} 

## Set .NET WebClient class for downloading.   (https://docs.microsoft.com/en-us/dotnet/api/system.net.webclient?redirectedfrom=MSDN&view=netcore-3.1)
$webClient = New-Object System.Net.WebClient


#######################################################
######################## Code #########################
#######################################################

## Download PowerShell install from Puppet Master Server.
$webClient.DownloadFile($url, $output)


## Running Powershell install script.
& "$MyScriptPath\install.ps1"