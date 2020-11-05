# Easy-Build GUI For Razzle
Just a small script I made and use when building NT5 for a quick lazy mans build. Adapted so others can use.

There will be updates over time, I need feedback and suggestions to make improvements

NOTE: This isn't a new build environment, it is a wrapper for Razzle

![](https://github.com/Empyreal96/easy-build-nt5/raw/main/easy-build.png)



```
**What's new?**

Added Features:
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



```
**Previous changes**
	- Added checks so that the script cannot run without razzle present
	- Added checks so user cannot postbuild or make ISO with files missing (missing files not provided)
	- Added 'First Run' screen (it will only show on very first load)
	- Made sure we can load 64 bit env successfully
	- Added an 'info' page 
	- All options should work now
```



- **easy-build.cmd:**

  *What is it exactly?*

  - *It is an easy to use 'frontend' to the NT5 Razzle Build Environment and 4chan/OpenXP Patches*

  - *Easy to use (I hope)*

- How to use?

  Just copy to the same folder as 'razzle.cmd', double-click, it will ask for UAC, detect if user is 32 or 64 bit, then loads razzle + easy-build

