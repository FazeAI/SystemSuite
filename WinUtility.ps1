# =========================================================
# 1. BENVENUTO NEL TERMINALE POWERSHELL (Testuale)
# =========================================================
Clear-Host
Write-Host " =================================================== " -ForegroundColor Cyan
Write-Host " |                                                 | " -ForegroundColor Cyan
Write-Host " |      BENVENUTO NEL TUO TOOL DI SISTEMA PRO      | " -ForegroundColor White -BackgroundColor DarkCyan
Write-Host " |                                                 | " -ForegroundColor Cyan
Write-Host " =================================================== " -ForegroundColor Cyan
Write-Host "`n"
Write-Host " Cosa desideri fare?"
Write-Host " 1) Avvia l'interfaccia grafica (Software)" -ForegroundColor Green
Write-Host " 2) Esci e annulla" -ForegroundColor Red
Write-Host "`n"

$scelta = ""
while ($scelta -notin @('1', '2')) {
    $scelta = Read-Host "Digita 1 o 2 e premi Invio"
}

if ($scelta -eq '2') {
    Write-Host "Chiusura in corso..." -ForegroundColor Yellow
    Start-Sleep -Seconds 1
    exit
}

# =========================================================
# 2. VERIFICA PRIVILEGI DI AMMINISTRATORE
# =========================================================
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "`nATTENZIONE: Devi aprire PowerShell come Amministratore per usare questo tool!" -ForegroundColor Red
    Write-Host "Clicca col tasto destro sull'icona di PowerShell e scegli 'Esegui come Amministratore'." -ForegroundColor Yellow
    Read-Host "Premi Invio per uscire..."
    exit
}

Write-Host "Caricamento dell'interfaccia grafica in corso..." -ForegroundColor Cyan

# Carica l'architettura grafica di Windows
Add-Type -AssemblyName PresentationFramework

# =========================================================
# 3. INTERFACCIA GRAFICA UNICA (Design Orizzontale & Teal)
# =========================================================
[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="System Optimization &amp; Setup Suite" Height="650" Width="1000" 
        WindowStartupLocation="CenterScreen" Background="#FF0F172A" Foreground="White">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="70"/> <RowDefinition Height="*"/>  </Grid.RowDefinitions>

        <Border Grid.Row="0" Background="#FF1E293B" BorderBrush="#FF334155" BorderThickness="0,0,0,2">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>
                
                <StackPanel Grid.Column="0" Orientation="Horizontal" Margin="20,0,0,0" VerticalAlignment="Center">
                    <TextBlock Text="SYSTEM" FontSize="22" FontWeight="Bold" Foreground="#FF14B8A6"/>
                    <TextBlock Text="SUITE" FontSize="22" FontWeight="Bold" Foreground="White" Margin="5,0,20,0"/>
                </StackPanel>

                <StackPanel Grid.Column="1" Orientation="Horizontal" HorizontalAlignment="Right" Margin="0,0,20,0">
                    <Button Name="NavInstall" Content="📦 Software Hub" Height="40" Width="140" Background="#FF334155" Foreground="White" BorderThickness="0" FontSize="14" Cursor="Hand" Margin="5,0"/>
                    <Button Name="NavTweaks" Content="🚀 Performance" Height="40" Width="140" Background="Transparent" Foreground="White" BorderThickness="0" FontSize="14" Cursor="Hand" Margin="5,0"/>
                    <Button Name="NavFixes" Content="🧹 Pulizia &amp; Fix" Height="40" Width="140" Background="Transparent" Foreground="White" BorderThickness="0" FontSize="14" Cursor="Hand" Margin="5,0"/>
                    <Button Name="NavInfo" Content="ℹ️ Info Tool" Height="40" Width="120" Background="Transparent" Foreground="White" BorderThickness="0" FontSize="14" Cursor="Hand" Margin="5,0"/>
                </StackPanel>
            </Grid>
        </Border>

        <Grid Grid.Row="1" Margin="30">
            
            <Grid Name="PanelInstall" Visibility="Visible">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>
                
                <StackPanel Grid.Row="0" Margin="0,0,0,15">
                    <TextBlock Text="Seleziona e installa le migliori applicazioni" FontSize="20" FontWeight="Bold" Foreground="#FF14B8A6"/>
                    <TextBlock Text="Tutte le installazioni avvengono in background e senza fastidiosi popup." FontSize="13" Foreground="#FF94A3B8"/>
                </StackPanel>
                
                <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                    <WrapPanel Orientation="Horizontal">
                        <GroupBox Header="Browser &amp; Rete" Width="210" Margin="5" Foreground="#FF38BDF8" BorderBrush="#FF334155">
                            <StackPanel Margin="10">
                                <CheckBox Name="ChkChrome" Content="Google Chrome" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkBrave" Content="Brave Browser" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkFirefox" Content="Mozilla Firefox" Foreground="White" Margin="0,5"/>
                            </StackPanel>
                        </GroupBox>
                        <GroupBox Header="Media &amp; Creator" Width="210" Margin="5" Foreground="#FF38BDF8" BorderBrush="#FF334155">
                            <StackPanel Margin="10">
                                <CheckBox Name="ChkVLC" Content="VLC Media Player" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkOBS" Content="OBS Studio" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkGimp" Content="GIMP" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkSpotify" Content="Spotify" Foreground="White" Margin="0,5"/>
                            </StackPanel>
                        </GroupBox>
                        <GroupBox Header="Archivi &amp; Strumenti" Width="210" Margin="5" Foreground="#FF38BDF8" BorderBrush="#FF334155">
                            <StackPanel Margin="10">
                                <CheckBox Name="Chk7Zip" Content="7-Zip" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkWinrar" Content="WinRAR" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkRufus" Content="Rufus (USB Boot)" Foreground="White" Margin="0,5"/>
                            </StackPanel>
                        </GroupBox>
                        <GroupBox Header="Comunicazione" Width="210" Margin="5" Foreground="#FF38BDF8" BorderBrush="#FF334155">
                            <StackPanel Margin="10">
                                <CheckBox Name="ChkDiscord" Content="Discord" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkZoom" Content="Zoom" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkTelegram" Content="Telegram Desktop" Foreground="White" Margin="0,5"/>
                            </StackPanel>
                        </GroupBox>
                        <GroupBox Header="Sviluppo &amp; Gaming" Width="210" Margin="5" Foreground="#FF38BDF8" BorderBrush="#FF334155">
                            <StackPanel Margin="10">
                                <CheckBox Name="ChkSteam" Content="Steam" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkEpic" Content="Epic Games" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkVSCode" Content="VS Code" Foreground="White" Margin="0,5"/>
                                <CheckBox Name="ChkNotepad" Content="Notepad++" Foreground="White" Margin="0,5"/>
                            </StackPanel>
                        </GroupBox>
                    </WrapPanel>
                </ScrollViewer>
                
                <Grid Grid.Row="2" Margin="0,15,0,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    <Button Name="BtnRunUpdates" Grid.Column="0" Content="🔄 Aggiorna Tutte le App già Installate sul PC" Height="45" Background="#FF1E293B" Foreground="#FF38BDF8" FontWeight="Bold" FontSize="14" BorderBrush="#FF38BDF8" BorderThickness="1" Cursor="Hand" Margin="0,0,10,0"/>
                    <Button Name="BtnRunInstall" Grid.Column="1" Content="🚀 INSTALLA SELEZIONATI" Height="45" Width="250" Background="#FF14B8A6" Foreground="Black" FontWeight="Bold" FontSize="15" BorderThickness="0" Cursor="Hand"/>
                </Grid>
            </Grid>

            <Grid Name="PanelTweaks" Visibility="Collapsed">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>
                
                <StackPanel Grid.Row="0" Margin="0,0,0,20">
                    <TextBlock Text="Performance &amp; Ottimizzazione" FontSize="20" FontWeight="Bold" Foreground="#FF14B8A6"/>
                    <TextBlock Text="Applica modifiche profonde al registro per velocizzare l'uso quotidiano." FontSize="13" Foreground="#FF94A3B8"/>
                </StackPanel>
                
                <StackPanel Grid.Row="1" Margin="10">
                    <CheckBox Name="ChkTweakTelemetry" Content="Disabilita Telemetria (Blocca invio dati a Microsoft)" Foreground="White" FontSize="14" Margin="0,10"/>
                    <CheckBox Name="ChkTweakHibernate" Content="Disabilita Ibernazione (Libera dai 2 ai 5 GB di spazio su C:)" Foreground="White" FontSize="14" Margin="0,10"/>
                    <CheckBox Name="ChkTweakFastStartup" Content="Disabilita Avvio Rapido (Migliora la stabilità e previene bug di Windows)" Foreground="White" FontSize="14" Margin="0,10"/>
                    <CheckBox Name="ChkTweakCortana" Content="Disabilita Cortana completamente (Risparmia RAM in background)" Foreground="White" FontSize="14" Margin="0,10"/>
                    <CheckBox Name="ChkTweakDarkMode" Content="Forza Tema Scuro su tutto Windows e le App" Foreground="White" FontSize="14" Margin="0,10"/>
                </StackPanel>
                
                <Button Name="BtnRunTweaks" Grid.Row="2" Content="🛠️ APPLICA MODIFICHE" Height="45" Background="#FFD946EF" Foreground="White" FontWeight="Bold" FontSize="15" BorderThickness="0" Cursor="Hand"/>
            </Grid>

            <Grid Name="PanelFixes" Visibility="Collapsed">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                </Grid.RowDefinitions>
                
                <StackPanel Grid.Row="0" Margin="0,0,0,20">
                    <TextBlock Text="Risoluzione Problemi e Manutenzione" FontSize="20" FontWeight="Bold" Foreground="#FF14B8A6"/>
                    <TextBlock Text="Strumenti per riparare errori e alleggerire il disco fisso." FontSize="13" Foreground="#FF94A3B8"/>
                </StackPanel>
                
                <Grid Grid.Row="1">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <Button Name="BtnFixSFC" Grid.Column="0" Grid.Row="0" Content="🔧 Ripara Windows (SFC / DISM)&#x0a;Risolve errori di sistema e schermate blu" Margin="5" Height="80" Background="#FF1E293B" Foreground="White" BorderBrush="#FF334155" FontSize="14" Cursor="Hand"/>
                    <Button Name="BtnFixTemp" Grid.Column="1" Grid.Row="0" Content="🗑️ Svuota File Cache &amp; Temporanei&#x0a;Recupera spazio sprecato dal sistema" Margin="5" Height="80" Background="#FF1E293B" Foreground="White" BorderBrush="#FF334155" FontSize="14" Cursor="Hand"/>
                    <Button Name="BtnFixDNS" Grid.Column="0" Grid.Row="1" Content="🌐 Ripristina Adattatore Rete &amp; DNS&#x0a;Usa questo se internet è lento o non va" Margin="5" Height="80" Background="#FF1E293B" Foreground="White" BorderBrush="#FF334155" FontSize="14" Cursor="Hand"/>
                </Grid>
            </Grid>

            <Grid Name="PanelInfo" Visibility="Collapsed">
                <StackPanel Margin="0,0,0,20">
                    <TextBlock Text="Informazioni sul Software" FontSize="20" FontWeight="Bold" Foreground="#FF14B8A6"/>
                    <TextBlock Text="Dettagli sullo sviluppo e sull'uso di questa suite." FontSize="13" Foreground="#FF94A3B8" Margin="0,5,0,25"/>
                    
                    <Border Background="#FF1E293B" Padding="20" CornerRadius="8" BorderBrush="#FF334155" BorderThickness="1">
                        <StackPanel>
                            <TextBlock Text="Cos'è System Suite?" FontWeight="Bold" FontSize="16" Foreground="White" Margin="0,0,0,10"/>
                            <TextBlock Text="Questo strumento è stato creato per automatizzare le configurazioni noiose post-installazione di Windows. Utilizza lo standard nativo 'Windows Package Manager' (WinGet) per garantire che i software scaricati siano sempre le versioni originali e sicure fornite dai produttori, prive di virus o bloatware." TextWrapping="Wrap" FontSize="14" Foreground="#FFCBD5E1"/>
                            
                            <TextBlock Text="Cloud-Ready" FontWeight="Bold" FontSize="16" Foreground="White" Margin="0,20,0,10"/>
                            <TextBlock Text="Eseguibile direttamente dalla memoria tramite Invoke-RestMethod, garantendo che tu abbia sempre l'ultima versione disponibile senza file locali obsoleti." TextWrapping="Wrap" FontSize="14" Foreground="#FFCBD5E1"/>
                        </StackPanel>
                    </Border>
                </StackPanel>
            </Grid>

        </Grid>
    </Grid>
</Window>
"@

# Genera la Finestra
$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$Window = [Windows.Markup.XamlReader]::Load($reader)

# =========================================================
# 4. COLLEGAMENTO LOGICA ALL'INTERFACCIA
# =========================================================

# Contenitori Pannelli
$PanelInstall = $Window.FindName("PanelInstall")
$PanelTweaks  = $Window.FindName("PanelTweaks")
$PanelFixes   = $Window.FindName("PanelFixes")
$PanelInfo    = $Window.FindName("PanelInfo")

# Bottoni Top Navbar
$NavInstall   = $Window.FindName("NavInstall")
$NavTweaks    = $Window.FindName("NavTweaks")
$NavFixes     = $Window.FindName("NavFixes")
$NavInfo      = $Window.FindName("NavInfo")

# Gestione della Navigazione
function Set-ActivePanel ($ActivePanel, $ActiveButton) {
    $PanelInstall.Visibility = "Collapsed"
    $PanelTweaks.Visibility  = "Collapsed"
    $PanelFixes.Visibility   = "Collapsed"
    $PanelInfo.Visibility    = "Collapsed"
    
    $ActivePanel.Visibility  = "Visible"
    
    # Resetta sfondo bottoni
    $NavInstall.Background = "Transparent"
    $NavTweaks.Background  = "Transparent"
    $NavFixes.Background   = "Transparent"
    $NavInfo.Background    = "Transparent"
    
    # Evidenzia bottone attivo
    $ActiveButton.Background = "#FF334155"
}

$NavInstall.Add_Click({ Set-ActivePanel $PanelInstall $NavInstall })
$NavTweaks.Add_Click({ Set-ActivePanel $PanelTweaks $NavTweaks })
$NavFixes.Add_Click({ Set-ActivePanel $PanelFixes $NavFixes })
$NavInfo.Add_Click({ Set-ActivePanel $PanelInfo $NavInfo })

# --- LOGICA APP INSTALLER ---
$Window.FindName("BtnRunInstall").Add_Click({
    $AppsToInstall = @()
    if ($Window.FindName("ChkChrome").IsChecked)  { $AppsToInstall += "Google.Chrome" }
    if ($Window.FindName("ChkBrave").IsChecked)   { $AppsToInstall += "Brave.Brave" }
    if ($Window.FindName("ChkFirefox").IsChecked) { $AppsToInstall += "Mozilla.Firefox" }
    if ($Window.FindName("Chk7Zip").IsChecked)    { $AppsToInstall += "7zip.7zip" }
    if ($Window.FindName("ChkWinrar").IsChecked)  { $AppsToInstall += "RARLab.WinRAR" }
    if ($Window.FindName("ChkRufus").IsChecked)   { $AppsToInstall += "Rufus.Rufus" }
    if ($Window.FindName("ChkNotepad").IsChecked) { $AppsToInstall += "Notepad++.Notepad++" }
    if ($Window.FindName("ChkVLC").IsChecked)     { $AppsToInstall += "VideoLAN.VLC" }
    if ($Window.FindName("ChkOBS").IsChecked)     { $AppsToInstall += "OBSProject.OBSStudio" }
    if ($Window.FindName("ChkGimp").IsChecked)    { $AppsToInstall += "GIMP.GIMP" }
    if ($Window.FindName("ChkDiscord").IsChecked) { $AppsToInstall += "Discord.Discord" }
    if ($Window.FindName("ChkTelegram").IsChecked){ $AppsToInstall += "Telegram.TelegramDesktop" }
    if ($Window.FindName("ChkZoom").IsChecked)    { $AppsToInstall += "Zoom.Zoom" }
    if ($Window.FindName("ChkSpotify").IsChecked) { $AppsToInstall += "Spotify.Spotify" }
    if ($Window.FindName("ChkSteam").IsChecked)   { $AppsToInstall += "Valve.Steam" }
    if ($Window.FindName("ChkEpic").IsChecked)    { $AppsToInstall += "EpicGames.EpicGamesLauncher" }
    if ($Window.FindName("ChkVSCode").IsChecked)  { $AppsToInstall += "Microsoft.VisualStudioCode" }

    if ($AppsToInstall.Count -eq 0) {
        [System.Windows.MessageBox]::Show("Seleziona almeno un'applicazione!", "Attenzione", 0, 48)
        return
    }

    $Command = "Write-Host '=== SYSTEM SUITE: AVVIO CODA DI INSTALLAZIONE ===' -ForegroundColor Cyan;"
    foreach ($AppID in $AppsToInstall) {
        $Command += "Write-Host 'Installazione di $AppID...' -ForegroundColor DarkCyan; winget install --id $AppID --silent --accept-package-agreements --accept-source-agreements;"
    }
    $Command += "Write-Host '`nTutte le operazioni sono concluse! Puoi chiudere questa console.' -ForegroundColor Green; Pause"

    Start-Process powershell -ArgumentList "-NoProfile", "-Command", $Command
})

# Logica Aggiorna App (Spostato sotto la griglia di installazione per comodità)
$Window.FindName("BtnRunUpdates").Add_Click({
    Start-Process powershell -ArgumentList "-NoProfile", "-Command", "Write-Host 'Cerco e scarico gli aggiornamenti...' -ForegroundColor Cyan; winget upgrade --all --include-unknown --silent --accept-package-agreements --accept-source-agreements; Pause"
})

# --- LOGICA TWEAKS ---
$Window.FindName("BtnRunTweaks").Add_Click({
    $TweaksApplicati = 0
    if ($Window.FindName("ChkTweakTelemetry").IsChecked) { Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -ErrorAction SilentlyContinue; $TweaksApplicati++ }
    if ($Window.FindName("ChkTweakHibernate").IsChecked) { powercfg.exe /hibernate off; $TweaksApplicati++ }
    if ($Window.FindName("ChkTweakFastStartup").IsChecked) { Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue; $TweaksApplicati++ }
    if ($Window.FindName("ChkTweakCortana").IsChecked) { Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Type DWord -ErrorAction SilentlyContinue; $TweaksApplicati++ }
    if ($Window.FindName("ChkTweakDarkMode").IsChecked) { 
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        $TweaksApplicati++
    }

    [System.Windows.MessageBox]::Show("Applicati $TweaksApplicati tweaks! (Alcuni potrebbero richiedere il riavvio del PC)", "Ottimizzazione Completata", 0, 64)
})

# --- LOGICA MANUTENZIONE & FIXES ---
$Window.FindName("BtnFixSFC").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-NoExit", "-Command", "Write-Host 'Avvio Riparazione (Richiede tempo)...' -ForegroundColor Cyan; sfc /scannow; dism /online /cleanup-image /restorehealth" })
$Window.FindName("BtnFixTemp").Add_Click({ Remove-Item -Path "$env:windir\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue; Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue; [System.Windows.MessageBox]::Show("Recuperato spazio su disco!", "Fatto", 0, 64) })
$Window.FindName("BtnFixDNS").Add_Click({ ipconfig /flushdns | Out-Null; netsh int ip reset | Out-Null; [System.Windows.MessageBox]::Show("Scheda di Rete e DNS ripristinati! Riavvia il PC per applicare le modifiche.", "Fatto", 0, 64) })

# =========================================================
# 5. AVVIO FINALE
# =========================================================
$Window.ShowDialog() | Out-Null
