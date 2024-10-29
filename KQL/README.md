This repository contains a collection of reusable KQL scripts and templates designed for use in cybersecurity contexts.

## Overview
This directory features various KQL scripts that can assist incident responders to effectively query and analyse security-related data. Each script is designed to be adaptable, allowing you to easily customise them for your own projects and scanning needs.

## Prerequisites
None

## License
This project is licensed under the MIT License.

## Documentation
Each file has an associated .md file outlining key details for reference.

## Files
**failed_logins.kql** - This script queries for failed logins from sign-in logs. This is based on learnings from the Microsoft Security Operations Analyst course.

**high_risk_usres.kql** - This script queries for repeated, failed logins from high-risk users. This is based on learnings from the Microsoft Security Operations Analyst course.

**logon_logoff_events.kql** - This script queries logon and logoff events for accounts. This is based on learnings from the Microsoft Security Operations Analyst course.

**unusual_logins.kql** - This script queries for repeated, successful logins from unusual locations. This is based on learnings from the Microsoft Security Operations Analyst course.

**unusual_outbound_traffic.kql** - This script queries for outbound traffic to unusual destination countries. This is based on learnings from the Microsoft Security Operations Analyst course.
