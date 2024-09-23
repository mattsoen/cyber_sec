# Define parameters
$NumFiles = 5                                               # Number of files in the ring buffer
$OutputBase = "C:\Path\To\Your\Directory\dumpcap_output"    # Base name for output files
$MaxFileSize = 500000                                       # Maximum file size in kilobytes
$CaptureInterface = "1"                                     # Network interface index 
$DumpcapPath = "C:\Program Files\Wireshark\dumpcap.exe"     # Path to dumpcap.exe

# Rotate existing files
for ($i = $NumFiles - 1; $i -gt 0; $i--) {
    $oldFile = "${OutputBase}_${i}.pcap"
    $newFile = "${OutputBase}_$($i + 1).pcap"
    if (Test-Path $oldFile) {
        Rename-Item -Path $oldFile -NewName $newFile
    }
}

# Run dumpcap and output to the first file with a file size limit
$dumpcapCommand = "& `"$DumpcapPath`" -i $CaptureInterface -a filesize:$MaxFileSize -w `${OutputBase}_0.pcap"
Invoke-Expression $dumpcapCommand
