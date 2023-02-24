$ConfigData = 
@{
	AllNodes = @(
		@{
			NodeName = 'EMEAZRHCARTAPP'
			PSDscAllowPlainTextPassword = $true
			PSDscAllowDomainUser = $true
		},
		@{
			NodeName = 'EMEAZRHCARTDB'
			PSDscAllowPlainTextPassword = $true
			PSDscAllowDomainUser = $true
		},
		@{
			NodeName = 'EMEAZRHCARTCAL1'
			PSDscAllowPlainTextPassword = $true
			PSDscAllowDomainUser = $true
		},
		@{
			NodeName = 'EMEAZRHCARTCAL2'
			PSDscAllowPlainTextPassword = $true
			PSDscAllowDomainUser = $true
		}
	);
}

Configuration PlatformInstaller
{
	Import-DscResource -ModuleName xPsDesiredStateConfiguration
	Import-DscResource -ModuleName FISDscResources
	Import-DscResource -ModuleName cFocus
	Import-DscResource -ModuleName PSDesiredStateConfiguration
	Import-DscResource -ModuleName NetworkingDsc
	Import-DscResource -ModuleName xWebAdministration
	Import-DscResource -ModuleName cNtfsAccessControl
	Import-DscResource -ModuleName cDataHub
	Import-DscResource -ModuleName SqlServerDsc
	
	Node EMEAZRHCARTAPP
	{
		xWindowsFeature NET-Framework-45-Core
		{
			Ensure = 'Present'
			Name = 'NET-Framework-45-Core'
			LogPath = 'C:\Temp\NET-Framework-45-Core.log'
			DependsOn = @(
			)
		}
	
		xWindowsFeature Web-Default-Doc
		{
			Ensure = 'Present'
			Name = 'Web-Default-Doc'
			LogPath = 'C:\Temp\Web-Default-Doc.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Dir-Browsing
		{
			Ensure = 'Present'
			Name = 'Web-Dir-Browsing'
			LogPath = 'C:\Temp\Web-Dir-Browsing.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Http-Errors
		{
			Ensure = 'Present'
			Name = 'Web-Http-Errors'
			LogPath = 'C:\Temp\Web-Http-Errors.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Static-Content
		{
			Ensure = 'Present'
			Name = 'Web-Static-Content'
			LogPath = 'C:\Temp\Web-Static-Content.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Http-Redirect
		{
			Ensure = 'Present'
			Name = 'Web-Http-Redirect'
			LogPath = 'C:\Temp\Web-Http-Redirect.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Http-Logging
		{
			Ensure = 'Present'
			Name = 'Web-Http-Logging'
			LogPath = 'C:\Temp\Web-Http-Logging.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Log-Libraries
		{
			Ensure = 'Present'
			Name = 'Web-Log-Libraries'
			LogPath = 'C:\Temp\Web-Log-Libraries.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Request-Monitor
		{
			Ensure = 'Present'
			Name = 'Web-Request-Monitor'
			LogPath = 'C:\Temp\Web-Request-Monitor.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Http-Tracing
		{
			Ensure = 'Present'
			Name = 'Web-Http-Tracing'
			LogPath = 'C:\Temp\Web-Http-Tracing.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Stat-Compression
		{
			Ensure = 'Present'
			Name = 'Web-Stat-Compression'
			LogPath = 'C:\Temp\Web-Stat-Compression.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Filtering
		{
			Ensure = 'Present'
			Name = 'Web-Filtering'
			LogPath = 'C:\Temp\Web-Filtering.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Basic-Auth
		{
			Ensure = 'Present'
			Name = 'Web-Basic-Auth'
			LogPath = 'C:\Temp\Web-Basic-Auth.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Windows-Auth
		{
			Ensure = 'Present'
			Name = 'Web-Windows-Auth'
			LogPath = 'C:\Temp\Web-Windows-Auth.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Net-Ext45
		{
			Ensure = 'Present'
			Name = 'Web-Net-Ext45'
			LogPath = 'C:\Temp\Web-Net-Ext45.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Asp-Net45
		{
			Ensure = 'Present'
			Name = 'Web-Asp-Net45'
			LogPath = 'C:\Temp\Web-Asp-Net45.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-ISAPI-Ext
		{
			Ensure = 'Present'
			Name = 'Web-ISAPI-Ext'
			LogPath = 'C:\Temp\Web-ISAPI-Ext.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-ISAPI-Filter
		{
			Ensure = 'Present'
			Name = 'Web-ISAPI-Filter'
			LogPath = 'C:\Temp\Web-ISAPI-Filter.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Mgmt-Console
		{
			Ensure = 'Present'
			Name = 'Web-Mgmt-Console'
			LogPath = 'C:\Temp\Web-Mgmt-Console.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature Web-Mgmt-Service
		{
			Ensure = 'Present'
			Name = 'Web-Mgmt-Service'
			LogPath = 'C:\Temp\Web-Mgmt-Service.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature MSMQ-Server
		{
			Ensure = 'Present'
			Name = 'MSMQ-Server'
			LogPath = 'C:\Temp\MSMQ-Server.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature MSMQ-Directory
		{
			Ensure = 'Present'
			Name = 'MSMQ-Directory'
			LogPath = 'C:\Temp\MSMQ-Directory.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature MSMQ-HTTP-Support
		{
			Ensure = 'Present'
			Name = 'MSMQ-HTTP-Support'
			LogPath = 'C:\Temp\MSMQ-HTTP-Support.log'
			DependsOn = @(
			)
		}
		
		xPackage InstallVcRedist
		{
			Ensure = 'Present'
			Name = 'Microsoft Visual C++ 2012 Redistributable (x64) - 11.0.61030'
			ProductId = ''
			Path = 'C:\Temp\vcredist_x64.exe'
			Arguments = '/q /norestart'
			RunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
			)
		}
		
		xPackage InstallFocusClient
		{
			Ensure = 'Present'
			Name = 'Ambit Focus 2020.2.0'
			ProductId = '{59EA3FFD-A27A-4893-97B4-D63E48227F0A}'
			Path = 'C:\Temp\Focus Internal-20.2.0.12543-win64.msi'
			Arguments = 'INSTALLFOLDER="C:\Program Files\Ambit Focus 2020.2"'
			RunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			LogPath = 'C:\Temp\InstallFocusClient.log'
			DependsOn = @(
				'[cInstallNetFramework]NetFramework472',
				'[xPackage]InstallVcRedist'
			)
		}
		
		xRemoteFile CopyFocusLicense
		{
			Uri = 'file:///C:/Temp/FocusLicense.xml'
			DestinationPath = 'C:\Program Files\Ambit Focus 2020.2\license.xml'
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		cFocusSetting FileDBScripts
		{
			Ensure = 'Present'
			Key = 'File.DBScripts'
			Value = 'C:\Program Files\Ambit Focus 2020.2\FocusDBScripts.ZIP'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
			)
		}
		
		WaitForAll WaitForInstallSql
		{
			ResourceName = '[SqlSetup]InstallSql'
			NodeName = 'EMEAZRHCARTDB'
			RetryIntervalSec = 30
			RetryCount = 30
			DependsOn = @(
			)
		}
		
		cInitializeFocusDb CreateInitializedFocusDb
		{
			Key = 'CreateInitializedFocusDb'
			FocusConsoleExePath = 'C:\Program Files\Ambit Focus 2020.2\Focus.Console.exe'
			InvokeOutputFolder = 'C:\temp'
			DatabaseServerName = 'EMEAZRHCARTDB'
			DatabaseInstanceName = 'MSSQLSERVER'
			SqlCredential = New-Object System.Management.Automation.PSCredential ("sa", (ConvertTo-SecureString "SAPwd12+" -AsPlainText -Force))
			DatabaseName = 'FocusDB'
			PsDscRunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
				'[cFocusSetting]FileDBScripts',
				'[xPackage]InstallFocusClient',
				'[WaitForAll]WaitForInstallSql'
			)
		}
		
		cFocusSetting StatusManagersqlAuthentication
		{
			Ensure = 'Present'
			Key = 'StatusManager.sqlAuthentication'
			Value = 'False'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		cFocusSetting StatusManagerlocation
		{
			Ensure = 'Present'
			Key = 'StatusManager.location'
			Value = 'EMEAZRHCARTDB'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		cFocusSetting StatusManagername {
			Ensure = 'Present'
			Key = 'StatusManager.name'
			Value = 'FocusDB'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		cFocusImportJob InitializeDatabase
		{
			Key = 'InitializeDatabase'
			FocusConsoleExePath = 'C:\Program Files\Ambit Focus 2020.2\Focus.Console.exe'
			InvokeOutputFolder = 'C:\temp'
			JobFilePath = 'C:\Temp\InitializeDatabase.xml'
			DatabaseServerName = 'EMEAZRHCARTDB'
			DatabaseInstanceName = 'MSSQLSERVER'
			DatabaseName = 'FocusDB'
			PsDscRunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
				'[cInitializeFocusDb]CreateInitializedFocusDb'
			)
		}
		
		cFocusExecuteJob InitializeDatabase14790120
		{
			Key = 'InitializeDatabase14790120'
			FocusConsoleExePath = 'C:\Program Files\Ambit Focus 2020.2\Focus.Console.exe'
			InvokeOutputFolder = 'C:\temp'
			JobName = 'InitializeDatabase'
			JobParameters = '@DbServerInstance=EMEAZRHCARTDB @DbName=LoggingDB @DbType=Logging'
			DatabaseServerName = 'EMEAZRHCARTDB'
			DatabaseInstanceName = 'MSSQLSERVER'
			DatabaseName = 'FocusDB'
			PsDscRunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
				'[cFocusImportJob]InitializeDatabase'
			)
		}
		
		cFocusSetting tracedatabasesqlAuthentication
		{
			Ensure = 'Present'
			Key = 'trace.database.sqlAuthentication'
			Value = 'False'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		cFocusSetting tracedatabaselocation
		{
			Ensure = 'Present'
			Key = 'trace.database.location'
			Value = 'EMEAZRHCARTDB'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		cFocusSetting tracedatabasename
		{
			Ensure = 'Present'
			Key = 'trace.database.name'
			Value = 'LoggingDB'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		OK Firewall FocusAppServer-TCP-In
		{
			Ensure = 'Present'
			Name = 'FocusAppServer-TCP-In'
			DisplayName = 'Focus Port Range 5000 - 5100'
			Description = 'Allow remote connections'
			Enabled = $true
			Profile = @('Domain', 'Private', 'Public')
			Direction = 'Inbound'
			LocalPort = @('5000', '5001', '5002', '5003', '5004', '5005', '5006', '5007', '5008', '5009', '5010', '5011', '5012', '5013', '5014', '5015', '5016', '5017', '5018', '5019', '5020', '5021', '5022', '5023', '5024', '5025', '5026', '5027', '5028', '5029', '5030', '5031', '5032', '5033', '5034', '5035', '5036', '5037', '5038', '5039', '5040', '5041', '5042', '5043', '5044', '5045', '5046', '5047', '5048', '5049', '5050', '5051', '5052', '5053', '5054', '5055', '5056', '5057', '5058', '5059', '5060', '5061', '5062', '5063', '5064', '5065', '5066', '5067', '5068', '5069', '5070', '5071', '5072', '5073', '5074', '5075', '5076', '5077', '5078', '5079', '5080', '5081', '5082', '5083', '5084', '5085', '5086', '5087', '5088', '5089', '5090', '5091', '5092', '5093', '5094', '5095', '5096', '5097', '5098', '5099', '5100')
			Protocol = 'TCP'
			DependsOn = @(
			)
		}
		
		cFocusSetting CalculationRemoteType
		{
			Ensure = 'Present'
			Key = 'Calculation.RemoteType'
			Value = '1'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		cFocusSetting RouterAddress
		{
			Ensure = 'Present'
			Key = 'RouterAddress'
			Value = 'EMEAZRHCARTCAL1'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		cFocusSetting RouterPort
		{
			Ensure = 'Present'
			Key = 'RouterPort'
			Value = '56060'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		cFocusSetting RemoteCollection
		{
			Ensure = 'Present'
			Key = 'RemoteCollection'
			Value = 'False'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		cFocusSetting FocusClientPortFrom
		{
			Ensure = 'Present'
			Key = 'FocusClientPortFrom'
			Value = '5000'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		cFocusSetting FocusClientPortTo
		{
			Ensure = 'Present'
			Key = 'FocusClientPortTo'
			Value = '5100'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		cFocusSetting DataHubUrl
		{
			Ensure = 'Present'
			Key = 'DataHubUrl'
			Value = 'http://EMEAZRHCARTAPP:8080/DataHub/'
			SettingsFilePath = 'C:\Program Files\Ambit Focus 2020.2\settings.dat'
			Force = $true
			DependsOn = @(
				'[xPackage]InstallFocusClient'
			)
		}
		
		xWebAppPool FISWebAppPool
		{
			Ensure = 'Present'
			Name = 'FIS'
			State = 'Started'
			autoStart = $true
			CLRConfigFile = ''
			enable32BitAppOnWin64 = $false
			enableConfigurationOverride = $true
			managedPipelineMode = 'Integrated'
			managedRuntimeLoader = 'webengine4.dll'
			managedRuntimeVersion = 'v4.0'
			passAnonymousToken = $true
			startMode = 'OnDemand'
			queueLength = 1000
			cpuAction = 'NoAction'
			cpuLimit = 90000
			cpuResetInterval = '00:05:00'
			cpuSmpAffinitized = $false
			cpuSmpProcessorAffinityMask = 4294967295
			cpuSmpProcessorAffinityMask2 = 4294967295
			identityType = 'ApplicationPoolIdentity'
			idleTimeout = '00:00:00'
			idleTimeoutAction = 'Terminate'
			loadUserProfile = $true
			logEventOnProcessModel = 'IdleTimeout'
			logonType = 'LogonBatch'
			manualGroupMembership = $false
			maxProcesses = 1
			pingingEnabled = $true
			pingInterval = '00:00:30'
			pingResponseTime = '00:01:30'
			setProfileEnvironment = $false
			shutdownTimeLimit = '00:01:30'
			startupTimeLimit = '00:01:30'
			orphanActionExe = ''
			orphanActionParams = ''
			orphanWorkerProcess = $false
			loadBalancerCapabilities = 'HttpLevel'
			rapidFailProtection = $true
			rapidFailProtectionInterval = '00:05:00'
			rapidFailProtectionMaxCrashes = 5
			autoShutdownExe = ''
			autoShutdownParams = ''
			disallowOverlappingRotation = $false
			disallowRotationOnConfigChange = $false
			logEventOnRecycle = 'Time,Requests,Schedule,Memory,IsapiUnhealthy,OnDemand,ConfigChange,PrivateMemory'
			restartMemoryLimit = 0
			restartPrivateMemoryLimit = 0
			restartRequestsLimit = 0
			restartTimeLimit = '00:00:00'
			restartSchedule = @()
			DependsOn = @(
			)
		}
		
		File WebsitesDirectory
		{
			Ensure = 'Present'
			DestinationPath = 'C:\Websites'
			Type = 'Directory'
			Force = $true
			DependsOn = @(
			)
		}
		
		File WebAppDirectory
		{
			Ensure = 'Present'
			DestinationPath = 'C:\Websites\DataHub'
			Type = 'Directory'
			Force = $true
			DependsOn = @(
				'[File]WebsitesDirectory'
			)
		}
		
		cNtfsPermissionEntry AppPoolReadPermission
		{
			Ensure = 'Present'
			Path = 'C:\Websites'
			Principal = 'IIS AppPool\FIS'
			AccessControlInformation = @(
				cNtfsAccessControlInformation 
				{
					AccessControlType = 'Allow'
					FileSystemRights = 'Read'
					Inheritance = 'ThisFolderSubfoldersAndFiles'
					NoPropagateInherit = $false
				}
			)
			DependsOn = @(
				'[File]WebAppDirectory'
			)
		}
		
		xWebsite DataHubWebsite
		{
			Ensure = 'Present'
			Name = 'DataHub'
			PhysicalPath = 'C:\Websites'
			State = 'Started'
			BindingInfo = MSFT_xWebBindingInformation
			{
				Protocol = 'http'
				IPAddress = '*'
				Port = '8080'
			}
			ApplicationPool = 'FIS'
			EnabledProtocols = 'http'
			PreloadEnabled = $false
			AuthenticationInfo = MSFT_xWebAuthenticationInformation
			{
				Anonymous = $false
				Basic = $false
				Digest = $false
				Windows = $true
			}
			DependsOn = @(
				'[File]WebsitesDirectory'
			)
		}
		
		Firewall DataHubWebsite-TCP-In
		{
			Ensure = 'Present'
			Name = 'DataHubWebsite-TCP-In'
			DisplayName = 'DataHub'
			Description = 'Allow remote connections'
			Enabled = $true
			Profile = @('Domain', 'Private', 'Public')
			Direction = 'Inbound'
			LocalPort = @('8080')
			Protocol = 'TCP'
			DependsOn = @(
			)
		}
		
		xWebApplication DataHubWebApplication
		{
			Ensure = 'Present'
			Website = 'DataHub'
			Name = 'DataHub'
			WebAppPool = 'FIS'
			PhysicalPath = 'C:\Websites\DataHub'
			PreloadEnabled = $true
			AuthenticationInfo = MSFT_xWebApplicationAuthenticationInformation
			{
				Anonymous = $false
				Basic = $false
				Digest = $false
				Windows = $true
			}
			EnabledProtocols = @('http')
			DependsOn = @(
				'[Firewall]DataHubWebsite-TCP-In'
			)
		}
		
		cWebsiteConfiguration ConnectionTimeout
		{
			Key = 'ConnectionTimeout'
			WebsiteName = 'DataHub'
			PropertyName = 'limits.connectionTimeout'
			PropertyValue = '00:30:00'
			DependsOn = @(
				'[xWindowsFeature]Web-Mgmt-Console'
			)
		}
		
		xPackage InstallWebDeploy
		{
			Ensure = 'Present'
			Name = 'Microsoft Web Deploy 3.5'
			ProductId = '{1A81DA24-AF0B-4406-970E-54400D6EC118}'
			Path = 'C:\Temp\WebDeploy35_amd64_en-US.msi'
			Arguments = '/norestart ADDLOCAL=ALL LicenseAccepted="0"'
			RunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			LogPath = 'C:\Temp\InstallWebDeploy.log'
			DependsOn = @(
			)
		}
		
		cWebPackageDeploy WebUIPackage
		{
			Ensure = 'Present'
			SourcePath = 'C:\Temp\DataHub.WebUI.2020.2.0.zip'
			WebSiteName = 'DataHub'
			WebApplicationName = 'DataHub'
			DependsOn = @(
				'[xPackage]InstallWebDeploy'
			)
		}
		
		cConnectionString DataHubDbConnStrWeb
		{
			Ensure = 'Present'
			Path = 'C:\Websites\DataHub\Web.config'
			Key = 'DataHubDb'
			ConnectionString = 'Server=EMEAZRHCARTDB;Database=DataHubDb;User ID=DHUser;Password=DHPwd12+'
			DependsOn = @(
			)
		}
		
		cAppSetting DataHubDbAppSetting
		{
			Ensure = 'Present'
			Path = 'C:\Websites\DataHub\Web.config'
			Key = 'DataHubDbType'
			Value = 'MsSqlServer'
			DependsOn = @(
			)
		}
		
		cConnectionString FeedSourceDbConnStrWeb
		{
			Ensure = 'Present'
			Path = 'C:\Websites\DataHub\Web.config'
			Key = 'DataHubFeedSourceDb'
			ConnectionString = 'Server=EMEAZRHCARTDB;Database=FeedSourceDb;User ID=DHUser;Password=DHPwd12+'
			DependsOn = @(
			)
		}
		
		File FocusPluginsFolder
		{
			Ensure = 'Present'
			DestinationPath = 'C:\Websites\DataHub\Plugins'
			Type = 'Directory'
			Force = $true
			DependsOn = @(
			)
		}
		
		xArchive ExtractInstrumentsPlugin
		{
			Ensure = 'Present'
			Path = 'C:\Temp\Focus Instrument Plug-In-2020.2.0.zip'
			Destination = 'C:\Websites\DataHub\Plugins'
			DependsOn = @(
				'[File]FocusPluginsFolder'
			)
		}
		
		xRemoteFile CopyDataHubLicense
		{
			Uri = 'file:///C:/Temp/DataHubLicense.xml'
			DestinationPath = 'C:\Websites\DataHub\App_Data\license.xml'
			DependsOn = @(
			)
		}
		
		WaitForAll WaitForDataHubDbOwner
		{
			ResourceName = '[SqlDatabaseOwner]DataHubDbOwner'
			NodeName = 'EMEAZRHCARTDB'
			RetryIntervalSec = 30
			RetryCount = 30
			DependsOn = @(
			)
		}
		
		cInvokeRequest InvokeDataHub
		{
			Key = 'InvokeDataHub'
			Uri = 'http://EMEAZRHCARTAPP:8080/DataHub'
			DependsOn = @(
				'[WaitForAll]WaitForDataHubDbOwner'
			)
		}
	}
	
	Node EMEAZRHCARTDB
	{
		xWindowsFeature NET-Framework-45-Core
		{
			Ensure = 'Present'
			Name = 'NET-Framework-45-Core'
			LogPath = 'C:\Temp\NET-Framework-45-Core.log'
			DependsOn = @(
			)
		}
		
		xWindowsFeature RSAT-AD-PowerShell
		{
			Ensure = 'Present'
			Name = 'RSAT-AD-PowerShell'
			LogPath = 'C:\Temp\RSAT-AD-PowerShell.log'
			DependsOn = @(
			)
		}
		
		cMountImage SqlIso
		{
			Ensure = 'Present'
			ImagePath = 'C:\Temp\en_sql_server_2019_developer_x64_dvd_e5ade34a.iso'
			DriveLetter = 'K:'
			DependsOn = @(
			)
		}
		
		SqlSetup InstallSql
		{
			Action = 'Install'
			InstanceName = 'MSSQLSERVER'
			SourcePath = 'K:'
			Features = 'SQLENGINE'
			SQLCollation = 'Latin1_General_CS_AS'
			UpdateEnabled = 'False'
			SQMReporting = 'False'
			ErrorReporting = 'False'
			ForceReboot = $true
			SecurityMode = 'SQL'
			SAPwd = New-Object System.Management.Automation.PSCredential ("sa", (ConvertTo-SecureString "SAPwd12+" -AsPlainText -Force))
			SQLSvcAccount = New-Object System.Management.Automation.PSCredential ("DEVPFB\Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			AgtSvcAccount = New-Object System.Management.Automation.PSCredential ("DEVPFB\Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			ASSvcAccount = New-Object System.Management.Automation.PSCredential ("DEVPFB\Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			SQLSysAdminAccounts = @('DEVPFB\Administrator', 'DEVPFB\robert.kroll', 'DEVPFB\Developers', 'EMEAZRHCARTDB\Administrator')
			ASSysAdminAccounts = @('DEVPFB\Administrator', 'DEVPFB\robert.kroll', 'DEVPFB\Developers', 'EMEAZRHCARTDB\Administrator')
			InstallSharedDir = 'C:\Program Files\Microsoft SQL Server'
			InstallSharedWOWDir = 'C:\Program Files (x86)\Microsoft SQL Server'
			InstanceDir = 'C:\Program Files\Microsoft SQL Server'
			InstallSQLDataDir = 'D:\SQL\Data'
			SQLUserDBDir = 'D:\SQL\Data'
			SQLUserDBLogDir = 'D:\SQL\Log'
			SQLTempDBDir = 'D:\SQL\Data'
			SQLTempDBLogDir = 'D:\SQL\Log'
			SQLBackupDir = 'D:\SQL\Backup'
			SqlTempdbFileCount = 4
			SqlTempdbFileSize = 1024
			SqlTempdbFileGrowth = 512
			SqlTempdbLogFileSize = 128
			SqlTempdbLogFileGrowth = 64
			DependsOn = @(
				'[cMountImage]SqlIso'
			)
		}
		
		SqlWindowsFirewall SqlFirewall
		{
			Ensure = 'Present'
			Features = 'SQLENGINE'
			InstanceName = 'MSSQLSERVER'
			SourcePath = 'K:'
			DependsOn = @(
				'[SqlSetup]InstallSql'
			)
		}
		
		SqlServerNetwork SqlTcpProtocol
		{
			InstanceName = 'MSSQLSERVER'
			ProtocolName = 'tcp'
			IsEnabled = $true
			TCPPort = '1433'
			RestartService = $true
			DependsOn = @(
				'[SqlWindowsFirewall]SqlFirewall'
			)
		}
		
		cSqlNamedPipes EnableNamedPipes
		{
			DependsOn = @(
				'[SqlServerNetwork]SqlTcpProtocol'
			)
		}
		
		cMountImage UnmountSqlIso
		{
			Ensure = 'Absent'
			ImagePath = 'C:\Temp\en_sql_server_2019_developer_x64_dvd_e5ade34a.iso'
			DriveLetter = 'K:'
			DependsOn = @(
			)
		}
		
		SqlServerMemory SqlMemory
		{
			Ensure = 'Present'
			InstanceName = 'MSSQLSERVER'
			DynamicAlloc = $false
			MaxMemory = 57600
			DependsOn = @(
				'[SqlSetup]InstallSql'
			)
		}
		
		SqlDatabase LoggingDB
		{
			Ensure = 'Present'
			ServerName = 'EMEAZRHCARTDB'
			InstanceName = 'MSSQLSERVER'
			Name = 'LoggingDB'
			DependsOn = @(
			)
		}
		
		SqlDatabase FeedSourceDb
		{
			Ensure = 'Present'
			ServerName = 'EMEAZRHCARTDB'
			InstanceName = 'MSSQLSERVER'
			Name = 'FeedSourceDb'
			DependsOn = @(
			)
		}
		
		SqlDatabase DataHubDb
		{
			Ensure = 'Present'
			ServerName = 'EMEAZRHCARTDB'
			InstanceName = 'MSSQLSERVER'
			Name = 'DataHubDb'
			DependsOn = @(
			)
		}
		
		SqlServerLogin SqlLogin_DHUser
		{
			Ensure = 'Present'
			Name = 'DHUser'
			LoginType = 'SqlLogin'
			ServerName = 'EMEAZRHCARTDB'
			InstanceName = 'MSSQLSERVER'
			LoginCredential = New-Object System.Management.Automation.PSCredential ("DHUser", (ConvertTo-SecureString "DHPwd12+" -AsPlainText -Force))
			LoginMustChangePassword = $false
			LoginPasswordExpirationEnabled = $false
			LoginPasswordPolicyEnforced = $false
			PsDscRunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
			)
		}
		
		SqlDatabaseOwner FeedSourceDbOwner
		{
			ServerName = 'EMEAZRHCARTDB'
			InstanceName = 'MSSQLSERVER'
			Database = 'FeedSourceDb'
			Name = 'DHUser'
			PsDscRunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
				'[SqlServerLogin]SqlLogin_DHUser'
			)
		}
		
		SqlDatabaseOwner DataHubDbOwner
		{
			ServerName = 'EMEAZRHCARTDB'
			InstanceName = 'MSSQLSERVER'
			Database = 'DataHubDb'
			Name = 'DHUser'
			PsDscRunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
				'[SqlServerLogin]SqlLogin_DHUser'
			)
		}
		
		xPackage InstallSsms
		{
			Ensure = 'Present'
			Name = 'Microsoft SQL Server Management Studio - 17.4'
			ProductId = ''
			Path = 'C:\Temp\SSMS-Setup-ENU.exe'
			Arguments = '/install /quiet /norestart /log "C:\Temp\InstallSsms.log"'
			RunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			CreateCheckRegValue = $true
			InstalledCheckRegKey = 'SOFTWARE\Ambit\BEA'
			InstalledCheckRegValueName = 'SqlServer2017_SSMS'
			InstalledCheckRegValueData = '1'
			DependsOn = @(
			)
		}
	}
	
	Node EMEAZRHCARTCAL1
	{
		xWindowsFeature NET-Framework-45-Core
		{
			Ensure = 'Present'
			Name = 'NET-Framework-45-Core'
			LogPath = 'C:\Temp\NET-Framework-45-Core.log'
			DependsOn = @(
			)
		}
		
		xPackage InstallVcRedist
		{
			Ensure = 'Present'
			Name = 'Microsoft Visual C++ 2012 Redistributable (x64) - 11.0.61030'
			ProductId = ''
			Path = 'C:\Temp\vcredist_x64.exe'
			Arguments = '/q /norestart'
			RunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
			)
		}
		
		cInstallNetCore NetCore31
		{
			Path = 'C:\Temp\windowsdesktop-runtime-3.1.21-win-x64.exe'
			Arguments = '/q /norestart'
			Version = 'WindowsDesktop.App 3.1.21'
			LogPath = 'C:\Temp\NetCore31.log'
			DependsOn = @(
			)
		}
		
		xPackage InstallFocusCalcServer
		{
			Ensure = 'Present'
			Name = 'Ambit Focus Calculation Engine Service 2020.2.0'
			ProductId = '{DBD406C5-9B39-4ECF-83BD-1EDFEB4F8970}'
			Path = 'C:\Temp\Focus Internal Calculation Engine Service-20.2.0.12543-win64.msi'
			Arguments = 'INSTALLFOLDER="C:\Program Files\Ambit Focus 2020.2\Calculation Engine Service" PORT=56060 CORES=1 ROUTER=EMEAZRHCARTCAL1:56060'
			RunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			LogPath = 'C:\Temp\InstallFocusCalcServer.log'
			DependsOn = @(
				'[cInstallNetCore]NetCore31'
			)
		}
		
		xService SetRouterServiceUser
		{
			Ensure = 'Present'
			Name = 'Ambit Focus Calculation Engine Service 2020.2.0'
			DesktopInteract = $false
			StartupType = 'Automatic'
			State = 'Running'
			Credential = New-Object System.Management.Automation.PSCredential ("DEVPFB\Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			PsDscRunAsCredential = New-Object System.Management.Automation.PSCredential ("DEVPFB\Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
				'[xPackage]InstallFocusCalcServer'
			)
		}
		
		xService InstallFocusCalcService01
		{
			Ensure = 'Present'
			Name = 'Ambit Focus Calculation Engine Service 2020.2.0 01'
			Path = '"C:\Program Files\Ambit Focus 2020.2\Calculation Engine Service\CalculationEngineService.exe" -port 56061 -cores 4 -router EMEAZRHCARTCAL1:56060'
			DisplayName = 'Ambit Focus Calculation Engine Service 2020.2.0 01'
			Description = 'Ambit Focus Calculation Engine Service 2020.2.0 01'
			StartupType = 'Automatic'
			State = 'Running'
			Credential = New-Object System.Management.Automation.PSCredential ("DEVPFB\Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			PsDscRunAsCredential = New-Object System.Management.Automation.PSCredential ("DEVPFB\Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
			)
		}
		
		xService InstallFocusCalcService02
		{
			Ensure = 'Present'
			Name = 'Ambit Focus Calculation Engine Service 2020.2.0 02'
			Path = '"C:\Program Files\Ambit Focus 2020.2\Calculation Engine Service\CalculationEngineService.exe" -port 56062 -cores 4 -router EMEAZRHCARTCAL1:56060'
			DisplayName = 'Ambit Focus Calculation Engine Service 2020.2.0 02'
			Description = 'Ambit Focus Calculation Engine Service 2020.2.0 02'
			StartupType = 'Automatic'
			State = 'Running'
			Credential = New-Object System.Management.Automation.PSCredential ("DEVPFB\Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			PsDscRunAsCredential = New-Object System.Management.Automation.PSCredential ("DEVPFB\Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
			)
		}
		
		Firewall FocusCalculationService-TCP-In
		{
			Ensure = 'Present'
			Name = 'FocusCalculationService-TCP-In'
			DisplayName = 'Focus Calculation Service'
			Description = 'Allow remote connections'
			Enabled = $true
			Profile = @('Domain', 'Private', 'Public')
			Direction = 'Inbound'
			LocalPort = @('56060', '56061', '56062')
			Protocol = 'TCP'
			DependsOn = @(
			)
		}
	}
	
	Node EMEAZRHCARTCAL2
	{
		xWindowsFeature NET-Framework-45-Core
		{
			Ensure = 'Present'
			Name = 'NET-Framework-45-Core'
			LogPath = 'C:\Temp\NET-Framework-45-Core.log'
			DependsOn = @(
			)
		}
		
		xPackage InstallVcRedist
		{
			Ensure = 'Present'
			Name = 'Microsoft Visual C++ 2012 Redistributable (x64) - 11.0.61030'
			ProductId = ''
			Path = 'C:\Temp\vcredist_x64.exe'
			Arguments = '/q /norestart'
			RunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
			)
		}
		
		cInstallNetCore NetCore31
		{
			Path = 'C:\Temp\windowsdesktop-runtime-3.1.21-win-x64.exe'
			Arguments = '/q /norestart'
			Version = 'WindowsDesktop.App 3.1.21'
			LogPath = 'C:\Temp\NetCore31.log'
			DependsOn = @(
			)
		}
		
		xPackage InstallFocusCalcServer
		{
			Ensure = 'Present'
			Name = 'Ambit Focus Calculation Engine Service 2020.2.0'
			ProductId = '{DBD406C5-9B39-4ECF-83BD-1EDFEB4F8970}'
			Path = 'C:\Temp\Focus Internal Calculation Engine Service-20.2.0.12543-win64.msi'
			Arguments = 'INSTALLFOLDER="C:\Program Files\Ambit Focus 2020.2\Calculation Engine Service" PORT=56063 CORES=4 ROUTER=EMEAZRHCARTCAL1:56060'
			RunAsCredential = New-Object System.Management.Automation.PSCredential ("Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			LogPath = 'C:\Temp\InstallFocusCalcServer.log'
			DependsOn = @(
				'[cInstallNetCore]NetCore31'
			)
		}
		
		xService SetRouterServiceUser
		{
			Ensure = 'Present'
			Name = 'Ambit Focus Calculation Engine Service 2020.2.0'
			DesktopInteract = $false
			StartupType = 'Automatic'
			State = 'Running'
			Credential = New-Object System.Management.Automation.PSCredential ("DEVPFB\Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			PsDscRunAsCredential = New-Object System.Management.Automation.PSCredential ("DEVPFB\Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
				'[xPackage]InstallFocusCalcServer'
			)
		}
		
		xService InstallFocusCalcService01
		{
			Ensure = 'Present'
			Name = 'Ambit Focus Calculation Engine Service 2020.2.0 01'
			Path = '"C:\Program Files\Ambit Focus 2020.2\Calculation Engine Service\CalculationEngineService.exe" -port 56064 -cores 4 -router EMEAZRHCARTCAL1:56060'
			DisplayName = 'Ambit Focus Calculation Engine Service 2020.2.0 01'
			Description = 'Ambit Focus Calculation Engine Service 2020.2.0 01'
			StartupType = 'Automatic'
			State = 'Running'
			Credential = New-Object System.Management.Automation.PSCredential ("DEVPFB\Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			PsDscRunAsCredential = New-Object System.Management.Automation.PSCredential ("DEVPFB\Administrator", (ConvertTo-SecureString "PFBVmP4ss" -AsPlainText -Force))
			DependsOn = @(
			)
		}
		
		Firewall FocusCalculationService-TCP-In
		{
			Ensure = 'Present'
			Name = 'FocusCalculationService-TCP-In'
			DisplayName = 'Focus Calculation Service'
			Description = 'Allow remote connections'
			Enabled = $true
			Profile = @('Domain', 'Private', 'Public')
			Direction = 'Inbound'
			LocalPort = @('56060', '56061', '56062')
			Protocol = 'TCP'
			DependsOn = @(
			)
		}
	}
}
