1.  Add a botan source tree. Prefered source is https://github.com/randombit/botan. 
    Download and unpack a zip archive or repo here and name the result after the following scheme:
    botan-<version>-src, for example: botan-1.10-src/<botan-sources-go-here> 
2.  Set the required version in config.bat (Package_Version) accordingly.
3.  Check the settings of ..\common\config.bat and fire up build, install or package depending on the task. 

The source of FindBotan.cmake is here: https://github.com/corebob/libbitmessage