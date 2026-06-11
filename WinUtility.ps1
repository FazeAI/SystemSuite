# =========================================================
# SYSTEM SUITE - v5.0 ENTERPRISE EDITION (HOTFIXED)
# =========================================================
Clear-Host
Write-Host "Avvio System Suite v5.0 Enterprise..." -ForegroundColor Cyan

# Verifica Privilegi di Amministratore
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "ERRORE: Esegui PowerShell come Amministratore!" -ForegroundColor Red
    Start-Sleep -Seconds 3
    exit
}

Add-Type -AssemblyName PresentationFramework

# =========================================================
# INTERFACCIA GRAFICA (XAML) - LAYOUT A SCHEDE (TABS)
# =========================================================
[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="System Suite Enterprise v5.0" Height="800" Width="1150" 
        WindowStartupLocation="CenterScreen" Background="#FF0F172A" Foreground="White" FontFamily="Segoe UI">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="90"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="40"/>
        </Grid.RowDefinitions>

        <Border Grid.Row="0" Background="#FF020617" BorderBrush="#FF38BDF8" BorderThickness="0,0,0,3" Padding="20">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>
                <StackPanel Grid.Column="0" Orientation="Horizontal" VerticalAlignment="Center">
                    <TextBlock Text="⚙️ SYSTEM" FontSize="32" FontWeight="Black" Foreground="#FF38BDF8"/>
                    <TextBlock Text="SUITE" FontSize="32" FontWeight="Black" Foreground="White" Margin="10,0,0,0"/>
                    <Border Background="#FF0369A1" CornerRadius="6" Margin="20,0,0,0" Padding="8,4" VerticalAlignment="Center">
                        <TextBlock Text="v5.0 ENTERPRISE" FontSize="14" FontWeight="Bold" Foreground="White"/>
                    </Border>
                </StackPanel>
                <TextBlock Grid.Column="1" Text="Advanced System Configuration Tool" FontSize="16" Foreground="#FF64748B" HorizontalAlignment="Right" VerticalAlignment="Center"/>
            </Grid>
        </Border>

        <TabControl Grid.Row="1" Background="Transparent" BorderThickness="0" Margin="10" Foreground="Black">
            
            <TabItem Header="📦 Software Hub" FontSize="16" FontWeight="Bold">
                <Grid Background="#FF0F172A" Margin="20">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    
                    <StackPanel Grid.Row="0" Margin="0,0,0,15" Orientation="Horizontal">
                        <TextBlock Text="Gestione Pacchetti WinGet" FontSize="24" FontWeight="Bold" Foreground="#FF38BDF8"/>
                    </StackPanel>
                    
                    <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                        <WrapPanel Orientation="Horizontal" Name="CheckboxContainer">
                            <GroupBox Header="Browser &amp; Internet" Width="240" Margin="10" Foreground="#FF38BDF8" BorderBrush="#FF334155" FontSize="14">
                                <StackPanel Margin="10">
                                    <CheckBox Name="ChkChrome" Content="Google Chrome" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="ChkBrave" Content="Brave Browser" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="ChkFirefox" Content="Mozilla Firefox" Foreground="White" Margin="0,5"/>
                                </StackPanel>
                            </GroupBox>
                            <GroupBox Header="Sviluppo &amp; IT" Width="240" Margin="10" Foreground="#FF38BDF8" BorderBrush="#FF334155" FontSize="14">
                                <StackPanel Margin="10">
                                    <CheckBox Name="ChkVSCode" Content="Visual Studio Code" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="ChkPython" Content="Python 3" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="ChkGit" Content="Git" Foreground="White" Margin="0,5"/>
                                </StackPanel>
                            </GroupBox>
                            <GroupBox Header="Media &amp; Creatività" Width="240" Margin="10" Foreground="#FF38BDF8" BorderBrush="#FF334155" FontSize="14">
                                <StackPanel Margin="10">
                                    <CheckBox Name="ChkVLC" Content="VLC Media Player" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="ChkOBS" Content="OBS Studio" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="ChkGimp" Content="GIMP" Foreground="White" Margin="0,5"/>
                                </StackPanel>
                            </GroupBox>
                            <GroupBox Header="Gaming &amp; Chat" Width="240" Margin="10" Foreground="#FF38BDF8" BorderBrush="#FF334155" FontSize="14">
                                <StackPanel Margin="10">
                                    <CheckBox Name="ChkSteam" Content="Steam" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="ChkDiscord" Content="Discord" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="ChkEpic" Content="Epic Games" Foreground="White" Margin="0,5"/>
                                </StackPanel>
                            </GroupBox>
                            <GroupBox Header="Utility di Sistema" Width="240" Margin="10" Foreground="#FF38BDF8" BorderBrush="#FF334155" FontSize="14">
                                <StackPanel Margin="10">
                                    <CheckBox Name="Chk7Zip" Content="7-Zip" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="ChkRufus" Content="Rufus" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="ChkPowerToys" Content="MS PowerToys" Foreground="White" Margin="0,5"/>
                                </StackPanel>
                            </GroupBox>
                        </WrapPanel>
                    </ScrollViewer>
                    
                    <Grid Grid.Row="2" Margin="0,20,0,0">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="Auto"/>
                        </Grid.ColumnDefinitions>
                        <Button Name="BtnRunUpdates" Grid.Column="0" Content="🔄 Aggiorna tutte le App installate sul PC" Height="50" Background="#FF1E293B" Foreground="#FF38BDF8" FontWeight="Bold" FontSize="15" BorderThickness="1" BorderBrush="#FF38BDF8" Cursor="Hand" Margin="0,0,15,0"/>
                        <Button Name="BtnRunInstall" Grid.Column="1" Content="🚀 INSTALLA SELEZIONATI" Height="50" Width="280" Background="#FF38BDF8" Foreground="#FF020617" FontWeight="Black" FontSize="16" BorderThickness="0" Cursor="Hand"/>
                    </Grid>
                </Grid>
            </TabItem>

            <TabItem Header="🚀 Sistema &amp; Tweaks" FontSize="16" FontWeight="Bold">
                <ScrollViewer Margin="20" Background="#FF0F172A">
                    <StackPanel>
                        <TextBlock Text="Ottimizzazione Profonda OS" FontSize="24" FontWeight="Bold" Foreground="#FF38BDF8" Margin="0,0,0,20"/>
                        
                        <Border Background="#FF1E293B" CornerRadius="8" Padding="20" Margin="0,0,0,15">
                            <StackPanel>
                                <TextBlock Text="Privacy &amp; Servizi" FontSize="18" FontWeight="Bold" Foreground="White" Margin="0,0,0,10"/>
                                <CheckBox Name="ChkTweakTelemetry" Content="Disabilita Telemetria Microsoft e Invio Dati Diagnostici" Foreground="#FFCBD5E1" FontSize="15" Margin="0,5"/>
                                <CheckBox Name="ChkTweakCortana" Content="Disabilita Cortana in background" Foreground="#FFCBD5E1" FontSize="15" Margin="0,5"/>
                                <CheckBox Name="ChkTweakBing" Content="Rimuovi ricerca Web/Bing dal Menu Start (Velocizza la ricerca file)" Foreground="#FFCBD5E1" FontSize="15" Margin="0,5"/>
                            </StackPanel>
                        </Border>

                        <Border Background="#FF1E293B" CornerRadius="8" Padding="20" Margin="0,0,0,15">
                            <StackPanel>
                                <TextBlock Text="Prestazioni &amp; Gaming" FontSize="18" FontWeight="Bold" Foreground="White" Margin="0,0,0,10"/>
                                <CheckBox Name="ChkTweakGameMode" Content="Forza attivazione Windows Game Mode" Foreground="#FFCBD5E1" FontSize="15" Margin="0,5"/>
                                <CheckBox Name="ChkTweakFastStartup" Content="Disabilita Avvio Rapido (Previene BSOD e Bug di spegnimento)" Foreground="#FFCBD5E1" FontSize="15" Margin="0,5"/>
                                <CheckBox Name="ChkTweakHibernate" Content="Disabilita Ibernazione (Libera istantaneamente GB sul disco C:)" Foreground="#FFCBD5E1" FontSize="15" Margin="0,5"/>
                            </StackPanel>
                        </Border>
                        
                        <Button Name="BtnApplyTweaks" Content="⚡ APPLICA OTTIMIZZAZIONI" Height="50" Background="#FF10B981" Foreground="White" FontWeight="Black" FontSize="16" BorderThickness="0" Cursor="Hand" Margin="0,15,0,0"/>
                    </StackPanel>
                </ScrollViewer>
            </TabItem>

            <TabItem Header="🧹 Manutenzione &amp; Rete" FontSize="16" FontWeight="Bold">
                <Grid Background="#FF0F172A" Margin="20">
                    <StackPanel>
                        <TextBlock Text="Strumenti di Riparazione Avanzati" FontSize="24" FontWeight="Bold" Foreground="#FF38BDF8" Margin="0,0,0,20"/>
                        
                        <WrapPanel Orientation="Horizontal">
                            <Button Name="BtnFixSFC" Content="🔧 Ripara Windows (SFC)&#x0a;Controlla e ripara file di sistema" Width="330" Height="90" Background="#FF1E293B" Foreground="White" BorderThickness="1" BorderBrush="#FF334155" FontSize="15" Cursor="Hand" Margin="10"/>
                            <Button Name="BtnFixTemp" Content="🗑️ Pulizia Profonda (Cache)&#x0a;Rimuove file temporanei e log" Width="330" Height="90" Background="#FF1E293B" Foreground="White" BorderThickness="1" BorderBrush="#FF334155" FontSize="15" Cursor="Hand" Margin="10"/>
                            <Button Name="BtnResetUpdate" Content="🔄 Reset Windows Update&#x0a;Sblocca gli aggiornamenti in stallo" Width="330" Height="90" Background="#FF1E293B" Foreground="White" BorderThickness="1" BorderBrush="#FF334155" FontSize="15" Cursor="Hand" Margin="10"/>
                            <Button Name="BtnDNSCloudflare" Content="🌐 Imposta DNS Cloudflare (1.1.1.1)&#x0a;Massima velocità e privacy di rete" Width="330" Height="90" Background="#FF1E293B" Foreground="#FF38BDF8" BorderThickness="1" BorderBrush="#FF38BDF8" FontSize="15" Cursor="Hand" Margin="10"/>
                            <Button Name="BtnDebloat" Content="🔥 SUPER DEBLOAT&#x0a;Rimuove tutte le App preinstallate inutili" Width="680" Height="90" Background="#FF991B1B" Foreground="White" BorderThickness="0" FontWeight="Bold" FontSize="16" Cursor="Hand" Margin="10"/>
                        </WrapPanel>
                    </StackPanel>
                </Grid>
            </TabItem>
        </TabControl>

        <Border Grid.Row="2" Background="#FF020617" BorderThickness="0,1,0,0" BorderBrush="#FF334155">
            <TextBlock Text="  Stato: Pronto. In attesa di comandi..." Foreground="#FF10B981" VerticalAlignment="Center" FontWeight="Bold"/>
        </Border>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$Window = [Windows.Markup.XamlReader]::Load($reader)

# --- LOGICA APPLICAZIONE ---

# 1. SOFTWARE INSTALL
$Window.FindName("BtnRunInstall").Add_Click({
    $Apps = @()
    if ($Window.FindName("ChkChrome").IsChecked)  { $Apps += "Google.Chrome" }
    if ($Window.FindName("ChkBrave").IsChecked)   { $Apps += "Brave.Brave" }
    if ($Window.FindName("ChkFirefox").IsChecked) { $Apps += "Mozilla.Firefox" }
    if ($Window.FindName("ChkVSCode").IsChecked)  { $Apps += "Microsoft.VisualStudioCode" }
    if ($Window.FindName("ChkPython").IsChecked)  { $Apps += "Python.Python.3.12" }
    if ($Window.FindName("ChkGit").IsChecked)     { $Apps += "Git.Git" }
    if ($Window.FindName("ChkVLC").IsChecked)     { $Apps += "VideoLAN.VLC" }
    if ($Window.FindName("ChkOBS").IsChecked)     { $Apps += "OBSProject.OBSStudio" }
    if ($Window.FindName("ChkGimp").IsChecked)    { $Apps += "GIMP.GIMP" }
    if ($Window.FindName("ChkSteam").IsChecked)   { $Apps += "Valve.Steam" }
    if ($Window.FindName("ChkDiscord").IsChecked) { $Apps += "Discord.Discord" }
    if ($Window.FindName("ChkEpic").IsChecked)    { $Apps += "EpicGames.EpicGamesLauncher" }
    if ($Window.FindName("Chk7Zip").IsChecked)    { $Apps += "7zip.7zip" }
    if ($Window.FindName("ChkRufus").IsChecked)   { $Apps += "Rufus.Rufus" }
    if ($Window.FindName("ChkPowerToys").IsChecked){ $Apps += "Microsoft.PowerToys" }

    if ($Apps.Count -eq 0) { [System.Windows.MessageBox]::Show("Seleziona almeno un pacchetto!", "Avviso", 0, 48); return }

    $Cmd = "Write-Host '--- SYSTEM SUITE INSTALLER ---' -ForegroundColor Cyan;"
    foreach ($ID in $Apps) { $Cmd += "Write-Host 'Installazione $ID...' -ForegroundColor Yellow; winget install --id $ID --silent --accept-package-agreements --accept-source-agreements;" }
    $Cmd += "Write-Host 'Completato!' -ForegroundColor Green; Pause"
    Start-Process powershell -ArgumentList "-NoProfile", "-Command", $Cmd
})

$Window.FindName("BtnRunUpdates").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "Write-Host 'Aggiornamento globale in corso...' -ForegroundColor Cyan; winget upgrade --all --include-unknown --silent; Pause" })

# 2. TWEAKS
$Window.FindName("BtnApplyTweaks").Add_Click({
    if ($Window.FindName("ChkTweakTelemetry").IsChecked) { Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakCortana").IsChecked) { New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Type DWord -Force -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakBing").IsChecked) { New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1 -Type DWord -Force -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakGameMode").IsChecked) { Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 1 -Type DWord -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakFastStartup").IsChecked) { Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Type DWord -EA SilentlyContinue }
    if ($Window.FindName("ChkTweakHibernate").IsChecked) { powercfg.exe /hibernate off }
    
    [System.Windows.MessageBox]::Show("Tweaks applicati con successo! Riavvia il PC per completare l'opera.", "Operazione Riuscita", 0, 64)
})

# 3. FIXES
$Window.FindName("BtnFixSFC").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "sfc /scannow; dism /online /cleanup-image /restorehealth; Pause" })
$Window.FindName("BtnFixTemp").Add_Click({ Remove-Item "$env:windir\Temp\*" -Recurse -Force -EA SilentlyContinue; Remove-Item "$env:TEMP\*" -Recurse -Force -EA SilentlyContinue; [System.Windows.MessageBox]::Show("Sistema ripulito!", "Fatto", 0, 64) })
$Window.FindName("BtnResetUpdate").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "net stop wuauserv; net stop bits; ren C:\Windows\SoftwareDistribution SoftwareDistribution.old; net start wuauserv; net start bits; Pause" })
$Window.FindName("BtnDNSCloudflare").Add_Click({
    $Interface = Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object -First 1
    if ($Interface) {
        Set-DnsClientServerAddress -InterfaceIndex $Interface.ifIndex -ServerAddresses ("1.1.1.1","1.0.0.1")
        ipconfig /flushdns
        [System.Windows.MessageBox]::Show("DNS impostati su Cloudflare. Navigazione velocizzata!", "Fatto", 0, 64)
    }
})
$Window.FindName("BtnDebloat").Add_Click({ Start-Process powershell -ArgumentList "-NoProfile", "-Command", "Get-AppxPackage -AllUsers | Where-Object {`$_.Name -match 'Bing|Zune|Solitaire|3DBuilder|SkypeApp|MixedReality'} | Remove-AppxPackage -AllUsers; Pause" })

$Window.ShowDialog() | Out-Null
