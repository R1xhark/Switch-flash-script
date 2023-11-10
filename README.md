# Switch Flash Script

This script automates the flashing process for specific network switches. It checks the status of the switch and initiates the flashing procedure if necessary.

## Prerequisites

Before using this script, ensure that you have the following:

- Bash shell
- Screen utility
- SSH access to the switches

## Usage

1. Clone the repository:

   \`\`\`bash
   git clone https://github.com/your-username/switch-flash-script.git
   cd switch-flash-script
   \`\`\`

2. Make the script executable:

   \`\`\`bash
   chmod +x switch_flash_script.sh
   \`\`\`

3. Run the script:

   \`\`\`bash
   ./switch_flash_script.sh
   \`\`\`

4. Follow the on-screen prompts to enter the Switch SN and IP.

5. Monitor the script's output for the flashing process.

6. Optionally, enter another switch or exit the script when prompted.

## Notes

- If a switch is already in the flashing process, the script will notify you.

- The script will verify the switch model and the current firmware version before initiating the flashing procedure.

- Ensure that the required remote switch flashing scripts (\`remote_switch_flash_c8260.sh\`, \`remote_switch_flash_as.sh\`, \`remote_switch_flash_cs.sh\`) are in the specified locations.

## Exiting the Script

To exit the script at any time, enter 'k' when prompted for Switch SN or IP. Additionally, you can choose not to enter another switch when prompted.

## Contributing

Feel free to contribute to the development of this script. Fork the repository, make your changes, and submit a pull request.

## Issues

If you encounter any issues or have suggestions, please open an issue on GitHub.

## Licence
This script is not under any license, feel free to modify it, use it and edit it as you wish :)
