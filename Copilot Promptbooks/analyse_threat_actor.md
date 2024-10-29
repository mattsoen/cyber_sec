# Documentation for Analyse Threat Actor Profile Promptbook Template

## Overview
This promptbook generates a report profiling a known actor with suggestions for protecting against common tools and tactics.

## Template Details

### Tags
- **`Threat Actor`**
- **`TTP`**

### Inputs
- **`ACTOR`**: The name of the Microsoft Defender Threat Intelligence threat actor to analyse. *(Type: string)*

### Plugins
- **`Microsoft Defender Threat Intelligence`**

## Prompts

1. **Profile Summary**  
   Provide a profile summary of `<ACTOR>`, including an executive summary at the start.

2. **Tactics, Techniques, and Procedures (TTPs)**  
   Summarise the tactics, techniques, and procedures (TTPs) of this actor using MITRE ATT&CK techniques. Format the output as a bullet-point list, starting with the technique name and number, including a brief summary. Each technique should link directly to the MITRE ATT&CK website.

3. **Threat Intelligence Articles**  
   If there are threat intelligence articles related to this threat actor, provide a list and summary of them, including links to the source material.

4. **Mitigation and Defense Methods**  
   Based on the actor's TTPs, what would be effective mitigation or defense methods to protect against this threat actor? Begin with specific examples and conclude with more generic ones. Format the output as a table with sections for:
   - **Category**
   - **Description** (including the work to be done)
   - **Reason** (with an example of why it relates to the threat actor)

5. **Executive Report Summary**  
   Summarise insights about the threat actor in an executive report. Begin with metadata points including aliases, suspected origin country, targeted industries, exploited vulnerabilities, and tools leveraged, formatted as CSV and kept brief. Follow with a bullet-point list of key points about the threat actor as an executive summary. Then, create paragraph sections for an overview, TTPs, and mitigation strategies, ensuring it’s suitable for a less technical audience.

## How to Run
1. **Prerequisites**: Ensure that you have appropriate access to run the promptbook and access to the required data sources.
2. **Inputs**: You can pass inputs directly at runtime.

## Customisation
- **PROMPTS**: Modify the wording of the prompts to suit your reporting format or analysis needs.

## License
This template is provided under the MIT License. See the root LICENSE file for details.
