# =========================================================
# SYSTEM SUITE PRO - v3.0 ULTIMATE
# =========================================================
Clear-Host
Write-Host " =================================================== " -ForegroundColor Cyan
Write-Host " |                                                 | " -ForegroundColor Cyan
Write-Host " |      SYSTEM SUITE PRO - INIZIALIZZAZIONE        | " -ForegroundColor White -BackgroundColor DarkCyan
Write-Host " |                                                 | " -ForegroundColor Cyan
Write-Host " =================================================== " -ForegroundColor Cyan
Write-Host "`n"

# Verifica Privilegi
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "ERRORE: Devi eseguire questo script come Amministratore!" -ForegroundColor Red
    Start-Sleep -Seconds 3
    exit
}

Write-Host "Caricamento dell'interfaccia grafica..." -ForegroundColor Yellow
Add-Type -AssemblyName PresentationFramework

# =========================================================
# INTERFACCIA GRAFICA (XAML)
# =========================================================
[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="System Suite Ultimate" Height="700" Width="1050" 
        WindowStartupLocation="CenterScreen" Background="#FF0B1120" Foreground="White">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="70"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>

        <!-- TOP NAVBAR -->
        <Border Grid.Row="0" Background="#FF1E293B" BorderBrush="#FF38BDF8" BorderThickness="0,0,0,2">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>
                <StackPanel Grid.Column="0" Orientation="Horizontal" Margin="20,0,0,0" VerticalAlignment="Center">
                    <TextBlock Text="⚙️ SYSTEM" FontSize="24" FontWeight="Black" Foreground="#FF38BDF8"/>
                    <TextBlock Text="SUITE" FontSize="24" FontWeight="Black" Foreground="White" Margin="8,0,0,0"/>
                </StackPanel>
                <StackPanel Grid.Column="1" Orientation="Horizontal" HorizontalAlignment="Right" Margin="0,0,20,0">
                    <Button Name="NavInstall" Content="📦 Software Hub" Height="40" Width="140" Background="#FF334155" Foreground="White" BorderThickness="0" Cursor="Hand" Margin="5,0" FontWeight="Bold"/>
                    <Button Name="NavTweaks" Content="🚀 Tweaks" Height="40" Width="140" Background="Transparent" Foreground="White" BorderThickness="0" Cursor="Hand" Margin="5,0" FontWeight="Bold"/>
                    <Button Name="NavFixes" Content="🧹 Fix &amp; Pulizia" Height="40" Width="140" Background="Transparent" Foreground="White" BorderThickness="0" Cursor="Hand" Margin="5,0" FontWeight="Bold"/>
                </StackPanel>
            </Grid>
        </Border>

        <!-- AREA CONTENUTI -->
        <Grid Grid.Row="1" Margin="30">
            
            <!-- PANNELLO 1: SOFTWARE HUB -->
            <Grid Name="PanelInstall" Visibility="Visible">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>
                
                <StackPanel Grid.Row="0" Margin="0,0,0,15" Orientation="Horizontal">
                    <StackPanel Width="600">
                        <TextBlock Text="Installa Software Ufficiali" FontSize="22" FontWeight="Bold" Foreground="#FF38BDF8"/>
                        <TextBlock Text="Seleziona i programmi. L'installazione avverrà silenziosamente in background." FontSize="14" Foreground="#FF94A3B8"/>
                    </StackPanel>
                    <Button Name="BtnSelectAll" Content="Seleziona Tutto" Width="120" Height="30" Background="#FF334155" Foreground="White" BorderThickness="0" Cursor="Hand" Margin="10,0"/>
                    <Button Name="BtnClearAll" Content="Deseleziona Tutto" Width="120" Height="30" Background="#FF334155" Foreground="White" BorderThickness="0" Cursor="Hand"/>
                </StackPanel>
                
                <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                    <WrapPanel Orientation="Horizontal" Name="CheckboxContainer">
                        <GroupBox Header="Browser &amp; Rete" Width="220" Margin="5" Foreground="#FF38BDF8" BorderBrush="#FF334155">
                            <StackPanel Margin="10">
                                <CheckBox Name="ChkChrome" Content="Google Chrome" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkBrave" Content="Brave Browser" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkFirefox" Content="Mozilla Firefox" Foreground="White" Margin="0,5"/>
                            </StackPanel>
                        </GroupBox>
                        <GroupBox Header="Media &amp; Utility" Width="220" Margin="5" Foreground="#FF38BDF8" BorderBrush="#FF334155">
                            <StackPanel Margin="10">
                                <CheckBox Name="ChkVLC" Content="VLC Player" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkOBS" Content="OBS Studio" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkSpotify" Content="Spotify" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkEverything" Content="Everything (Ricerca)" Foreground="White" Margin="0,5"/>
                            </StackPanel>
                        </GroupBox>
                        <GroupBox Header="Strumenti" Width="220" Margin="5" Foreground="#FF38BDF8" BorderBrush="#FF334155">
                            <StackPanel Margin="10">
                                <CheckBox Name="Chk7Zip" Content="7-Zip" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkWinrar" Content="WinRAR" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkRufus" Content="Rufus" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkPowerToys" Content="MS PowerToys" Foreground="White" Margin="0,5"/>
                            </StackPanel>
                        </GroupBox>
                        <GroupBox Header="Comunicazione" Width="220" Margin="5" Foreground="#FF38BDF8" BorderBrush="#FF334155">
                            <StackPanel Margin="10">
                                <CheckBox Name="ChkDiscord" Content="Discord" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkTelegram" Content="Telegram" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkTeams" Content="MS Teams" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkSlack" Content="Slack" Foreground="White" Margin="0,5"/>
                            </StackPanel>
                        </GroupBox>
                        <GroupBox Header="Sviluppo &amp; Gaming" Width="220" Margin="5" Foreground="#FF38BDF8" BorderBrush="#FF334155">
                            <StackPanel Margin="10">
                                <CheckBox Name="ChkSteam" Content="Steam" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkEpic" Content="Epic Games" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkVSCode" Content="VS Code" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkPython" Content="Python 3" Foreground="White" Margin="0,5"/>
                            </StackPanel>
                        </GroupBox>
                    </WrapPanel>
                </ScrollViewer>
                
                <Grid Grid.Row="2" Margin="0,15,0,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    <Button Name="BtnRunUpdates" Grid.Column="0" Content="🔄 Aggiorna tutte le App del PC" Height="45" Background="#FF1E293B" Foreground="#FF38BDF8" FontWeight="Bold" FontSize="14" BorderThickness="1" BorderBrush="#FF38BDF8" Cursor="Hand" Margin="0,0,10,0"/>
                    <Button Name="BtnRunInstall" Grid.Column="1" Content="🚀 INSTALLA SELEZIONATI" Height="45" Width="250" Background="#FF38BDF8" Foreground="#FF0B1120" FontWeight="Black" FontSize="15" BorderThickness="0" Cursor="Hand"/>
                </Grid>
            </Grid>

            <!-- PANNELLO 2: TWEAKS -->
            <Grid Name="PanelTweaks" Visibility="Collapsed">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>
                
                <StackPanel Grid.Row="0" Margin="0,0,0,20">
                    <TextBlock Text="Ottimizzazione Sistema" FontSize="22" FontWeight="Bold" Foreground="#FF38BDF8"/>
                    <TextBlock Text="Applica modifiche profonde per velocizzare Windows e migliorare la privacy." FontSize="14" Foreground="#FF94A3B8"/>
                </StackPanel>
                
                <StackPanel Grid.Row="1" Margin="10">
                    <CheckBox Name="ChkTweakTelemetry" Content="Disabilita Telemetria (Blocca invio dati a Microsoft)" Foreground="White" FontSize="15" Margin="0,10"/>
                    <CheckBox Name="ChkTweakHibernate" Content="Disabilita Ibernazione (Libera GB di spazio su disco C:)" Foreground="White" FontSize="15" Margin="0,10"/>
                    <CheckBox Name="ChkTweakFastStartup" Content="Disabilita Avvio Rapido (Previene bug di avvio e BSOD)" Foreground="White" FontSize="15" Margin="0,10"/>
                    <CheckBox Name="ChkTweakExtensions" Content="Mostra sempre le estensioni dei file (Es: .exe, .pdf) - Sicurezza" Foreground="White" FontSize="15" Margin="0,10"/>
                    <CheckBox Name="ChkTweakHiddenFiles" Content="Mostra file e cartelle nascoste di sistema" Foreground="White" FontSize="15" Margin="0,10"/>
                    <CheckBox Name="ChkTweakDarkMode" Content="Forza Tema Scuro di Windows e App" Foreground="White" FontSize="15" Margin="0,10"/>
                </StackPanel>
                
                <Button Name="BtnRunTweaks" Grid.Row="2" Content="🛠️ APPLICA TWEAKS" Height="50" Background="#FF8B5CF6" Foreground="White" FontWeight="Black" FontSize="16" BorderThickness="0" Cursor="Hand"/>
            </Grid>

            <!-- PANNELLO 3: FIXES & PULIZIA -->
            <Grid Name="PanelFixes" Visibility="Collapsed">
                <StackPanel Margin="0,0,0,20">
                    <TextBlock Text="Manutenzione Avanzata" FontSize="22" FontWeight="Bold" Foreground="#FF38BDF8"/>
                    <TextBlock Text="Risolvi problemi comuni del sistema operativo." FontSize="14" Foreground="#FF94A3B8"/>
                </StackPanel>
                
                <Grid Margin="0,70,0,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <Button Name="BtnFixSFC" Grid.Column="0" Grid.Row="0" Content="🔧 Ripara Windows (SFC/DISM)&#x0a;Risolve file corrotti e crash" Margin="10" Height="90" Background="#FF1E293B" Foreground="White" BorderBrush="#FF334155" FontSize="15" Cursor="Hand"/>
                    <Button Name="BtnFixTemp" Grid.Column="1" Grid.Row="0" Content="🗑️ Svuota Cache &amp; File Temp&#x0a;Libera spazio sprecato" Margin="10" Height="90" Background="#FF1E293B" Foreground="White" BorderBrush="#FF334155" FontSize="15" Cursor="Hand"/>
                    <Button Name="BtnFixDNS" Grid.Column="0" Grid.Row="1" Content="🌐 Reset Rete &amp; DNS&#x0a;Usa se internet ha problemi" Margin="10" Height="90" Background="#FF1E293B" Foreground="White" BorderBrush="#FF334155" FontSize="15" Cursor="Hand"/>
                    <Button Name="BtnFixUpdate" Grid.Column="1" Grid.Row="1" Content="🔄 Reset Windows Update&#x0a;Sblocca gli aggiornamenti bloccati" Margin="10" Height="90" Background="#FF1E293B" Foreground="White" BorderBrush="#FF334155" FontSize="15" Cursor="Hand"/>
                </Grid>
            </Grid>

        </Grid>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$Window = [Windows.Markup.XamlReader]::Load($reader)

# Elementi
$PanelInstall = $Window.FindName("PanelInstall"); $PanelTweaks = $Window.FindName("PanelTweaks"); $PanelFixes = $Window.FindName("PanelFixes")
$NavInstall = $Window.FindName("NavInstall"); $NavTweaks = $Window.FindName("NavTweaks"); $NavFixes = $Window.FindName("NavFixes")

# Navigazione
function Set-ActivePanel ($Panel, $Btn) {
    $PanelInstall.Visibility = "Collapsed"; $PanelTweaks.Visibility = "Collapsed"; $PanelFixes.Visibility = "Collapsed"
    $Panel.Visibility = "Visible"
    $NavInstall.Background = "Transparent"; $NavTweaks.Background = "Transparent"; $NavFixes.Background = "Transparent"
    $Btn.Background = "#FF334155"
}
$NavInstall.Add_Click({ Set-ActivePanel $PanelInstall $NavInstall })
$NavTweaks.Add_Click({ Set-ActivePanel $PanelTweaks $NavTweaks })
$NavFixes.Add_Click({ Set-ActivePanel $PanelFixes $NavFixes })

# Lista di tutte le checkbox
$AllCheckBoxes = @("ChkChrome","ChkBrave","ChkFirefox","Chk7Zip","ChkWinrar","ChkRufus","ChkPowerToys","ChkVLC","ChkOBS","ChkSpotify","ChkEverything","ChkDiscord","ChkTelegram","ChkTeams","ChkSlack","ChkSteam","ChkEpic","ChkVSCode","ChkPython")

# Tasti Seleziona Tutto / Deseleziona
$Window.FindName("BtnSelectAll").Add_Click({ foreach($chk in $AllCheckBoxes){ $Window.FindName($chk).IsChecked = $true } })
$Window.FindName("BtnClearAll").Add_Click({ foreach($chk in $AllCheckBoxes){ $Window.FindName($chk).IsChecked = $false } })

# Installazione
$Window.FindName("BtnRunInstall").Add_Click({
    $Apps = @()
    if ($Window.FindName("ChkChrome").IsChecked)  { $Apps += "Google.Chrome" }
    if ($Window.FindName("ChkBrave").IsChecked)   { $Apps += "Brave.Brave" }
    if ($Window.FindName("ChkFirefox").IsChecked) { $Apps += "Mozilla.Firefox" }
    if ($Window.FindName("Chk7Zip").IsChecked)    { $Apps += "7zip.7zip" }
    if ($Window.FindName("ChkWinrar").IsChecked)  { $Apps += "RARLab.WinRAR" }
    if ($Window.FindName("ChkRufus").IsChecked)   { $Apps += "Rufus.Rufus" }
    if ($Window.FindName("ChkPowerToys").IsChecked){ $Apps += "Microsoft.PowerToys" }
    if ($Window.FindName("ChkVLC").IsChecked)     { $Apps += "VideoLAN.VLC" }
    if ($Window.FindName("ChkOBS").IsChecked)     { $Apps += "OBSProject.OBSStudio" }
    if ($Window.FindName("ChkSpotify").IsChecked) { $Apps += "Spotify.Spotify" }
    if ($Window.FindName("ChkEverything").IsChecked){ $Apps += "voidtools.Everything" }
    if ($Window.FindName("ChkDiscord").IsChecked) { $Apps += "Discord.Discord" }
    if ($Window.FindName("ChkTelegram").IsChecked){ $Apps += "Telegram.TelegramDesktop" }
    if ($Window.FindName("ChkTeams").IsChecked)   { $Apps += "Microsoft.Teams" }
    if ($Window.FindName("ChkSlack").IsChecked)   { $Apps += "SlackTechnologies.Slack" }
    if ($Window.FindName("ChkSteam").IsChecked)   { $Apps += "Valve.Steam" }
    if ($Window.FindName("ChkEpic").IsChecked)    { $Apps += "EpicGames.EpicGamesLauncher" }
    if ($Window.FindName("ChkVSCode").IsChecked)  { $Apps += "Microsoft.VisualStudioCode" }
    if ($Window.FindName("ChkPython").IsChecked)  { $Apps += "Python.Python.3.11" }

    if ($Apps.Count -eq 0) { [System.Windows.MessageBox]::Show("Seleziona un'app!", "Attenzione", 0, 48); return }

    $Cmd = "Write-Host '--- INIZIO INSTALLAZIONE ---' -ForegroundColor Cyan;"
    foreach ($ID in $Apps) { $Cmd += "Write-Host 'Installazione $ID...' -ForegroundColor Yellow; winget install --id $ID --silent --accept-package-agreements --accept-source-agreements;" }
    $Cmd += "Write-Host 'Finito!' -ForegroundColor Green; Pause"
    Start-Process powershell -ArgumentList "-NoProfile", "-Command", $Cmd
})

# Aggiornamenti
$Window.FindName("BtnRunUpdates").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "Write-Host 'Cerco aggiornamenti...' -ForegroundColor Cyan; winget upgrade --all --include-unknown --silent; Pause" })

# Tweaks
$Window.FindName("BtnRunTweaks").Add_Click({
    if ($Window.FindName("ChkTweakTelemetry").IsChecked) { Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -ErrorAction SilentlyContinue }
    if ($Window.FindName("ChkTweakHibernate").IsChecked) { powercfg.exe /hibernate off }
    if ($Window.FindName("ChkTweakFastStartup").IsChecked) { Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue }
    if ($Window.FindName("ChkTweakExtensions").IsChecked) { Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Type DWord }
    if ($Window.FindName("ChkTweakHiddenFiles").IsChecked) { Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -Type DWord }
    if ($Window.FindName("ChkTweakDarkMode").IsChecked) { 
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -Type DWord -ErrorAction SilentlyContinue
    }
    Stop-Process -Name explorer -Force
    [System.Windows.MessageBox]::Show("Tweaks applicati! Explorer riavviato per mostrare i cambiamenti.", "Fatto", 0, 64)
})

# Fixes
$Window.FindName("BtnFixSFC").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "sfc /scannow; dism /online /cleanup-image /restorehealth; Pause" })
$Window.FindName("BtnFixTemp").Add_Click({ Remove-Item "$env:windir\Temp\*" -Recurse -Force -EA SilentlyContinue; Remove-Item "$env:TEMP\*" -Recurse -Force -EA SilentlyContinue; [System.Windows.MessageBox]::Show("Cache svuotata!", "Fatto", 0, 64) })
$Window.FindName("BtnFixDNS").Add_Click({ ipconfig /flushdns; netsh int ip reset; [System.Windows.MessageBox]::Show("Rete ripristinata! Riavvia il PC.", "Fatto", 0, 64) })
$Window.FindName("BtnFixUpdate").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "net stop wuauserv; net stop cryptSvc; net stop bits; net stop msiserver; ren C:\Windows\SoftwareDistribution SoftwareDistribution.old; net start wuauserv; net start cryptSvc; net start bits; net start msiserver; Write-Host 'Windows Update Ripristinato!' -ForegroundColor Green; Pause" })

$Window.ShowDialog() | Out-Null
