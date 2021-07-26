# Easy-Build GUI For Razzle
*Final update for foreseeable future due to lack of time*

This update is **UNTESTED**

Just a small script I made and use when building NT5 for a quick lazy mans build. Adapted so others can use.
**THIS IS IN TESTING, YOU MAY ENCOUNTER ERRORS**
**NOTE: This isn't a new build environment, it is a wrapper for Razzle**

![](https://github.com/Empyreal96/easy-build-nt5/raw/main/easy-build.png)



```
** What's New This Update?**

- Tried to improve x64 Detection
- Removed the ugly 'Self extracting' tools and included them in the repo.
- Removed Patcher due to outdated Patch links and files
- Merged 'easybuild64' and 'easybuild' to try allow building both Arch with a single script
 - To build for AMD64 type: easybuild.cmd free x64
- Added Link to Patch folder
- Added some checks for the Auto Build options
- Removed 'timeout' command to help compat with older OSs
- General housekeeping or some issues

```



**easy-build.cmd:**

**What is it exactly? **

- *It is an easy to use 'frontend' to the NT5 Razzle Build Environment and 4chan/OpenXP Patches* 

- *Easy to use (I hope)*

**How to use?**

- Just copy to the same folder as 'razzle.cmd', double-click, it will ask for UAC, detect if user is 32 or 64 bit, then loads razzle + easy-build

- Run 'easy-build.cmd chk' from a shortcut to launch Debug builds

- Run ''easy-build.cmd free x64' to start the AMD64 build. You NEED the build type when loading for AMD64.
  
- **What can it do?**
  
  - One-Click for Build, Postbuild, and ISO creation
  - Automatically detect Host Architecture and load the required razzle
  - Easy switching between:
    - Prerelease and Retail
    - Free and Checked
    - Timebomb Expiration Days
  - Easy access build Error Logs
  - Display Build Environment Info
  - Provide Links to 'Official' Build Guide
  - Checks in place to prevent building without missing files
  
  **Note: This script uses 7za.exe and 7za.dll from "https://www.7-zip.org/download.html" The source can be found there.**
  
  
