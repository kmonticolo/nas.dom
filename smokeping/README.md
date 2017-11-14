# smokeping list config howto

select all href to lista file

`cat lista |sed -e 's/^.*HREF="//g' -e 's/".*$//g' -e \
's/^/lim.smokeping.ovh.net\/smokeping/g' >lista2`

`cat lista |sed -e 's/^.*HREF="\?target=//g' -e 's/".*$//g' >asy`

```for as in `cat asy` ; do curl -o $as lim.smokeping.ovh.net/smokeping?target=$as; done```

parser:

cat x.sh
```
id=`echo $1 | sed 's/\./_/'`

menu=`grep menuactive $1 |sed -e 's/^.*">//g' -e 's/\&nbsp\;/\ /g' -e 's/<.*$//g'`

title=`grep \<title $1 |sed -e 's/\<"\>//g' -e 's/<title>.*for\ //g' -e 's/<\/title>//g'`

ip=`grep \<title $1 |sed -e 's/\<"\>//g' -e 's/<title>//g' -e 's/<\/title>//g' -e 's/.*\ //g' -e 's/.$//g'`

echo +++ $1
echo menu = $menu
echo title = $title
echo host = $ip
echo
```
 
``` for i in `cat asy`;do ./x.sh $i;done >config```

  
