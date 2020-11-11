# Easy-Build GUI For Razzle
Just a small script I made and use when building NT5 for a quick lazy mans build. Adapted so others can use.

There will be updates over time, I need feedback and suggestions to make improvements
THIS IS IN TESTING, YOU MAY ENCOUNTER ERRORS
NOTE: This isn't a new build environment, it is a wrapper for Razzle

Join the Telegram group!
http://t.me/joinchat/TTfPwUpDx4b0ywMFLSjKyg

![](https://github.com/Empyreal96/easy-build-nt5/raw/main/easy-build.png)

![](https://github.com/Empyreal96/easy-build-nt5/raw/main/easy-patcher.png)



```
** What's New This Update?**

- Added Easy-Patcher GUI Source patch downloader as well as its source
- Added prebuild, File attribute checks
- Updated log options to open warning logs aswell
- Replaced Postbuild's timeout when complete, to a pause.
- Fixed a few typos
```



```
**Last Update:**

Added Features:
	- Added option to set Timebomb.cmd expiration date.
	- Files that need modifying will now be modified by 'replace.vbs' VBScript which is created by Easy-Build and placed in razzle tool path.
	- Building Specific Directories
	- Switching types CHK and FRE (NEED TO TEST BUILDING AFTER CHANGE)
	- Switching Retail and Prerelease (also updates build/postbuild paths)

Fixes and tweaks: 
	- Replaced some 'timeouts' with a pause.
	- Replaced some vars to avoid issues with added fearures this update.
	- Input from user is case insensitive now to avoid issues.
	- Display latest 4chan patch.
	- UI improvements


```

**easy-build.cmd:**

- *What is it exactly? **
  - *It is an easy to use 'frontend' to the NT5 Razzle Build Environment and 4chan/OpenXP Patches* 

  - *Easy to use (I hope)*
- **How to use?**
- Just copy to the same folder as 'razzle.cmd', double-click, it will ask for UAC, detect if user is 32 or 64 bit, then loads razzle + easy-build

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
