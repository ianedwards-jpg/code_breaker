$ErrorActionPreference = "SilentlyContinue"

Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0) | Out-Null



Add-Type -AssemblyName PresentationFramework,System.Windows.Forms,System.Windows.Forms.DataVisualization

[xml]$xaml = @"
<Window Name="TESTURL"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"

        Title="" Height="508.5" Width="822" ResizeMode="CanMinimize" WindowStartupLocation="CenterScreen" Cursor="Arrow" VerticalContentAlignment="Center" HorizontalContentAlignment="Center" ScrollViewer.VerticalScrollBarVisibility="Disabled" UseLayoutRounding="False" WindowStyle="None">
    <Window.Effect>
        <DropShadowEffect/>
    </Window.Effect>
    <Window.Background>
        <LinearGradientBrush EndPoint="0.5,1" MappingMode="RelativeToBoundingBox" StartPoint="0.5,0">
            <GradientStop Color="Black" Offset="0"/>
            <GradientStop Color="#FF8394FF" Offset="1"/>
        </LinearGradientBrush>
    </Window.Background>
    <Grid x:Name="ASTOOLGRID" Height="512" VerticalAlignment="Top">
        <TextBlock x:Name="MINItitle" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="10,10,10,0" Height="27" Width="237" Foreground="White" FontSize="24" FontFamily="Times New Roman" FontStretch="Condensed" Text="TESTURL" TextAlignment="Center"/>
        <Button x:Name="CARICALISTA" Content="Open URLs list" HorizontalAlignment="Left" Margin="5,155,0,0" VerticalAlignment="Top" Width="146" RenderTransformOrigin="0.423,0.7" ToolTip="Load the list of the URLs that will be automatically added to the favourite list"/>
        <ListBox x:Name="LISTAURL" HorizontalAlignment="Left" Height="126" VerticalAlignment="Top" Width="661" Margin="156,76,0,0">
            <ListBox.ContextMenu>
                <ContextMenu>
                    <MenuItem x:Name="Pulisci" Header="Clear list"></MenuItem>
                    <MenuItem x:Name="Browser" Header="BROWSE URL"></MenuItem>
                </ContextMenu>
            </ListBox.ContextMenu>
        </ListBox>
        <Button x:Name="STOP" Content="STOP" HorizontalAlignment="Left" Margin="5,76,0,0" VerticalAlignment="Top" Width="146"/>
        <TextBox x:Name="inttest" HorizontalAlignment="Left" Height="20" TextWrapping="Wrap" Text="Test Time" VerticalAlignment="Top" Width="145" Margin="5,128,0,0" FlowDirection="RightToLeft" HorizontalContentAlignment="Right"  Foreground = "Gray" IsEnabled="False" RenderTransformOrigin="-0.777,4.35" ToolTip="Set the time in seconds between each test of the urls in the list"/>
        <Button x:Name="START" Content="START" HorizontalAlignment="Left" Margin="5,50,0,0" VerticalAlignment="Top" Width="146" RenderTransformOrigin="0.167,0.625"/>
        <CheckBox x:Name="testcontinuo" Content="" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="131,131,0,0" RenderTransformOrigin="0.85,-1.133"/>
        <TextBox x:Name="ntent" HorizontalAlignment="Left" Height="20" TextWrapping="Wrap" Text="N° of attempts" VerticalAlignment="Top" Width="146" Margin="5,104,0,0"  Foreground = "Gray" IsUndoEnabled="True" RenderTransformOrigin="1.562,-3.525" ToolTip="Set how many times the test will be performed for each url in the list"/>
        <TextBox x:Name="url" HorizontalAlignment="Left" Height="20" TextWrapping="Wrap" Text="URL" VerticalAlignment="Top" Width="431" Margin="156,50,0,0" Foreground = "Gray" ToolTip="Type the URL including HTTP or HTTPS"/>
        <Button x:Name="AGGIUNGI_URL" Content="Add URL" HorizontalAlignment="Left" Margin="592,50,0,0" VerticalAlignment="Top" Width="110" RenderTransformOrigin="0.423,0.7" ToolTip="Add the URL typed to list"/>
        <Button x:Name="save" Content="SAVE" HorizontalAlignment="Left" VerticalAlignment="Top" Width="110" Margin="707,50,0,0" ToolTip="Save the output in CSV file"/>
        <DataGrid x:Name="output" HorizontalAlignment="Left" Height="280" VerticalAlignment="Top" Width="812" Margin="5,207,0,0">
            <DataGrid.Columns>
                <DataGridTextColumn x:Name="COLONNAURL" Binding="{Binding LISTA_URL}" ClipboardContentBinding="{x:Null}" Header="URL" FontSize="10" Width="300" IsReadOnly="true"/>
                <DataGridTextColumn x:Name="COLONNARESULT" Binding="{Binding LISTA_RESULT}" ClipboardContentBinding="{x:Null}" Header="RESULT" FontSize="10" Width="48" IsReadOnly="true"/>
                <DataGridTextColumn x:Name="COLONNACODE" Binding="{Binding LISTA_CODE}" ClipboardContentBinding="{x:Null}" Header="CODE" FontSize="10" Width="40" IsReadOnly="true"/>
                <DataGridTextColumn x:Name="COLONNATIME" Binding="{Binding LISTA_TIME}" ClipboardContentBinding="{x:Null}" Header="TIME" FontSize="10" Width="36" IsReadOnly="true"/>
                <DataGridTextColumn x:Name="COLONNAERROR" Binding="{Binding LISTA_ERROR}" ClipboardContentBinding="{x:Null}" Header="ERROR" FontSize="10" Width="378" IsReadOnly="true"/>
            </DataGrid.Columns>
        </DataGrid>
        <ProgressBar x:Name="progbar" HorizontalAlignment="Left" Height="13" VerticalAlignment="Top" Width="812" Margin="5,490,0,-2"/>
        <Label x:Name="counturl" Content="00" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="771,476,0,-6" Foreground="#FF000CFF" FontFamily="Elephant" FontSize="25" Visibility="Hidden"/>
        <Rectangle x:Name="move_main" Fill="#FFF4F4F5" HorizontalAlignment="Left" Height="46" Stroke="Black" VerticalAlignment="Top" Width="823" Opacity="0" Cursor="Hand"/>
        <Label x:Name="close_main" Content="X" HorizontalAlignment="Left" VerticalAlignment="Top" Foreground="White" Margin="795,3,0,0" FontWeight="Bold" Cursor="Hand" FontSize="21"/>
        <ComboBox x:Name="preferiti" HorizontalAlignment="Left" VerticalAlignment="Top" Width="146" Margin="5,180,0,0" HorizontalContentAlignment="Center" VerticalContentAlignment="Center" IsReadOnly="True">
            <ComboBoxItem Content="Favorites lists" IsSelected="True"/>
            <ComboBox.ContextMenu>
                <ContextMenu>
                    <MenuItem x:Name="eliminapreferito" Header="Delete Favorite"></MenuItem>
                </ContextMenu>
            </ComboBox.ContextMenu>
        </ComboBox>
    </Grid>
</Window>
"@

[xml]$xaml1 = @"
<Window Name="TESTURL_web"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"

        Title="" Height="595" Width="833" ResizeMode="CanMinimize" WindowStartupLocation="CenterScreen" Cursor="Arrow" VerticalContentAlignment="Center" HorizontalContentAlignment="Center" ScrollViewer.VerticalScrollBarVisibility="Disabled" UseLayoutRounding="False" WindowStyle="None">
    <Window.Effect>
        <DropShadowEffect/>
    </Window.Effect>
    <Window.Background>
        <LinearGradientBrush EndPoint="0.5,1" MappingMode="RelativeToBoundingBox" StartPoint="0.5,0">
            <GradientStop Color="Black" Offset="0"/>
            <GradientStop Color="#FF8394FF" Offset="1"/>
        </LinearGradientBrush>
    </Window.Background>
    <Grid x:Name="ASTOOLGRID" Height="601" VerticalAlignment="Top">
        <Grid.RowDefinitions>
            <RowDefinition/>
        </Grid.RowDefinitions>
        <TextBlock x:Name="MINItitle" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="298,10,298,0" Height="27" Width="236" Foreground="White" FontSize="24" FontFamily="Times New Roman" FontStretch="Condensed" Text="TESTURL" TextAlignment="Center" Cursor="Hand"/>
        <WebBrowser x:Name="web" HorizontalAlignment="Left" Height="543" VerticalAlignment="Top" Width="824" RenderTransformOrigin="0.49,0.49" Margin="4,46,0,0"/>
        <Rectangle x:Name="move" Fill="#FFF4F4F5" HorizontalAlignment="Left" Height="46" Stroke="Black" VerticalAlignment="Top" Width="838" Opacity="0" Cursor="Hand"/>
        <Label x:Name="close" Content="X" HorizontalAlignment="Left" VerticalAlignment="Top" Foreground="White" Margin="807,3,0,0" FontWeight="Bold" Cursor="Hand" FontSize="21"/>
        <Label x:Name="VIP" Content="VIP/IP: $ipurl" HorizontalAlignment="Left" VerticalAlignment="Top" Foreground="White" FontFamily="Segoe UI Semibold" FontSize="20" Margin="10,3,0,0" ToolTip="Double click for copy the IP to clipboard"/>
    </Grid>
</Window>
"@

$Reader = (New-Object System.Xml.XmlNodeReader $xaml) 
$TESTURL = [Windows.Markup.XamlReader]::Load($reader) 
$xaml.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]")  | ForEach-Object {New-Variable -Name $_.Name -Value $TESTURL.FindName($_.Name) -Force -ErrorAction SilentlyContinue}

$urlpath = Test-Path -Path "$Env:USERPROFILE\Documents\testurl"
if(!$urlpath){New-Item -Path "$Env:USERPROFILE\Documents\" -ItemType Directory -Name "testurl"}

$inttest.add_TextChanged({if ($inttest.Text -eq "Test Time"){$inttest.Foreground = "Gray";$timefortest = 0} else {$inttest.Foreground = "Black"}})
$inttest.Add_GotFocus({if ($inttest.Text -eq "Test Time"){$inttest.Text = ''}})
$inttest.Add_LostFocus({if ($inttest.text -eq ''){$inttest.Text = "Test Time"}})
$ntent.add_TextChanged({if ($ntent.Text -eq "N° of attempts"){$ntent.Foreground = "Gray";$ntest = 1} else {$ntent.Foreground = "Black"}})
$ntent.Add_GotFocus({if ($ntent.Text -eq "N° of attempts"){$ntent.Text = ''}})
$ntent.Add_LostFocus({if ($ntent.text -eq ''){$ntent.Text = "N° of attempts"}})
$url.add_TextChanged({if ($url.Text -eq "URL"){$url.Foreground = "Gray"} else {$url.Foreground = "Black"}})
$url.Add_GotFocus({if ($url.Text -eq "URL"){$url.Text = ''}})
$url.Add_LostFocus({if ($url.text -eq ''){$url.Text = "URL"}})

$testcontinuo.Add_Checked{$inttest.IsEnabled = $true; $timetest = 1}
$testcontinuo.Add_Unchecked{$inttest.IsEnabled = $false; $timetest = 0; $inttest.text = "Test Time"}

$url.Add_KeyDown({if ($_.Key -eq 'Enter'){if($url.Text -ne "URL"){[void]$LISTAURL.AddChild($url.Text)}}})

$urllistfile = (Get-ChildItem $Env:USERPROFILE\Documents\testurl -Filter "*.txt").Name -replace ".txt",""
foreach($file in $urllistfile){[void]$preferiti.Items.add($file)}

$preferiti.Add_SelectionChanged{
$LISTAURL.Items.Clear()
$temptxt = $preferiti.SelectedItem + ".txt"
$txtIMPORTED1 = Get-Content "$Env:USERPROFILE\Documents\testurl\$temptxt"
foreach($riga in $txtIMPORTED1){[void]$LISTAURL.AddChild($riga)}
}

function ftesturl{
$START.IsEnabled = $false
$CARICALISTA.IsEnabled = $false
$AGGIUNGI_URL.IsEnabled = $false
$save.IsEnabled = $false
$ntent.IsReadOnly = $true
$inttest.IsReadOnly = $true
$url.IsReadOnly = $true
$testcontinuo.IsEnabled = $false
$preferiti.IsEnabled = $false
$counturl.Visibility = "Visible"

if($inttest.Text -eq "Test Time"){$timefortest=0} else {$timefortest = $inttest.Text}
if($ntent.Text -eq "N° of attempts"){$ntest=1} else {$ntest = $ntent.Text}
$urls = $LISTAURL.Items
$saveout = $null

$OUTPUT.Items.Clear()
$obj = $null

$runrange = @(1..$ntest)

foreach($n in $runrange){
$z = 1
$progbar.Value = 0
$progbar.Maximum = $LISTAURL.Items.Count
$counturl.Content = $LISTAURL.Items.Count
$y = $LISTAURL.Items.Count - 1

foreach($obj in $urls){
$jobvar = @("obj")
$global:tester = $ntest

$progbar.Value = $z++
$counturl.Content = $y--

Start-Job -Name backgroundtest -ScriptBlock { 
#[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

#$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
#[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
#[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

$OUTPUTjob = $null
$row = New-Object -TypeName PSObject

try{
$outurl = $using:obj

$test = [System.Net.WebRequest]::Create("$outurl")
$test.Timeout = 10000
$test1 = $test.GetResponse()
$test2 = $test1.StatusCode
$test3 = [int]$test1.StatusCode

} catch [System.Net.WebException]{
$row | Add-Member -MemberType NoteProperty -Name "url" -Value $outurl
$row | Add-Member -MemberType NoteProperty -Name "result" -Value "KO"
$row | Add-Member -MemberType NoteProperty -Name "code" -Value $_.Exception.Response.StatusCode.value__
$row | Add-Member -MemberType NoteProperty -Name "error" -Value $_.Exception.Message
}

if ($test2 -eq 'OK'){
$timeTaken = Measure-Command -Expression {Invoke-WebRequest -Uri $outurl}
$milliseconds = $timeTaken.TotalMilliseconds
$milliseconds = [Math]::Round($milliseconds)

$row | Add-Member -MemberType NoteProperty -Name "url" -Value $outurl
$row | Add-Member -MemberType NoteProperty -Name "result" -Value $test2
$row | Add-Member -MemberType NoteProperty -Name "code" -Value $test3
$row | Add-Member -MemberType NoteProperty -Name "time" -Value $milliseconds
}

$row
}

$out = Receive-Job -Name backgroundtest -Wait -AutoRemoveJob

$OUTPUT.AddChild([pscustomobject]@{LISTA_URL=$out.url;LISTA_RESULT=$out.result;LISTA_CODE=$out.code;LISTA_TIME=$out.time;LISTA_ERROR=$out.error})

$OUTPUT.ScrollIntoView($OUTPUT.Items.GetItemAt($OUTPUT.Items.Count-1))
[System.Windows.Forms.Application]::DoEvents()

if($global:endfucntion -eq 1){break}

}
Start-Sleep $timefortest
}

$START.IsEnabled = $true
$CARICALISTA.IsEnabled = $true
$AGGIUNGI_URL.IsEnabled = $true
$save.IsEnabled = $true
$ntent.IsReadOnly = $false
$inttest.IsReadOnly = $false
$testcontinuo.IsEnabled = $true
$url.IsReadOnly = $false
$preferiti.IsEnabled = $true
$counturl.Visibility = "Hidden"

$global:balmsg = New-Object System.Windows.Forms.NotifyIcon
$path = (Get-Process -id $pid).Path
$balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
$balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
$balmsg.BalloonTipText = 'The test of the URL is compelted'
$balmsg.BalloonTipTitle = "TEST URL COMPLETED!"
$balmsg.Visible = $true
$balmsg.ShowBalloonTip(20000)
}

function save{
$salva1 = New-Object System.Windows.Forms.SaveFileDialog
$salva1.initialDirectory = "$Env:USERPROFILE\Documents\testurl"
$salva1.filter = "CSV files (*.csv)| *.csv"
$salva1.ShowDialog() | Out-Null
$output.Items | Export-Csv -Path $salva1.filename -NoTypeInformation
}

$CARICALISTA.Add_Click{
$LISTAURL.Items.Clear()
$aprilista = New-Object System.Windows.Forms.OpenFileDialog
$aprilista.initialDirectory = "$Env:USERPROFILE\Documents\testurl"
$aprilista.filter = "TXT files (*.txt)| *.txt"
$aprilista.ShowDialog() | Out-Null
$listaimportata = Get-Content $aprilista.FileName
foreach($riga in $listaimportata){[void]$LISTAURL.AddChild($riga)}

if ($listaimportata){
$preferiti.Items.Clear()
[void]$preferiti.AddChild("Liste preferite")
Copy-Item -Path $aprilista.FileName -Destination "$Env:USERPROFILE\Documents\testurl"
$urllistfile = (Get-ChildItem $Env:USERPROFILE\Documents\testurl -Filter "*.txt").Name -replace ".txt",""
foreach($file in $urllistfile){[void]$preferiti.Items.add($file)}
$preferiti.SelectedItem = $aprilista.SafeFileName -replace ".txt",""
}
}
$LISTAURL.Add_MouseDoubleClick{$LISTAURL.Items.RemoveAt($LISTAURL.SelectedIndex)}
$AGGIUNGI_URL.Add_Click{if($url.Text -ne "URL"){[void]$LISTAURL.AddChild($url.Text)}}

$Pulisci.Add_Click{$LISTAURL.Items.Clear()}

$eliminapreferito.Add_Click{
if($preferiti.SelectedItem -ne "Liste preferite"){
$filetoremove = $preferiti.SelectedItem + ".txt"
Remove-Item -Path "$Env:USERPROFILE\Documents\testurl" -Filter $filetoremove -Recurse
$preferiti.Items.Clear()
[void]$preferiti.AddChild("Liste preferite")
$urllistfile = (Get-ChildItem $Env:USERPROFILE\Documents\testurl -Filter "*.txt").Name -replace ".txt",""
foreach($file in $urllistfile){[void]$preferiti.Items.add($file)}
$preferiti.SelectedIndex = 0
}
}

$Browser.Add_Click{
$Reader = (New-Object System.Xml.XmlNodeReader $xaml1) 
$TESTURL_web = [Windows.Markup.XamlReader]::Load($reader) 
$xaml1.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]")  | ForEach-Object {New-Variable -Name $_.Name -Value $TESTURL_web.FindName($_.Name) -Force -ErrorAction SilentlyContinue}

[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

$move.Add_MouseLeftButtonDown({$TESTURL_web.DragMove()})
$close.Add_MouseLeftButtonDown({$TESTURL_web.close()})

$vip1 = [System.Net.WebRequest]::Create($LISTAURL.SelectedItem)
$vip2 = $vip1.Host -replace ":...",""
$ipurl = (Test-Connection $vip2 -Count 1).IPV4Address.IPAddressToString

$VIP.Content = "VIP/IP: $ipurl"

$VIP.Add_MouseDoubleClick{Set-Clipboard $ipurl
$global:balmsg = New-Object System.Windows.Forms.NotifyIcon
$path = (Get-Process -id $pid).Path
$balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
$balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
$balmsg.BalloonTipText = 'IP available in the clipboard'
$balmsg.BalloonTipTitle = "IP COPIED IN THE CLIPBOARD"
$balmsg.Visible = $true
$balmsg.ShowBalloonTip(20000)
}

$web.Navigate($LISTAURL.SelectedItem)
$TESTURL_web.ShowDialog() | out-null
}

$START.Add_Click{$global:endfucntion = 0; ftesturl}
$STOP.Add_Click{$global:endfucntion = 1
$START.IsEnabled = $true
$CARICALISTA.IsEnabled = $true
$AGGIUNGI_URL.IsEnabled = $true
$ntent.IsReadOnly = $false
$inttest.IsReadOnly = $false
$testcontinuo.IsEnabled = $true
$url.IsReadOnly = $false
$preferiti.IsEnabled = $true
$counturl.Visibility = "Hidden"
}
$save.Add_Click{save}

$move_main.Add_MouseLeftButtonDown({$TESTURL.DragMove()})
$close_main.Add_MouseLeftButtonDown({$TESTURL.close()})


$TESTURL.ShowDialog() | out-null