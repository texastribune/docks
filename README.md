This is an attempt to put all the requirements necessary to do headless browser
testing in one docker image and a script to run some of those tests (most
likely through a CI).

The script will run YSLow and sitespeed.io.

The script will output a 'yslow.xml' file for the base URL, a TAP file for each
URL, and sitespeed HTML output for the base URL.  All of this is left in the
"/results" volume.
