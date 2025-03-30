# DirTree Command

A simple utility for Windows that captures directory structures to text files.

## Overview

The `dirtree` command allows you to quickly generate a text file containing the complete hierarchy of files and folders in any directory. It works from any location in your command prompt, making it a convenient tool for documentation and analysis of file systems.

## Installation

1. Download the `capture_directory.bat` script
2. Right-click the script and select "Run as administrator"
3. The installation script will:
   - Create a `Scripts` folder in your user profile directory
   - Set up the `dirtree.bat` command file
   - Add the Scripts folder to your PATH environment variable

4. Restart any open command prompts for the changes to take effect

## Usage

```
dirtree
```
Captures the structure of the current directory to `directory_structure.txt`

```
dirtree C:\path\to\directory
```
Captures the structure of the specified directory

## Features

- Creates detailed text representation of directories and files
- Works from any location in your command prompt
- Includes file names (not just directories)
- Adds timestamp and directory information to the output
- Saves the output to a text file for easy reference
- Uses ASCII characters for maximum compatibility

## Output Example

```
Directory Structure captured on Mon 03/30/2025 at 14:32:45.67
Starting directory: C:\Projects\MyProject\
========================================================

C:\PROJECTS\MYPROJECT
│   .gitignore
│   package.json
│   README.md
│   
├───dist
│       bundle.js
│       index.html
│       
├───src
│   │   index.js
│   │   
│   ├───components
│   │       Button.js
│   │       Input.js
│   │       
│   └───utils
│           helpers.js
│           
└───tests
        Button.test.js
```

## Troubleshooting

If the `dirtree` command is not recognized after installation:

1. Make sure you've restarted your command prompt
2. Verify that the Scripts directory was added to your PATH by running:
   ```
   echo %PATH%
   ```
3. If it's missing, manually add `%USERPROFILE%\Scripts` to your PATH environment variable

## Uninstallation

To uninstall the command:

1. Delete the file: `%USERPROFILE%\Scripts\dirtree.bat`
2. Optionally, remove the Scripts folder from your PATH environment variable:
   - Open System Properties > Advanced > Environment Variables
   - Edit the PATH variable and remove the entry for `%USERPROFILE%\Scripts`

## How It Works

The command uses the built-in Windows `tree` command with the `/F` flag to include files and the `/A` flag to use ASCII characters for compatibility. It redirects this output to a text file with additional header information.

## License

This script is provided as-is under the MIT License. Feel free to modify and distribute as needed.
