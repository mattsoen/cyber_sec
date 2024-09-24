# Documentation for Dumpcap Ring Buffer Script

## Overview
This PowerShell script sets up a ring buffer for capturing network traffic using Wireshark's `dumpcap` utility. It manages the output files to ensure that only a specified number of capture files are retained, automatically rotating older files as new data is captured.

## Script Details

### Define Parameters
- **Purpose**: To configure the parameters for the packet capture.
- **Variables**:
  - **`$NumFiles`**: The total number of files to maintain in the ring buffer (default: `5`).
  - **`$OutputBase`**: The base name for the output files, where the captures will be stored (`"C:\Path\To\Your\Directory\dumpcap_output"`).
  - **`$MaxFileSize`**: The maximum file size for each capture file in kilobytes (default: `500000` KB).
  - **`$CaptureInterface`**: The network interface index to capture traffic from (default: `"1"`).
  - **`$DumpcapPath`**: The path to the `dumpcap.exe` executable (`"C:\Program Files\Wireshark\dumpcap.exe"`).

### Rotate Existing Files
- **Purpose**: To manage the output files by renaming them according to the ring buffer strategy.
- **Actions**:
  - Loops through the existing files in reverse order and renames them:
    ```powershell
    for ($i = $NumFiles - 1; $i -gt 0; $i--) {
        $oldFile = "${OutputBase}_${i}.pcap"
        $newFile = "${OutputBase}_$($i + 1).pcap"
        if (Test-Path $oldFile) {
            Rename-Item -Path $oldFile -NewName $newFile
        }
    }
    ```

### Run Dumpcap Command
- **Purpose**: To start capturing network traffic using `dumpcap` and store it in the first output file.
- **Actions**:
  - Constructs the command to execute `dumpcap` with the specified parameters:
    ```powershell
    $dumpcapCommand = "& `"$DumpcapPath`" -i $CaptureInterface -a filesize:$MaxFileSize -w `${OutputBase}_0.pcap"
    ```
  - Executes the command using `Invoke-Expression`:
    ```powershell
    Invoke-Expression $dumpcapCommand
    ```

## How to Run
1. **Prerequisites**:
   - Ensure that Wireshark is installed and `dumpcap.exe` is accessible at the specified path.
   - Open PowerShell with administrative privileges.

2. **Execution**:
   - Save the script as `DumpcapRingBuffer.ps1`.
   - Run the script in PowerShell:
     ```powershell
     .\DumpcapRingBuffer.ps1
     ```

## Customisation
- **Output Directory**: Modify the `$OutputBase` variable to specify where to save the capture files.
- **File Size Limit**: Adjust the `$MaxFileSize` if different file sizes are required.
- **Network Interface**: Change the `$CaptureInterface` to capture from a different network interface. Use the command `Get-NetAdapter` to find available interfaces and their indices.

## Notes
- Ensure you have sufficient permissions to capture network traffic and write files to the specified directory.
- Test the script in a controlled environment to confirm it works as expected before deploying it in production.

## License
This script is provided under the MIT License. See the root LICENSE file for details.
