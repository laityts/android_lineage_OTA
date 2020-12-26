#!/bin/bash
#

device="tiffany"
buildprop="out/target/product/$device/system/build.prop"
zip_name=$(stat -c %n out/target/product/$device/lineage*-UNOFFICIAL-$device.zip)

if [ -f $device.json ]; then
  rm $device.json
fi

linenr=`grep -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
datetime=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
filename=`basename "$zip_name"`
md5=`md5sum "$zip_name" | cut -d' ' -f1`
size=`stat -c "%s" "$zip_name"`
version=$(echo ${filename:8:4})

echo '{
  "response": [
    {
        "datetime": '$datetime',
        "filename": "'$filename'",
        "id": "'$md5'",
        "romtype": "unofficial",
        "size": '$size',
        "url": "'https://sourceforge.net/projects/tiffany-project/files/Lineage/$filename/download'",
        "version": "'$version'"
    }
  ]
}' >> lineage_$device.json
