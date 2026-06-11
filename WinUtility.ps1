# =========================================================
# SYSTEM SUITE - v4.0 ELITE EDITION
# =========================================================
Clear-Host
Write-Host "Inizializzazione System Suite 4.0..." -ForegroundColor Cyan

# Verifica Privilegi di Amministratore
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "ERRORE: Riavvia PowerShell come Amministratore!" -ForegroundColor Red
    Start-Sleep -Seconds 3
    exit
}

Add-Type -AssemblyName PresentationFramework

# =========================================================
# INTERFACCIA GRAFICA (XAML)
# =========================================================
[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="System Suite Elite v4.0" Height="780" Width="1100" 
        WindowStartupLocation="CenterScreen" Background="#FF090D14" Foreground="White" FontFamily="Segoe UI">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="80"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>

        <!-- TOP NAVBAR -->
        <Border Grid.Row="0" Background="#FF111827" BorderBrush="#FF2563EB" BorderThickness="0,0,0,3">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>
                <StackPanel Grid.Column="0" Orientation="Horizontal" Margin="25,0,0,0" VerticalAlignment="Center">
                    <TextBlock Text="⚡ SYSTEM" FontSize="28" FontWeight="Black" Foreground="#FF3B82F6"/>
                    <TextBlock Text="SUITE" FontSize="28" FontWeight="Black" Foreground="White" Margin="8,0,0,0"/>
                    <Border Background="#FF1D4ED8" CornerRadius="4" Margin="15,0,0,0" Padding="6,2" VerticalAlignment="Center">
                        <TextBlock Text="v4.0 ELITE" FontSize="12" FontWeight="Bold"/>
                    </Border>
                </StackPanel>
                <StackPanel Grid.Column="1" Orientation="Horizontal" HorizontalAlignment="Right" Margin="0,0,20,0">
                    <Button Name="NavInstall" Content="📦 Software" Height="45" Width="140" Background="#FF1F2937" Foreground="White" BorderThickness="0" Cursor="Hand" Margin="5,0" FontWeight="Bold"/>
                    <Button Name="NavTweaks" Content="🚀 Ottimizzazione" Height="45" Width="140" Background="Transparent" Foreground="White" BorderThickness="0" Cursor="Hand" Margin="5,0" FontWeight="Bold"/>
                    <Button Name="NavFixes" Content="🧹 Manutenzione" Height="45" Width="140" Background="Transparent" Foreground="White" BorderThickness="0" Cursor="Hand" Margin="5,0" FontWeight="Bold"/>
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
                
                <Grid Grid.Row="0" Margin="0,0,0,15">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    <StackPanel Grid.Column="0">
                        <TextBlock Text="Software Hub Avanzato" FontSize="24" FontWeight="Bold" Foreground="#FF3B82F6"/>
                        <TextBlock Text="Seleziona le app. L'installazione avverrà in batch senza finestre di dialogo." FontSize="14" Foreground="#FF9CA3AF"/>
                    </StackPanel>
                    <StackPanel Grid.Column="1" Orientation="Horizontal">
                        <Button Name="BtnSelectAll" Content="Seleziona Tutto" Width="120" Height="35" Background="#FF374151" Foreground="White" BorderThickness="0" Cursor="Hand" Margin="10,0"/>
                        <Button Name="BtnClearAll" Content="Azzera" Width="90" Height="35" Background="#FF374151" Foreground="White" BorderThickness="0" Cursor="Hand"/>
                    </StackPanel>
                </Grid>
                
                <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                    <WrapPanel Orientation="Horizontal" Name="CheckboxContainer">
                        <!-- Browser -->
                        <GroupBox Header="🌐 Browser" Width="230" Margin="5" Foreground="#FF3B82F6" BorderBrush="#FF374151" BorderThickness="1">
                            <StackPanel Margin="10">
                                <CheckBox Name="ChkChrome" Content="Google Chrome" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkBrave" Content="Brave" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkFirefox" Content="Firefox" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkEdge" Content="Microsoft Edge" Foreground="White" Margin="0,6"/>
                            </StackPanel>
                        </GroupBox>
                        <!-- Utility -->
                        <GroupBox Header="🔧 Utility Sistema" Width="230" Margin="5" Foreground="#FF3B82F6" BorderBrush="#FF374151">
                            <StackPanel Margin="10">
                                <CheckBox Name="Chk7Zip" Content="7-Zip" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkWinrar" Content="WinRAR" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkPowerToys" Content="MS PowerToys" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkEverything" Content="Everything Search" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkRufus" Content="Rufus (USB Boot)" Foreground="White" Margin="0,6"/>
                            </StackPanel>
                        </GroupBox>
                        <!-- Media -->
                        <GroupBox Header="🎬 Media &amp; Design" Width="230" Margin="5" Foreground="#FF3B82F6" BorderBrush="#FF374151">
                            <StackPanel Margin="10">
                                <CheckBox Name="ChkVLC" Content="VLC Player" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkOBS" Content="OBS Studio" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkSpotify" Content="Spotify" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkGimp" Content="GIMP (Editor Foto)" Foreground="White" Margin="0,6"/>
                            </StackPanel>
                        </GroupBox>
                        <!-- Social -->
                        <GroupBox Header="💬 Comunicazione" Width="230" Margin="5" Foreground="#FF3B82F6" BorderBrush="#FF374151">
                            <StackPanel Margin="10">
                                <CheckBox Name="ChkDiscord" Content="Discord" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkTelegram" Content="Telegram" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkTeams" Content="Microsoft Teams" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkZoom" Content="Zoom" Foreground="White" Margin="0,6"/>
                            </StackPanel>
                        </GroupBox>
                        <!-- Dev -->
                        <GroupBox Header="💻 Sviluppo &amp; IT" Width="230" Margin="5" Foreground="#FF3B82F6" BorderBrush="#FF374151">
                            <StackPanel Margin="10">
                                <CheckBox Name="ChkVSCode" Content="VS Code" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkPython" Content="Python 3" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkGit" Content="Git" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkNotepadPlus" Content="Notepad++" Foreground="White" Margin="0,6"/>
                            </StackPanel>
                        </GroupBox>
                        <!-- Sicurezza -->
                        <GroupBox Header="🛡️ Sicurezza &amp; Gaming" Width="230" Margin="5" Foreground="#FF3B82F6" BorderBrush="#FF374151">
                            <StackPanel Margin="10">
                                <CheckBox Name="ChkBitwarden" Content="Bitwarden (Password)" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkMalwarebytes" Content="Malwarebytes" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkSteam" Content="Steam" Foreground="White" Margin="0,6"/>
                                <CheckBox Name="ChkEpic" Content="Epic Games" Foreground="White" Margin="0,6"/>
                            </StackPanel>
                        </GroupBox>
                    </WrapPanel>
                </ScrollViewer>
                
                <Grid Grid.Row="2" Margin="0,20,0,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    <Button Name="BtnRunUpdates" Grid.Column="0" Content="🔄 Trova e installa aggiornamenti per le app già presenti sul PC" Height="50" Background="#FF1F2937" Foreground="#FF3B82F6" FontWeight="Bold" FontSize="14" BorderThickness="1" BorderBrush="#FF3B82F6" Cursor="Hand" Margin="0,0,15,0"/>
                    <Button Name="BtnRunInstall" Grid.Column="1" Content="🚀 INSTALLA SOFTWARE" Height="50" Width="260" Background="#FF2563EB" Foreground="White" FontWeight="Black" FontSize="16" BorderThickness="0" Cursor="Hand"/>
                </Grid>
            </Grid>

            <!-- PANNELLO 2: TWEAKS (OTTIMIZZAZIONE) -->
            <Grid Name="PanelTweaks" Visibility="Collapsed">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>
                
                <StackPanel Grid.Row="0" Margin="0,0,0,20">
                    <TextBlock Text="Deep System Tweaks" FontSize="24" FontWeight="Bold" Foreground="#FF3B82F6"/>
                    <TextBlock Text="Modifiche al registro per massimizzare le performance e la privacy." FontSize="14" Foreground="#FF9CA3AF"/>
                </StackPanel>
                
                <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                    <StackPanel Margin="10">
                        <TextBlock Text="Privacy &amp; Telemetria" FontSize="18" FontWeight="Bold" Foreground="#FF9CA3AF" Margin="0,10,0,10"/>
                        <CheckBox Name="ChkTweakTelemetry" Content="Disabilita Telemetria e Raccolta Dati Microsoft" Foreground="White" FontSize="15" Margin="0,8"/>
                        <CheckBox Name="ChkTweakCortana" Content="Disabilita Cortana completamente" Foreground="White" FontSize="15" Margin="0,8"/>
                        <CheckBox Name="ChkTweakBingSearch" Content="Rimuovi la ricerca web di Bing dal Menu Start (Velocizza la ricerca locale)" Foreground="White" FontSize="15" Margin="0,8"/>
                        
                        <TextBlock Text="Performance &amp; Sistema" FontSize="18" FontWeight="Bold" Foreground="#FF9CA3AF" Margin="0,20,0,10"/>
                        <CheckBox Name="ChkTweakPerformance" Content="Ottimizza Effetti Visivi per le Massime Prestazioni (Disattiva animazioni inutili)" Foreground="White" FontSize="15" Margin="0,8"/>
                        <CheckBox Name="ChkTweakHibernate" Content="Disabilita Ibernazione (Libera fino a 10GB di spazio su disco)" Foreground="White" FontSize="15" Margin="0,8"/>
                        <CheckBox Name="ChkTweakFastStartup" Content="Disabilita Avvio Rapido (Previene schermate blu e bug della RAM)" Foreground="White" FontSize="15" Margin="0,8"/>
                        
                        <TextBlock Text="Esplora Risorse (QoL)" FontSize="18" FontWeight="Bold" Foreground="#FF9CA3AF" Margin="0,20,0,10"/>
                        <CheckBox Name="ChkTweakExtensions" Content="Mostra sempre le estensioni dei file (Es. documento.pdf invece di documento)" Foreground="White" FontSize="15" Margin="0,8"/>
                        <CheckBox Name="ChkTweakHiddenFiles" Content="Mostra file e cartelle di sistema nascosti" Foreground="White" FontSize="15" Margin="0,8"/>
                    </StackPanel>
                </ScrollViewer>
                
                <Button Name="BtnRunTweaks" Grid.Row="2" Content="⚡ APPLICA OTTIMIZZAZIONI" Height="50" Background="#FF059669" Foreground="White" FontWeight="Black" FontSize="16" BorderThickness="0" Cursor="Hand" Margin="0,20,0,0"/>
            </Grid>

            <!-- PANNELLO 3: FIXES & PULIZIA -->
            <Grid Name="PanelFixes" Visibility="Collapsed">
                <StackPanel Margin="0,0,0,20">
                    <TextBlock Text="Manutenzione Avanzata" FontSize="24" FontWeight="Bold" Foreground="#FF3B82F6"/>
                    <TextBlock Text="Strumenti per riparare un PC lento o instabile." FontSize="14" Foreground="#FF9CA3AF"/>
                </StackPanel>
                
                <Grid Margin="0,30,0,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <Button Name="BtnFixSFC" Grid.Column="0" Grid.Row="0" Content="🔧 Ripara Windows (SFC/DISM)&#x0a;Risolve file corrotti e crash di sistema" Margin="10" Height="90" Background="#FF1F2937" Foreground="White" BorderBrush="#FF374151" FontSize="15" Cursor="Hand"/>
                    <Button Name="BtnFixTemp" Grid.Column="1" Grid.Row="0" Content="🗑️ Svuota Cache e File Temp&#x0a;Elimina file spazzatura e log inutili" Margin="10" Height="90" Background="#FF1F2937" Foreground="White" BorderBrush="#FF374151" FontSize="15" Cursor="Hand"/>
                    <Button Name="BtnFixDNS" Grid.Column="0" Grid.Row="1" Content="🌐 Reset Rete (IP/DNS)&#x0a;Risolve problemi di connessione a Internet" Margin="10" Height="90" Background="#FF1F2937" Foreground="White" BorderBrush="#FF374151" FontSize="15" Cursor="Hand"/>
                    <Button Name="BtnFixUpdate" Grid.Column="1" Grid.Row="1" Content="🔄 Reset Windows Update&#x0a;Sblocca gli aggiornamenti incastrati" Margin="10" Height="90" Background="#FF1F2937" Foreground="White" BorderBrush="#FF374151" FontSize="15" Cursor="Hand"/>
                    <Button Name="BtnDebloat" Grid.ColumnSpan="2" Grid.Row="2" Content="🔥 DEBLOAT WINDOWS (Rimuove App Preinstallate inutili)&#x0a;Rimuove Meteo, Solitario, Zune, 3D Builder, ecc." Margin="10,20,10,10" Height="90" Background="#FF991B1B" Foreground="White" BorderThickness="0" FontWeight="Bold" FontSize="15" Cursor="Hand"/>
                </Grid>
            </Grid>

        </Grid>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$Window = [Windows.Markup.XamlReader]::Load($reader)

# Elementi UI
$PanelInstall = $Window.FindName("PanelInstall"); $PanelTweaks = $Window.FindName("PanelTweaks"); $PanelFixes = $Window.FindName("PanelFixes")
$NavInstall = $Window.FindName("NavInstall"); $NavTweaks = $Window.FindName("NavTweaks"); $NavFixes = $Window.FindName("NavFixes")

# Navigazione
function Set-ActivePanel ($Panel, $Btn) {
    $PanelInstall.Visibility = "Collapsed"; $PanelTweaks.Visibility = "Collapsed"; $PanelFixes.Visibility = "Collapsed"
    $Panel.Visibility = "Visible"
    $NavInstall.Background = "Transparent"; $NavTweaks.Background = "Transparent"; $NavFixes.Background = "Transparent"
    $Btn.Background = "#FF1F2937"
}
$NavInstall.Add_Click({ Set-ActivePanel $PanelInstall $NavInstall })
$NavTweaks.Add_Click({ Set-ActivePanel $PanelTweaks $NavTweaks })
$NavFixes.Add_Click({ Set-ActivePanel $PanelFixes $NavFixes })

# Lista Checkboxes
$AllCheckBoxes = @("ChkChrome","ChkBrave","ChkFirefox","ChkEdge","Chk7Zip","ChkWinrar","ChkPowerToys","ChkEverything","ChkRufus","ChkVLC","ChkOBS","ChkSpotify","ChkGimp","ChkDiscord","ChkTelegram","ChkTeams","ChkZoom","ChkVSCode","ChkPython","ChkGit","ChkNotepadPlus","ChkBitwarden","ChkMalwarebytes","ChkSteam","ChkEpic")

$Window.FindName("BtnSelectAll").Add_Click({ foreach($chk in $AllCheckBoxes){ $Window.FindName($chk).IsChecked = $true } })
$Window.FindName("BtnClearAll").Add_Click({ foreach($chk in $AllCheckBoxes){ $Window.FindName($chk).IsChecked = $false } })

# LOGICA INSTALLAZIONE
$Window.FindName("BtnRunInstall").Add_Click({
    $Apps = @()
    if ($Window.FindName("ChkChrome").IsChecked)  { $Apps += "Google.Chrome" }
    if ($Window.FindName("ChkBrave").IsChecked)   { $Apps += "Brave.Brave" }
    if ($Window.FindName("ChkFirefox").IsChecked) { $Apps += "Mozilla.Firefox" }
    if ($Window.FindName("ChkEdge").IsChecked)    { $Apps += "Microsoft.Edge" }
    if ($Window.FindName("Chk7Zip").IsChecked)    { $Apps += "7zip.7zip" }
    if ($Window.FindName("ChkWinrar").IsChecked)  { $Apps += "RARLab.WinRAR" }
    if ($Window.FindName("ChkPowerToys").IsChecked){ $Apps += "Microsoft.PowerToys" }
    if ($Window.FindName("ChkEverything").IsChecked){ $Apps += "voidtools.Everything" }
    if ($Window.FindName("ChkRufus").IsChecked)   { $Apps += "Rufus.Rufus" }
    if ($Window.FindName("ChkVLC").IsChecked)     { $Apps += "VideoLAN.VLC" }
    if ($Window.FindName("ChkOBS").IsChecked)     { $Apps += "OBSProject.OBSStudio" }
    if ($Window.FindName("ChkSpotify").IsChecked) { $Apps += "Spotify.Spotify" }
    if ($Window.FindName("ChkGimp").IsChecked)    { $Apps += "GIMP.GIMP" }
    if ($Window.FindName("ChkDiscord").IsChecked) { $Apps += "Discord.Discord" }
    if ($Window.FindName("ChkTelegram").IsChecked){ $Apps += "Telegram.TelegramDesktop" }
    if ($Window.FindName("ChkTeams").IsChecked)   { $Apps += "Microsoft.Teams" }
    if ($Window.FindName("ChkZoom").IsChecked)    { $Apps += "Zoom.Zoom" }
    if ($Window.FindName("ChkVSCode").IsChecked)  { $Apps += "Microsoft.VisualStudioCode" }
    if ($Window.FindName("ChkPython").IsChecked)  { $Apps += "Python.Python.3.12" }
    if ($Window.FindName("ChkGit").IsChecked)     { $Apps += "Git.Git" }
    if ($Window.FindName("ChkNotepadPlus").IsChecked){ $Apps += "Notepad++.Notepad++" }
    if ($Window.FindName("ChkBitwarden").IsChecked){ $Apps += "Bitwarden.Bitwarden" }
    if ($Window.FindName("ChkMalwarebytes").IsChecked){ $Apps += "Malwarebytes.Malwarebytes" }
    if ($Window.FindName("ChkSteam").IsChecked)   { $Apps += "Valve.Steam" }
    if ($Window.FindName("ChkEpic").IsChecked)    { $Apps += "EpicGames.EpicGamesLauncher" }

    if ($Apps.Count -eq 0) { [System.Windows.MessageBox]::Show("Seleziona almeno un software!", "Avviso", 0, 48); return }

    $Cmd = "Write-Host '--- SYSTEM SUITE: INSTALLAZIONE IN CORSO ---' -ForegroundColor Cyan;"
    foreach ($ID in $Apps) { $Cmd += "Write-Host '-> Installazione $ID...' -ForegroundColor Yellow; winget install --id $ID --silent --accept-package-agreements --accept-source-agreements;" }
    $Cmd += "Write-Host 'Installazione Completata!' -ForegroundColor Green; Pause"
    Start-Process powershell -ArgumentList "-NoProfile", "-Command", $Cmd
})

# AGGIORNAMENTI
$Window.FindName("BtnRunUpdates").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "Write-Host 'Ricerca aggiornamenti...' -ForegroundColor Cyan; winget upgrade --all --include-unknown --silent; Pause" })

# LOGICA TWEAKS
$Window.FindName("BtnRunTweaks").Add_Click({
    if ($Window.FindName("ChkTweakTelemetry").IsChecked) { Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakCortana").IsChecked) { New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Type DWord -Force -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakBingSearch").IsChecked) { New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1 -Type DWord -Force -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakPerformance").IsChecked) { Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2 -Type DWord -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakHibernate").IsChecked) { powercfg.exe /hibernate off }
    if ($Window.FindName("ChkTweakFastStartup").IsChecked) { Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Type DWord -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakExtensions").IsChecked) { Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Type DWord }
    if ($Window.FindName("ChkTweakHiddenFiles").IsChecked) { Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -Type DWord }
    
    Stop-Process -Name explorer -Force
    [System.Windows.MessageBox]::Show("Ottimizzazioni applicate con successo! Explorer è stato riavviato.", "Fatto", 0, 64)
})

# LOGICA FIXES & DEBLOAT
$Window.FindName("BtnFixSFC").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "sfc /scannow; dism /online /cleanup-image /restorehealth; Pause" })
$Window.FindName("BtnFixTemp").Add_Click({ Remove-Item "$env:windir\Temp\*" -Recurse -Force -EA SilentlyContinue; Remove-Item "$env:TEMP\*" -Recurse -Force -EA SilentlyContinue; [System.Windows.MessageBox]::Show("Cache di sistema pulita!", "Fatto", 0, 64) })
$Window.FindName("BtnFixDNS").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "ipconfig /flushdns; netsh winsock reset; netsh int ip reset; Pause" })
$Window.FindName("BtnFixUpdate").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "net stop wuauserv; net stop cryptSvc; net stop bits; net stop msiserver; ren C:\Windows\SoftwareDistribution SoftwareDistribution.old; net start wuauserv; net start cryptSvc; net start bits; net start msiserver; Write-Host 'Windows Update Ripristinato!' -ForegroundColor Green; Pause" })
$Window.FindName("BtnDebloat").Add_Click({ 
    $DebloatCmd = "Write-Host 'Rimozione Bloatware in corso...' -ForegroundColor Red; Get-AppxPackage *3dbuilder* | Remove-AppxPackage; Get-AppxPackage *windowsalarms* | Remove-AppxPackage; Get-AppxPackage *windowscamera* | Remove-AppxPackage; Get-AppxPackage *bingfinance* | Remove-AppxPackage; Get-AppxPackage *bingsports* | Remove-AppxPackage; Get-AppxPackage *bingweather* | Remove-AppxPackage; Get-AppxPackage *zunevideo* | Remove-AppxPackage; Get-AppxPackage *zunemusic* | Remove-AppxPackage; Get-AppxPackage *solitairecollection* | Remove-AppxPackage; Write-Host 'Pulizia completata!' -ForegroundColor Green; Pause"
    Start-Process powershell -ArgumentList "-NoProfile", "-Command", $DebloatCmd 
})

$Window.ShowDialog() | Out-Null
