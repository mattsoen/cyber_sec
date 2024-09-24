This repository contains a collection of reusable Wireshark-related scripts designed to automate and assist with packet capture activities.

Overview:

This directory features PowerShell scripts designed to be help automate packet capture. Each of these scripts are adaptable, allowing you to easily customize them for your own projects and capturing needs.

Prerequisites:

Ensure Wireshark is installed on your system.
Make sure you have PowerShell available to run the scripts.

License:

This project is licensed under the MIT License.

Documentation:

Each file has an associated .md file outlining key details for reference.

Files:

dumpcap_ring_buffer.ps1 - This script automatically captures and saves packet data to a series of ring-buffered files. This is based on learnings from the Wireshark Ultimate course.

tshark_analyse_pcaps.ps1 - This script automatically analyses pcap files for typical security vulnerabilities and incidents. This is based on learnings from the Wireshark Ultimate course.
