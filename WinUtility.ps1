# =========================================================
# SYSTEM SUITE - v6.0 ULTIMATE EDITION (HOTFIXED)
# =========================================================
Clear-Host
Write-Host "Raccolta informazioni hardware in corso..." -ForegroundColor Cyan

# Verifica Privilegi di Amministratore
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "ERRORE: Esegui PowerShell come Amministratore!" -ForegroundColor Red
    Start-Sleep -Seconds 3
    exit
}

# Raccolta Dati Hardware Reali per la Dashboard
$OSInfo = (Get-CimInstance Win32_OperatingSystem).Caption
$CPUInfo = (Get-CimInstance Win32_Processor).Name
$RAMRaw = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum
$RAMInfo = "$([Math]::Round($RAMRaw / 1GB)) GB RAM"

Add-Type -AssemblyName PresentationFramework

# =========================================================
# INTERFACCIA GRAFICA (XAML) - VERTICAL SIDEBAR LAYOUT
# =========================================================
[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="System Suite Ultimate v6.0" Height="820" Width="1200" 
        WindowStartupLocation="CenterScreen" Background="#FF0F172A" Foreground="White" FontFamily="Segoe UI">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="80"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>

        <Border Grid.Row="0" Background="#FF020617" BorderBrush="#FF38BDF8" BorderThickness="0,0,0,2" Padding="20,10">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>
                <StackPanel Grid.Column="0" Orientation="Horizontal" VerticalAlignment="Center">
                    <TextBlock Text="⚡ SYSTEM" FontSize="28" FontWeight="Black" Foreground="#FF38BDF8"/>
                    <TextBlock Text="SUITE" FontSize="28" FontWeight="Black" Foreground="White" Margin="8,0,0,0"/>
                    <Border Background="#FF0369A1" CornerRadius="4" Margin="15,0,0,0" Padding="6,2">
                        <TextBlock Text="v6.0 ULTIMATE" FontSize="11" FontWeight="Bold" Foreground="White"/>
                    </Border>
                </StackPanel>
                <TextBlock Grid.Column="1" Text="Enterprise System Deployment Infrastructure" FontSize="14" Foreground="#FF64748B" HorizontalAlignment="Right" VerticalAlignment="Center"/>
            </Grid>
        </Border>

        <TabControl Grid.Row="1" TabStripPlacement="Left" Background="Transparent" BorderThickness="0" Margin="0" Foreground="White">
            
            <TabItem Header="🖥️ Dashboard" FontSize="16" Height="50" Width="180" Margin="0,2">
                <Grid Background="#FF0F172A" Margin="30">
                    <StackPanel>
                        <TextBlock Text="Stato del Sistema" FontSize="24" FontWeight="Bold" Foreground="#FF38BDF8" Margin="0,0,0,20"/>
                        
                        <Grid Margin="0,10">
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="150"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>
                            <TextBlock Text="Sistema Operativo:" FontSize="16" Foreground="#FF64748B" Grid.Column="0"/>
                            <TextBlock Text="$OSInfo" FontSize="16" FontWeight="Bold" Foreground="White" Grid.Column="1"/>
                        </Grid>
                        
                        <Grid Margin="0,10">
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="150"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>
                            <TextBlock Text="Processore CPU:" FontSize="16" Foreground="#FF64748B" Grid.Column="0"/>
                            <TextBlock Text="$CPUInfo" FontSize="16" FontWeight="Bold" Foreground="White" Grid.Column="1"/>
                        </Grid>

                        <Grid Margin="0,10">
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="150"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>
                            <TextBlock Text="Memoria RAM:" FontSize="16" Foreground="#FF64748B" Grid.Column="0"/>
                            <TextBlock Text="$RAMInfo" FontSize="16" FontWeight="Bold" Foreground="White" Grid.Column="1"/>
                        </Grid>
                        
                        <Border Background="#FF1E293B" CornerRadius="8" Padding="20" Margin="0,30,0,0">
                            <StackPanel>
                                <TextBlock Text="🛡️ Sicurezza Pre-Configurazione" FontSize="18" FontWeight="Bold" Margin="0,0,0,10"/>
                                <TextBlock Text="Si consiglia di creare un punto di ripristino prima di applicare modifiche massive al registro di sistema." FontSize="14" Foreground="#FF94A3B8" Margin="0,0,0,15" TextWrapping="Wrap"/>
                                <Button Name="BtnCreateRestore" Content="🛡️ Crea Punto di Ripristino del Sistema" Height="40" Background="#FF020617" Foreground="#FF38BDF8" BorderBrush="#FF38BDF8" BorderThickness="1" FontWeight="Bold" Cursor="Hand"/>
                            </StackPanel>
                        </Border>
                    </StackPanel>
                </Grid>
            </TabItem>
            
            <TabItem Header="📦 Software Hub" FontSize="16" Height="50" Width="180" Margin="0,2">
                <Grid Background="#FF0F172A" Margin="30">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    
                    <TextBlock Grid.Row="0" Text="Installazione Silenziosa App" FontSize="24" FontWeight="Bold" Foreground="#FF38BDF8" Margin="0,0,0,15"/>
                    
                    <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                        <WrapPanel Orientation="Horizontal">
                            <GroupBox Header="Standard Suite" Width="260" Margin="10" Foreground="#FF38BDF8" BorderBrush="#FF334155" Padding="10">
                                <StackPanel>
                                    <CheckBox Name="ChkChrome" Content="Google Chrome" Foreground="White" Margin="0,6"/>
                                    <CheckBox Name="ChkBrave" Content="Brave Browser" Foreground="White" Margin="0,6"/>
                                    <CheckBox Name="ChkFirefox" Content="Mozilla Firefox" Foreground="White" Margin="0,6"/>
                                    <CheckBox Name="Chk7Zip" Content="7-Zip Utility" Foreground="White" Margin="0,6"/>
                                </StackPanel>
                            </GroupBox>
                            <GroupBox Header="Dev &amp; Engineering" Width="260" Margin="10" Foreground="#FF38BDF8" BorderBrush="#FF334155" Padding="10">
                                <StackPanel>
                                    <CheckBox Name="ChkVSCode" Content="Visual Studio Code" Foreground="White" Margin="0,6"/>
                                    <CheckBox Name="ChkGit" Content="Git SCM" Foreground="White" Margin="0,6"/>
                                    <CheckBox Name="ChkPython" Content="Python Runtime" Foreground="White" Margin="0,6"/>
                                    <CheckBox Name="ChkPowerToys" Content="MS PowerToys" Foreground="White" Margin="0,6"/>
                                </StackPanel>
                            </GroupBox>
                            <GroupBox Header="Gaming &amp; Media" Width="260" Margin="10" Foreground="#FF38BDF8" BorderBrush="#FF334155" Padding="10">
                                <StackPanel>
                                    <CheckBox Name="ChkSteam" Content="Steam Client" Foreground="White" Margin="0,6"/>
                                    <CheckBox Name="ChkDiscord" Content="Discord" Foreground="White" Margin="0,6"/>
                                    <CheckBox Name="ChkVLC" Content="VLC Media Player" Foreground="White" Margin="0,6"/>
                                    <CheckBox Name="ChkOBS" Content="OBS Studio" Foreground="White" Margin="0,6"/>
                                </StackPanel>
                            </GroupBox>
                        </WrapPanel>
                    </ScrollViewer>
                    
                    <Grid Grid.Row="2" Margin="0,20,0,0">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="Auto"/>
                        </Grid.ColumnDefinitions>
                        <Button Name="BtnRunUpdates" Grid.Column="0" Content="🔄 Aggiorna Software Esistente" Height="45" Background="#FF1E293B" Foreground="#FF38BDF8" BorderBrush="#FF38BDF8" FontWeight="Bold" Margin="0,0,15,0" Cursor="Hand"/>
                        <Button Name="BtnRunInstall" Grid.Column="1" Content="🚀 DEPLOY SOFTWARE" Height="45" Width="250" Background="#FF38BDF8" Foreground="#FF020617" FontWeight="Black" BorderThickness="0" Cursor="Hand"/>
                    </Grid>
                </Grid>
            </TabItem>

            <TabItem Header="🚀 Ottimizzazioni" FontSize="16" Height="50" Width="180" Margin="0,2">
                <Grid Background="#FF0F172A" Margin="30">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    
                    <ScrollViewer Grid.Row="0">
                        <StackPanel>
                            <TextBlock Text="Modifiche del Registro di Sistema" FontSize="24" FontWeight="Bold" Foreground="#FF38BDF8" Margin="0,0,0,20"/>
                            
                            <Border Background="#FF1E293B" CornerRadius="6" Padding="15" Margin="0,0,0,15">
                                <StackPanel>
                                    <TextBlock Text="Privacy Avanzata" FontWeight="Bold" FontSize="16" Margin="0,0,0,10"/>
                                    <CheckBox Name="ChkTweakTelemetry" Content="Sradica la Telemetria e i Log di Diagnostica Microsoft" Foreground="#FFCBD5E1" Margin="0,5"/>
                                    <CheckBox Name="ChkTweakBing" Content="Disattiva i suggerimenti web di Bing nel Menu Start" Foreground="#FFCBD5E1" Margin="0,5"/>
                                </StackPanel>
                            </Border>

                            <Border Background="#FF1E293B" CornerRadius="6" Padding="15" Margin="0,0,0,15">
                                <StackPanel>
                                    <TextBlock Text="Gaming &amp; Performance" FontWeight="Bold" FontSize="16" Margin="0,0,0,10"/>
                                    <CheckBox Name="ChkTweakGameMode" Content="Forza Windows Game Mode (Priorità CPU ai Giochi)" Foreground="#FFCBD5E1" Margin="0,5"/>
                                    <CheckBox Name="ChkTweakFastStartup" Content="Disattiva Avvio Rapido (Evita accumulo instabilità RAM)" Foreground="#FFCBD5E1" Margin="0,5"/>
                                    <CheckBox Name="ChkTweakHibernate" Content="Elimina file di Ibernazione (Svuota spazio prezioso su C:)" Foreground="#FFCBD5E1" Margin="0,5"/>
                                </StackPanel>
                            </Border>
                        </StackPanel>
                    </ScrollViewer>
                    
                    <Button Name="BtnApplyTweaks" Grid.Row="1" Content="⚡ APPLICA SELEZIONATI" Height="45" Background="#FF10B981" Foreground="White" FontWeight="Black" BorderThickness="0" Cursor="Hand"/>
                </Grid>
            </TabItem>

            <TabItem Header="🧹 Manutenzione" FontSize="16" Height="50" Width="180" Margin="0,2">
                <Grid Background="#FF0F172A" Margin="30">
                    <StackPanel>
                        <TextBlock Text="Riparazione e Pulizia Rete" FontSize="24" FontWeight="Bold" Foreground="#FF38BDF8" Margin="0,0,0,20"/>
                        <WrapPanel Orientation="Horizontal">
                            <Button Name="BtnFixSFC" Content="🔧 Ripara Windows (SFC / DISM)" Width="310" Height="70" Background="#FF1E293B" Foreground="White" Margin="10" Cursor="Hand"/>
                            <Button Name="BtnFixTemp" Content="🗑️ Svuota Cache e File Temporanei" Width="310" Height="70" Background="#FF1E293B" Foreground="White" Margin="10" Cursor="Hand"/>
                            <Button Name="BtnResetUpdate" Content="🔄 Ripristina Windows Update Corrotto" Width="310" Height="70" Background="#FF1E293B" Foreground="White" Margin="10" Cursor="Hand"/>
                            <Button Name="BtnDNSCloudflare" Content="🌐 Forza DNS Veloci (Cloudflare 1.1.1.1)" Width="310" Height="70" Background="#FF1E293B" Foreground="#FF38BDF8" Margin="10" Cursor="Hand"/>
                            <Button Name="BtnDebloat" Content="🔥 RIMOZIONE AGGRESSIVA BLOATWARE (App di Fabbrica)" Width="640" Height="70" Background="#FF991B1B" Foreground="White" FontWeight="Bold" Margin="10" BorderThickness="0" Cursor="Hand"/>
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

# --- LOGICA OPERATIVA ---

# Tasto Punto di Ripristino
$Window.FindName("BtnCreateRestore").Add_Click({
    Start-Process powershell -ArgumentList "-NoProfile", "-Command", "Write-Host 'Creazione Punto di Ripristino del Sistema... Potrebbe richiedere un minuto.' -ForegroundColor Cyan; Checkpoint-Computer -Description 'SystemSuite_v6_Backup' -RestorePointType 'MODIFY_SETTINGS'; Write-Host 'Fatto!' -ForegroundColor Green; Start-Sleep -Seconds 2"
})

# Installazione Software
$Window.FindName("BtnRunInstall").Add_Click({
    $Apps = @()
    if ($Window.FindName("ChkChrome").IsChecked)  { $Apps += "Google.Chrome" }
    if ($Window.FindName("ChkBrave").IsChecked)   { $Apps += "Brave.Brave" }
    if ($Window.FindName("ChkFirefox").IsChecked) { $Apps += "Mozilla.Firefox" }
    if ($Window.FindName("Chk7Zip").IsChecked)    { $Apps += "7zip.7zip" }
    if ($Window.FindName("ChkVSCode").IsChecked)  { $Apps += "Microsoft.VisualStudioCode" }
    if ($Window.FindName("ChkGit").IsChecked)     { $Apps += "Git.Git" }
    if ($Window.FindName("ChkPython").IsChecked)  { $Apps += "Python.Python.3.12" }
    if ($Window.FindName("ChkPowerToys").IsChecked){ $Apps += "Microsoft.PowerToys" }
    if ($Window.FindName("ChkSteam").IsChecked)   { $Apps += "Valve.Steam" }
    if ($Window.FindName("ChkDiscord").IsChecked) { $Apps += "Discord.Discord" }
    if ($Window.FindName("ChkVLC").IsChecked)     { $Apps += "VideoLAN.VLC" }
    if ($Window.FindName("ChkOBS").IsChecked)     { $Apps += "OBSProject.OBSStudio" }

    if ($Apps.Count -eq 0) { [System.Windows.MessageBox]::Show("Seleziona i pacchetti software da installare!", "Avviso", 0, 48); return }

    $Cmd = "Write-Host '--- SYSTEM SUITE DEPLOYMENT CORE ---' -ForegroundColor Cyan;"
    foreach ($ID in $Apps) { $Cmd += "Write-Host 'Scaricamento e installazione: $ID...' -ForegroundColor Yellow; winget install --id $ID --silent --accept-package-agreements --accept-source-agreements;" }
    $Cmd += "Write-Host 'Operazione conclusa!' -ForegroundColor Green; Pause"
    Start-Process powershell -ArgumentList "-NoProfile", "-Command", $Cmd
})

# Aggiornamenti
$Window.FindName("BtnRunUpdates").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "Write-Host 'Aggiornamento dei pacchetti orfani...' -ForegroundColor Cyan; winget upgrade --all --include-unknown --silent; Pause" })

# Tweaks Registro
$Window.FindName("BtnApplyTweaks").Add_Click({
    if ($Window.FindName("ChkTweakTelemetry").IsChecked) { Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakBing").IsChecked) { New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1 -Type DWord -Force -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakGameMode").IsChecked) { Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 1 -Type DWord -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakFastStartup").IsChecked) { Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Type DWord -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakHibernate").IsChecked) { powercfg.exe /hibernate off }
    
    [System.Windows.MessageBox]::Show("Configurazioni applicate correttamente!", "Operazione Completata", 0, 64)
})

# Manutenzione
$Window.FindName("BtnFixSFC").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "sfc /scannow; dism /online /cleanup-image /restorehealth; Pause" })
$Window.FindName("BtnFixTemp").Add_Click({ Remove-Item "$env:windir\Temp\*" -Recurse -Force -EA SilentlyContinue; Remove-Item "$env:TEMP\*" -Recurse -Force -EA SilentlyContinue; [System.Windows.MessageBox]::Show("Cache svuotata!", "Manutenzione", 0, 64) })
$Window.FindName("BtnResetUpdate").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "net stop wuauserv; net stop bits; ren C:\Windows\SoftwareDistribution SoftwareDistribution.old; net start wuauserv; net start bits; Pause" })
$Window.FindName("BtnDNSCloudflare").Add_Click({
    $Interface = Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object -First 1
    if ($Interface) {
        Set-DnsClientServerAddress -InterfaceIndex $Interface.ifIndex -ServerAddresses ("1.1.1.1","1.0.0.1")
        ipconfig /flushdns
        [System.Windows.MessageBox]::Show("DNS aggiornati a Cloudflare Security!", "Rete", 0, 64)
    }
})
$Window.FindName("BtnDebloat").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "Get-AppxPackage -AllUsers | Where-Object {`$_.Name -match 'Bing|Zune|Solitaire|3DBuilder|SkypeApp'} | Remove-AppxPackage -AllUsers; Pause" })

$Window.ShowDialog() | Out-Null
