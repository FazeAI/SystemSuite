# =========================================================
# SYSTEM SUITE - v7.0 QUANTUM-GRID PRO EDITION
# =========================================================
<#
.SYNOPSIS
    Infrastruttura di ottimizzazione e deployment Windows.
.PARAMETER SilentMode
    Esegue l'installazione dei software standard senza GUI.
.PARAMETER SkipTelemetry
    Applica i tweak di privacy direttamente in modo silente.
.PARAMETER NetworkOptimize
    Forza i DNS Cloudflare e ottimizza la scheda di rete senza GUI.
#>

Param(
    [switch]$SilentMode,
    [switch]$SkipTelemetry,
    [switch]$NetworkOptimize
)

Clear-Host

# 1. VERIFICA PRIVILEGI AMMINISTRATORE
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "=========================================================" -ForegroundColor Red
    Write-Host " ERRORE critico: Avvia PowerShell come AMMINISTRATORE! " -ForegroundColor Red
    Write-Host "=========================================================" -ForegroundColor Red
    Start-Sleep -Seconds 4
    exit
}

# 2. AUTOMAZIONE SILENTE (Se invocato da Sito Web con parametri)
if ($SilentMode -or $SkipTelemetry -or $NetworkOptimize) {
    Write-Host "🚀 Modalità Automazione Cloud Rilevata. Esecuzione task..." -ForegroundColor Core
    if ($SkipTelemetry) {
        Write-Host "🔒 Disattivazione Telemetria..." -ForegroundColor Yellow
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -EA SilentlyContinue
    }
    if ($NetworkOptimize) {
        Write-Host "🌐 Ottimizzazione Rete & DNS Cloudflare..." -ForegroundColor Yellow
        $Interface = Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object -First 1
        if ($Interface) { Set-DnsClientServerAddress -InterfaceIndex $Interface.ifIndex -ServerAddresses ("1.1.1.1","1.0.0.1") }
    }
    Write-Host "✅ Task completati con successo." -ForegroundColor Green
    Start-Sleep -Seconds 2
    exit
}

# 3. RACCOLTA DATI HARDWARE AVANZATA (Per Dashboard GUI)
Write-Host "Analisi hardware e metriche di sistema in corso..." -ForegroundColor Cyan
$OSInfo = (Get-CimInstance Win32_OperatingSystem).Caption
$CPUInfo = (Get-CimInstance Win32_Processor).Name
$RAMRaw = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum
$RAMInfo = "$([Math]::Round($RAMRaw / 1GB)) GB RAM"

# Analisi Spazio Disco Primario (C:)
$Disk = Get-Volume -DriveLetter C
$DiskTotal = [Math]::Round($Disk.Size / 1GB, 1)
$DiskFree = [Math]::Round($Disk.SizeRemaining / 1GB, 1)
$DiskInfo = "$DiskFree GB disponibili su $DiskTotal GB (Drive C:)"

Add-Type -AssemblyName PresentationFramework

# =========================================================
# INTERFACCIA GRAFICA (XAML PREMIUM UI)
# =========================================================
[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="System Suite Quantum v7.0" Height="850" Width="1250" 
        WindowStartupLocation="CenterScreen" Background="#FF090D16" Foreground="#FFECEFF1" FontFamily="Segoe UI">
    
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="90"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>

        <Border Grid.Row="0" Background="#FF0F172A" BorderBrush="#FF0EA5E9" BorderThickness="0,0,0,3" Padding="25,10">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>
                <StackPanel Grid.Column="0" Orientation="Horizontal" VerticalAlignment="Center">
                    <TextBlock Text="⚡ QUANTUM" FontSize="26" FontWeight="Black" Foreground="#FF0EA5E9"/>
                    <TextBlock Text="SUITE" FontSize="26" FontWeight="Black" Foreground="#FFFFFFFF" Margin="8,0,0,0"/>
                    <Border Background="#FF047857" CornerRadius="6" Margin="15,0,0,0" Padding="8,3">
                        <TextBlock Text="v7.0 STABLE" FontSize="11" FontWeight="Bold" Foreground="White"/>
                    </Border>
                </StackPanel>
                <StackPanel Grid.Column="1" HorizontalAlignment="Right" VerticalAlignment="Center">
                    <TextBlock Text="Cloud-Linked Infrastructure Layer" FontSize="14" FontWeight="SemiBold" Foreground="#FF64748B" HorizontalAlignment="Right"/>
                    <TextBlock Text="Stato Licenza: Enterprise OpenSource" FontSize="11" Foreground="#FF10B981" HorizontalAlignment="Right"/>
                </StackPanel>
            </Grid>
        </Border>

        <TabControl Grid.Row="1" TabStripPlacement="Left" Background="Transparent" BorderThickness="0" Margin="0" Foreground="White">
            
            <TabItem Header="🖥️ Dashboard OS" FontSize="15" Height="55" Width="200" Margin="0,4">
                <Grid Background="#FF090D16" Margin="35">
                    <StackPanel>
                        <TextBlock Text="Diagnostica Hardware e Stato" FontSize="24" FontWeight="Bold" Foreground="#FF0EA5E9" Margin="0,0,0,25"/>
                        
                        <Border Background="#FF0F172A" BorderBrush="#FF1E293B" BorderThickness="1" CornerRadius="8" Padding="20" Margin="0,0,0,12">
                            <Grid>
                                <TextBlock Text="Sistema Operativo" FontSize="14" Foreground="#FF64748B"/>
                                <TextBlock Text="$OSInfo" FontSize="16" FontWeight="Bold" Foreground="White" HorizontalAlignment="Right"/>
                            </Grid>
                        </Border>

                        <Border Background="#FF0F172A" BorderBrush="#FF1E293B" BorderThickness="1" CornerRadius="8" Padding="20" Margin="0,0,0,12">
                            <Grid>
                                <TextBlock Text="Architettura Processore" FontSize="14" Foreground="#FF64748B"/>
                                <TextBlock Text="$CPUInfo" FontSize="16" FontWeight="Bold" Foreground="White" HorizontalAlignment="Right"/>
                            </Grid>
                        </Border>

                        <Border Background="#FF0F172A" BorderBrush="#FF1E293B" BorderThickness="1" CornerRadius="8" Padding="20" Margin="0,0,0,12">
                            <Grid>
                                <TextBlock Text="Memoria Volatile" FontSize="14" Foreground="#FF64748B"/>
                                <TextBlock Text="$RAMInfo" FontSize="16" FontWeight="Bold" Foreground="#FF10B981" HorizontalAlignment="Right"/>
                            </Grid>
                        </Border>

                        <Border Background="#FF0F172A" BorderBrush="#FF1E293B" BorderThickness="1" CornerRadius="8" Padding="20" Margin="0,0,0,12">
                            <Grid>
                                <TextBlock Text="Spazio Storage Primario" FontSize="14" Foreground="#FF64748B"/>
                                <TextBlock Text="$DiskInfo" FontSize="16" FontWeight="Bold" Foreground="#F59E0B" HorizontalAlignment="Right"/>
                            </Grid>
                        </Border>
                        
                        <Border Background="#FF1E1B4B" BorderBrush="#FF4338CA" BorderThickness="1" CornerRadius="8" Padding="20" Margin="0,20,0,0">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <StackPanel Grid.Column="0">
                                    <TextBlock Text="🛡️ Protezione e Snapshot di Sicurezza" FontSize="16" FontWeight="Bold" Foreground="#FFC7D2FE"/>
                                    <TextBlock Text="Genera un punto di ripristino istantaneo prima di eseguire modifiche strutturali." FontSize="13" Foreground="#FF94A3B8" TextWrapping="Wrap" Margin="0,4,15,0"/>
                                </StackPanel>
                                <Button Name="BtnCreateRestore" Grid.Column="1" Content="Genera Snapshot OS" Padding="20,0" Height="42" Background="#FF4338CA" Foreground="White" FontWeight="Bold" BorderThickness="0" Cursor="Hand"/>
                            </Grid>
                        </Border>
                    </StackPanel>
                </Grid>
            </TabItem>
            
            <TabItem Header="📦 Software Hub" FontSize="15" Height="55" Width="200" Margin="0,4">
                <Grid Background="#FF090D16" Margin="35">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    
                    <TextBlock Grid.Row="0" Text="Deployment Silenzioso Applicativi (WinGet Layer)" FontSize="24" FontWeight="Bold" Foreground="#FF0EA5E9" Margin="0,0,0,20"/>
                    
                    <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                        <WrapPanel Orientation="Horizontal">
                            <GroupBox Header="Web Browsers" Width="290" Margin="8" Foreground="#FF0EA5E9" Background="#FF0F172A" BorderBrush="#FF1E293B" Padding="12">
                                <StackPanel>
                                    <CheckBox Name="ChkChrome" Content="Google Chrome" Foreground="White" Margin="0,8"/>
                                    <CheckBox Name="ChkBrave" Content="Brave Browser" Foreground="White" Margin="0,8"/>
                                    <CheckBox Name="ChkFirefox" Content="Mozilla Firefox" Foreground="White" Margin="0,8"/>
                                </StackPanel>
                            </GroupBox>
                            <GroupBox Header="Sviluppo &amp; DevOps" Width="290" Margin="8" Foreground="#FF0EA5E9" Background="#FF0F172A" BorderBrush="#FF1E293B" Padding="12">
                                <StackPanel>
                                    <CheckBox Name="ChkVSCode" Content="Visual Studio Code" Foreground="White" Margin="0,8"/>
                                    <CheckBox Name="ChkGit" Content="Git SCM System" Foreground="White" Margin="0,8"/>
                                    <CheckBox Name="ChkPython" Content="Python Runtime 3.x" Foreground="White" Margin="0,8"/>
                                </StackPanel>
                            </GroupBox>
                            <GroupBox Header="Utility di Sistema" Width="290" Margin="8" Foreground="#FF0EA5E9" Background="#FF0F172A" BorderBrush="#FF1E293B" Padding="12">
                                <StackPanel>
                                    <CheckBox Name="Chk7Zip" Content="7-Zip Archiver" Foreground="White" Margin="0,8"/>
                                    <CheckBox Name="ChkPowerToys" Content="Microsoft PowerToys" Foreground="White" Margin="0,8"/>
                                    <CheckBox Name="ChkVLC" Content="VLC Media Player" Foreground="White" Margin="0,8"/>
                                </StackPanel>
                            </GroupBox>
                        </WrapPanel>
                    </ScrollViewer>
                    
                    <Grid Grid.Row="2" Margin="0,20,0,0">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="Auto"/>
                        </Grid.ColumnDefinitions>
                        <Button Name="BtnRunUpdates" Grid.Column="0" Content="🔄 Sincronizza ed Aggiorna App Esistenti" Height="48" Background="#FF1E293B" Foreground="#FF0EA5E9" BorderBrush="#FF0EA5E9" BorderThickness="1" FontWeight="Bold" Margin="0,0,15,0" Cursor="Hand"/>
                        <Button Name="BtnRunInstall" Grid.Column="1" Content="🚀 AVVIA DEPLOY SELEZIONATI" Height="48" Width="300" Background="#FF0EA5E9" Foreground="#FF090D16" FontWeight="Black" BorderThickness="0" Cursor="Hand"/>
                    </Grid>
                </Grid>
            </TabItem>

            <TabItem Header="🚀 Ottimizzazioni" FontSize="15" Height="55" Width="200" Margin="0,4">
                <Grid Background="#FF090D16" Margin="35">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    
                    <ScrollViewer Grid.Row="0">
                        <StackPanel>
                            <TextBlock Text="Tweaks Avanzati di Registro" FontSize="24" FontWeight="Bold" Foreground="#FF0EA5E9" Margin="0,0,0,20"/>
                            
                            <Border Background="#FF0F172A" CornerRadius="8" Padding="18" Margin="0,0,0,15" BorderBrush="#FF1E293B" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="Privacy &amp; Telemetria" FontWeight="Bold" FontSize="16" Foreground="#FF0EA5E9" Margin="0,0,0,10"/>
                                    <CheckBox Name="ChkTweakTelemetry" Content="Sradica Telemetria Microsoft e Raccolta Dati Asincrona" Foreground="#FFCBD5E1" Margin="0,6"/>
                                    <CheckBox Name="ChkTweakBing" Content="Inibisci Ricerche ed Annunci Bing nel Menu Start" Foreground="#FFCBD5E1" Margin="0,6"/>
                                </StackPanel>
                            </Border>

                            <Border Background="#FF0F172A" CornerRadius="8" Padding="18" Margin="0,0,0,15" BorderBrush="#FF1E293B" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="Performance &amp; Kernel Gaming" FontWeight="Bold" FontSize="16" Foreground="#FF0EA5E9" Margin="0,0,0,10"/>
                                    <CheckBox Name="ChkTweakGameMode" Content="Attiva Ottimizzazione Thread CPU per Windows Game Mode" Foreground="#FFCBD5E1" Margin="0,6"/>
                                    <CheckBox Name="ChkTweakFastStartup" Content="Forza Disattivazione Avvio Rapido (Previene Corruzione RAM)" Foreground="#FFCBD5E1" Margin="0,6"/>
                                    <CheckBox Name="ChkTweakHibernate" Content="Rimuovi File Ibernazione (Svuota spazio istantaneo su disco)" Foreground="#FFCBD5E1" Margin="0,6"/>
                                </StackPanel>
                            </Border>
                        </StackPanel>
                    </ScrollViewer>
                    
                    <Button Name="BtnApplyTweaks" Grid.Row="1" Content="⚡ SCRIVI CHIAVI DI REGISTRO" Height="48" Background="#FF10B981" Foreground="White" FontWeight="Black" BorderThickness="0" Cursor="Hand"/>
                </Grid>
            </TabItem>

            <TabItem Header="🧹 Manutenzione" FontSize="15" Height="55" Width="200" Margin="0,4">
                <Grid Background="#FF090D16" Margin="35">
                    <StackPanel>
                        <TextBlock Text="Riparazione Scripting nativa" FontSize="24" FontWeight="Bold" Foreground="#FF0EA5E9" Margin="0,0,0,20"/>
                        <WrapPanel Orientation="Horizontal">
                            <Button Name="BtnFixSFC" Content="🔧 Ripara File di Sistema (SFC / DISM)" Width="310" Height="75" Background="#FF0F172A" BorderBrush="#FF1E293B" Foreground="White" Margin="8" Cursor="Hand"/>
                            <Button Name="BtnFixTemp" Content="🗑️ Svuota Cache e File Temporanei d'Ambiente" Width="310" Height="75" Background="#FF0F172A" BorderBrush="#FF1E293B" Foreground="White" Margin="8" Cursor="Hand"/>
                            <Button Name="BtnResetUpdate" Content="🔄 Reset Catalogo Windows Update Corrotto" Width="310" Height="75" Background="#FF0F172A" BorderBrush="#FF1E293B" Foreground="White" Margin="8" Cursor="Hand"/>
                            <Button Name="BtnDNSCloudflare" Content="🌐 Forza DNS Veloci (Cloudflare 1.1.1.1)" Width="310" Height="75" Background="#FF0F172A" BorderBrush="#FF0EA5E9" Foreground="#FF0EA5E9" Margin="8" Cursor="Hand"/>
                            <Button Name="BtnDebloat" Content="🔥 CLEAR OUT BLOATWARE (Rimuovi App Native Inutili)" Width="640" Height="75" Background="#FF7F1D1D" Foreground="White" FontWeight="Bold" Margin="8" BorderThickness="0" Cursor="Hand"/>
                        </WrapPanel>
                    </StackPanel>
                </Grid>
            </TabItem>
        </TabControl>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$Window = [Windows.Markup.XamlReader]::Load($reader)

# --- LOGICA APPLICATIVA ---

# 1. Snapshot di Sistema
$Window.FindName("BtnCreateRestore").Add_Click({
    Start-Process powershell -ArgumentList "-NoProfile", "-Command", "Write-Host 'Inizializzazione Punto di Ripristino...' -ForegroundColor Cyan; Checkpoint-Computer -Description 'QuantumSuite_v7_Point' -RestorePointType 'MODIFY_SETTINGS'; Write-Host 'Operazione conclusa con successo!' -ForegroundColor Green; Start-Sleep -Seconds 2"
})

# 2. Iniezione Pacchetti WinGet
$Window.FindName("BtnRunInstall").Add_Click({
    $Apps = @()
    if ($Window.FindName("ChkChrome").IsChecked)    { $Apps += "Google.Chrome" }
    if ($Window.FindName("ChkBrave").IsChecked)     { $Apps += "Brave.Brave" }
    if ($Window.FindName("ChkFirefox").IsChecked)   { $Apps += "Mozilla.Firefox" }
    if ($Window.FindName("ChkVSCode").IsChecked)    { $Apps += "Microsoft.VisualStudioCode" }
    if ($Window.FindName("ChkGit").IsChecked)       { $Apps += "Git.Git" }
    if ($Window.FindName("ChkPython").IsChecked)    { $Apps += "Python.Python.3.12" }
    if ($Window.FindName("Chk7Zip").IsChecked)      { $Apps += "7zip.7zip" }
    if ($Window.FindName("ChkPowerToys").IsChecked) { $Apps += "Microsoft.PowerToys" }
    if ($Window.FindName("ChkVLC").IsChecked)       { $Apps += "VideoLAN.VLC" }

    if ($Apps.Count -eq 0) { [System.Windows.MessageBox]::Show("Attenzione: seleziona almeno un pacchetto software da installare!", "Avviso", 0, 48); return }

    $Cmd = "Write-Host '--- SYSTEM SUITE DEPLOYMENT ACTIVE ---' -ForegroundColor Cyan;"
    foreach ($ID in $Apps) { $Cmd += "Write-Host 'Scaricamento in corso: $ID...' -ForegroundColor Yellow; winget install --id $ID --silent --accept-package-agreements --accept-source-agreements;" }
    $Cmd += "Write-Host 'Processo terminato!' -ForegroundColor Green; Pause"
    Start-Process powershell -ArgumentList "-NoProfile", "-Command", $Cmd
})

# 3. Upgrade Globale
$Window.FindName("BtnRunUpdates").Add_Click({ 
    Start-Process powershell -ArgumentList "-NoProfile", "-Command", "Write-Host 'Controllo aggiornamenti software globali...' -ForegroundColor Cyan; winget upgrade --all --include-unknown --silent; Pause" 
})

# 4. Iniezione Registri Tweaks
$Window.FindName("BtnApplyTweaks").Add_Click({
    if ($Window.FindName("ChkTweakTelemetry").IsChecked) { Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakBing").IsChecked) { New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1 -Type DWord -Force -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakGameMode").IsChecked) { Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 1 -Type DWord -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakFastStartup").IsChecked) { Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Type DWord -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakHibernate").IsChecked) { powercfg.exe /hibernate off }
    
    [System.Windows.MessageBox]::Show("Configurazioni scritte nel registro correttamente!", "Operazione Completata", 0, 64)
})

# 5. Moduli di Manutenzione
$Window.FindName("BtnFixSFC").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "sfc /scannow; dism /online /cleanup-image /restorehealth; Pause" })
$Window.FindName("BtnFixTemp").Add_Click({ Remove-Item "$env:windir\Temp\*" -Recurse -Force -EA SilentlyContinue; Remove-Item "$env:TEMP\*" -Recurse -Force -EA SilentlyContinue; [System.Windows.MessageBox]::Show("File temporanei d'ambiente eliminati!", "Pulizia Cache", 0, 64) })
$Window.FindName("BtnResetUpdate").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "net stop wuauserv; net stop bits; ren C:\Windows\SoftwareDistribution SoftwareDistribution.old; net start wuauserv; net start bits; Pause" })
$Window.FindName("BtnDNSCloudflare").Add_Click({
    $Interface = Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object -First 1
    if ($Interface) {
        Set-DnsClientServerAddress -InterfaceIndex $Interface.ifIndex -ServerAddresses ("1.1.1.1","1.0.0.1")
        ipconfig /flushdns
        [System.Windows.MessageBox]::Show("Configurazione DNS Cloudflare iniettata!", "Network", 0, 64)
    }
})
$Window.FindName("BtnDebloat").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "Get-AppxPackage -AllUsers | Where-Object {`$_.Name -match 'Bing|Zune|Solitaire|3DBuilder|SkypeApp'} | Remove-AppxPackage -AllUsers; Pause" })

$Window.ShowDialog() | Out-Null
