# Easy-Build GUI For Razzle (AMD64 Update)
Just a small script I made and use when building NT5 for a quick lazy mans build. Adapted so others can use.

There will be updates over time, I need feedback and suggestions to make improvements
THIS IS IN TESTING, YOU MAY ENCOUNTER ERRORS
NOTE: This isn't a new build environment, it is a wrapper for Razzle

Join the Matrix group!

https://matrix.to/#/!febkSwamiedCsfevDe:matrix.org?via=matrix.org

![](https://github.com/Empyreal96/easy-build-nt5/raw/main/easy-build.png)

![](https://github.com/Empyreal96/easy-build-nt5/raw/main/easy-patcher.png)



```
** What's New This Update?**

- Added first attempt at a fully Automatic Build through (Prebuild to ISO Creation)

```



**easy-build.cmd:**

**What is it exactly? **

- *It is an easy to use 'frontend' to the NT5 Razzle Build Environment and 4chan/OpenXP Patches* 

- *Easy to use (I hope)*

**How to use?**

- Just copy to the same folder as 'razzle.cmd', double-click, it will ask for UAC, detect if user is 32 or 64 bit, then loads razzle + easy-build

- Run 'easy-build.cmd chk' from a shortcut to launch Debug builds

- Run 'easy-build64.cmd' to start the AMD64 build
  
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
  
  **Note: This script uses 7za.exe and 7za.dll (encoded in/extracted from base64) from "https://www.7-zip.org/download.html" The source can be found there.**
  
  **This Tool also uses WGET from here: https://eternallybored.org/misc/wget/**
  
  
