# AD Group Sync

**AD Group Sync** is a tool designed to synchronize group memberships between a reference user and a target user in Active Directory. This tool is ideal for administrators who need to ensure consistent group memberships across users.

## Requirements

- **Active Directory Module**: The tool relies on the Active Directory module for PowerShell.
- **Administrative Privileges**: You must have sufficient permissions to modify group memberships in Active Directory.

## Usage

1. **Run the EXE File**:
   - Launch the `ADGroupSync.exe` file by double-clicking it or executing it from the command line.
   
2. **Enter User Logins**:
   - When prompted, input the logins of the reference user and the target user.

3. **Group Synchronization**:
   - The tool will display a list of groups the reference user is a member of and automatically add the target user to any groups they are not currently a member of.

4. **Completion**:
   - Once the synchronization is complete, the tool will notify you of the groups to which the target user was added.

## Notes

- **Error Handling**: The tool provides clear error messages if a user or group cannot be found or if any issues arise during the synchronization process.
- **Group Validation**: It verifies the existence of groups before attempting to add the target user, ensuring that no invalid groups are processed.

## License

This tool is provided under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contributing

Contributions are welcome. Please open an issue or submit a pull request on GitHub.

## Download

You can download the tool and the associated script from the [Releases](https://github.com/dhaoloth/ADGroupSync/releases) page.

## Contact

For any questions or issues, please open an issue on GitHub or contact (dmitry.yab@yandex.ru).
