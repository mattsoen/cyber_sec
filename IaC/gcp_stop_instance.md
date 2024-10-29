# Documentation for GCP Stop Instance YAML Script

## Overview
This YAML script is designed to stop a Google Cloud VM instance and assert its status. It first stops the instance, then checks if it has transitioned to the "TERMINATED" state.

## Script Details

### Main Workflow
- **Parameters**: 
  - `inputs`: Accepts input parameters such as project, zone, and instance name.
  
- **Steps**:
  1. **Stop Instance**:
     - **Call**: `googleapis.compute.v1.instances.stop`
     - **Arguments**:
       - `project`: The Google Cloud project ID, provided via `${inputs.project}`.
       - `zone`: The zone where the instance is located, provided via `${inputs.zone}`.
       - `instance`: The name of the instance to stop, provided via `${inputs.instance}`.
  
  2. **Assert Terminated**:
     - **Call**: `assert_machine_status`
     - **Arguments**:
       - `expected_status`: The expected status of the instance after stopping, set to "TERMINATED".
       - `project`: The Google Cloud project ID.
       - `zone`: The zone of the instance.
       - `instance`: The name of the instance.

### Assert Machine Status Workflow
- **Parameters**:
  - `expected_status`: The status that is expected after the instance is stopped.
  - `project`: The Google Cloud project ID.
  - `zone`: The zone where the instance is located.
  - `instance`: The name of the instance.

- **Steps**:
  1. **Get Instance**:
     - **Call**: `googleapis.compute.v1.instances.get`
     - **Arguments**:
       - `instance`: The name of the instance.
       - `project`: The Google Cloud project ID.
       - `zone`: The zone of the instance.
     - **Result**: Stores the result in the variable `instance`.

  2. **Compare Status**:
     - **Condition**: Checks if the `instance.status` is equal to `expected_status`.
     - **Next Step**: If the condition is true, proceeds to the `end` step.

  3. **Fail**:
     - **Action**: Raises an error if the instance status does not match the expected status.
     - **Message**: Outputs a message detailing the expected and actual status.

## How to Execute
1. **Prerequisites**: Ensure you have the necessary permissions and access to Google Cloud APIs to manage VM instances.
2. **Execution**:
   - Save the YAML script in your preferred execution environment that supports Google Cloud operations.
   - Provide the necessary inputs (project ID, zone, instance name) when running the script.

## Customisation
- **Expected Status**: You can modify the `expected_status` in the assert step to check for different VM statuses if needed.
- **Instance Details**: Change the `project`, `zone`, and `instance` values based on your specific Google Cloud setup.

## Notes
- Ensure that your Google Cloud project has the necessary API services enabled and that the appropriate IAM roles are assigned to execute these operations.
- Review the Google Cloud documentation for `compute.instances.stop` and `compute.instances.get` for additional context on these API calls.
- This script is intended to be used as part of a Google Cloud Workflows solution. In a cybersecurity context, a Cloud Workflow could be used to automatically stop an instance that is compromised.

## License
This YAML script is provided under the MIT License. See the root LICENSE file for details.
